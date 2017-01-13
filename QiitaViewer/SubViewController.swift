//
//  SubViewController.swift
//  QiitaViewer
//
//  Created by OKADA Takuya on 2017/01/12.
//  Copyright © 2017年 Takuya OKADA. All rights reserved.
//

import UIKit
import WebKit

class SubViewController: UIViewController{
    var webView: WKWebView?

    @IBAction func back(_ sender: UIButton) {
        self.dismiss(animated: false, completion: nil)
    }

    var selectedUrl: String = "http://www.google.co.jp"
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        loadUrl()
        self.view.addSubview(webView!)
    }

    func loadUrl() {
        let requestURL = URL(string: selectedUrl)
        let request = URLRequest(url: requestURL!)
        
        self.webView = WKWebView(frame: CGRect(x: 0, y: 70, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height - 70))
        self.webView?.load(request)
    }
}
