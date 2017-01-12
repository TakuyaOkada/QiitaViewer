//
//  SubViewController.swift
//  QiitaViewer
//
//  Created by OKADA Takuya on 2017/01/12.
//  Copyright © 2017年 Takuya OKADA. All rights reserved.
//

import UIKit

class SubViewController: UIViewController{
    @IBOutlet weak var webView: UIWebView!

    @IBAction func back(_ sender: UIButton) {
        self.dismiss(animated: false, completion: nil)
    }

    var selectedUrl: String = "http://www.google.co.jp"
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        loadUrl()
    }

    func loadUrl() {
        let requestURL = NSURL(string: selectedUrl)
        let request = NSURLRequest(url: requestURL as! URL)
        webView?.loadRequest(request as URLRequest)
    }
}
