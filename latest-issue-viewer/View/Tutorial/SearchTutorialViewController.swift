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
    
    func buttonStyle(){
        closeButton.backgroundColor = UIColor.green
        closeButton.setTitleColor(UIColor.red, for: .normal)
    }
    
    @IBAction func closeButtonAction(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
}
