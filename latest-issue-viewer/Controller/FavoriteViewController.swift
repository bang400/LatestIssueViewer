//
//  FavoriteViewController.swift
//  latest-issue-viewer
//
//  Created by 馬場大和 on 2022/05/04.
//

import UIKit
import RealmSwift

class FavoriteViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet weak var favorite_table_view: UITableView!
            
    // Realmインスタンスの取得
    let realm = try! Realm()
    var favoriteList:List<Favorite>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // favoriteListの一番目にアイテムが入ってたら返す
        favoriteList = realm.objects(FavoriteList.self).first?.favList
        // テーブルの登録
        favorite_table_view.register(UINib(nibName: "FavoriteTableViewCell", bundle: nil), forCellReuseIdentifier: "favoriteTableView")
        // ナビゲーションバーの設定
        navigationItem.rightBarButtonItem = editButtonItem
        // テーブルビューの更新
        favorite_table_view.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // テーブルビューの更新
        favorite_table_view.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return realm.objects(Favorite.self).count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "favoriteTableView", for: indexPath) as! FavoriteTableViewCell
        
        if let favoriteItem = favoriteList?[indexPath.row] {
            print(favoriteItem.title)
            // 本のタイトル
            cell.favoriteTitle_label.text = favoriteItem.title
            // 本の発売日
            cell.releaseDate_label.text  = favoriteItem.salesDate
            
            // 本の画像を表示する
            if let urlString = favoriteItem.mediumImageUrl {
                let url = URL(string: urlString)
                do{
                    let imageData = try Data(contentsOf: url!)
                    cell.favorite_imageView.image = UIImage(data: imageData)
                } catch {
                    print("画像が取得できませんでした。")
                }
            }else{
                //nilの場合は固定画像表示
                cell.favorite_imageView.image = UIImage(named: "dog2")
            }
        }else{
            // 本のタイトル
            print("No Data")
        }
                
        return cell
    }
    
    // セルの高さ
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
        
    // 設定ボタンを押された時
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        favorite_table_view.setEditing(editing, animated: animated)
        favorite_table_view.isEditing = editing
    }
    
    //並び替え時の処理
    func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
        try! realm.write{
            let favoriteItem = favoriteList[fromIndexPath.row]
            // fromIndexPath.rowは移動する前のセル
            favoriteList.remove(at: fromIndexPath.row)
            // to.rowは移動した後のセル
            favoriteList.insert(favoriteItem, at: to.row)
        }
    }
    //並び替えを可能にする
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    //リストを削除する
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            try! realm.write{
                // realmDBの削除操作
                let favoriteItem = favoriteList[indexPath.row]
                realm.delete(favoriteItem)
            }
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
}
