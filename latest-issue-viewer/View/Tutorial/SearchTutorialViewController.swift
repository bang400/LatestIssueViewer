//
//  SearchTutorialViewController.swift
//  latest-issue-viewer
//
//  Created by Yamato Baba on 2022/11/28.
//

import UIKit
import WebKit

class SearchTutorialViewController: UIViewController {
    
    @IBOutlet weak var tutorialWebView: WKWebView!
    @IBOutlet weak var closeButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        buttonStyle()
        loadHTML()
    }
    
    // チュートリアル htmlを読み込む
    func loadHTML() {
        guard let path: String = Bundle.main.path(forResource: "SearchTutorial", ofType: "html") else {return}
        print("path:\(path)")
        let localHTMLUrl = URL(fileURLWithPath: path, isDirectory: false)
        tutorialWebView.loadFileURL(localHTMLUrl, allowingReadAccessTo: localHTMLUrl)
    }
    
    // チュートリアルを閉じるボタンの装飾
    func buttonStyle(){
        closeButton.setTitle("チュートリアルを閉じる", for: .normal)
        closeButton.backgroundColor = UIColor(hex: "00bfff") //背景色 00bfff[deepskyblue]
        closeButton.tintColor = .white //文字色
        closeButton.layer.cornerRadius = 25 //角
    }
    
    @IBAction func closeButtonAction(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
}
