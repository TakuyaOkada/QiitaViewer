//
//  ArticleListViewController.swift
//  QiitaViewer
//
//  Created by OKADA Takuya on 2017/01/12.
//  Copyright © 2017年 Takuya OKADA. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class ArticleListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var articles: Array<Article> = []
    let table = UITableView()
    var refreshControl = UIRefreshControl()
    var selectedUrl: String = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "新着記事"
        
        table.frame = view.frame
        view.addSubview(table)
        table.dataSource = self
        table.delegate = self
        
        refreshControl.tintColor = UIColor.orange
        refreshControl.backgroundColor = UIColor.gray
        refreshControl.attributedTitle = NSAttributedString(string: "Fetching more data...", attributes: [NSForegroundColorAttributeName: refreshControl.tintColor])
        
        refreshControl.addTarget(self, action: #selector(ArticleListViewController.refreshData), for: UIControlEvents.valueChanged)
        
        if #available(iOS 10.0, *) {
            table.refreshControl = refreshControl
        } else {
            table.addSubview(refreshControl)
        }
            
        getArticles()
    }

    func refreshData() {
        getArticles()
        
        refreshControl.endRefreshing()
    }
    
    func getArticles() {
        Alamofire.request("https://qiita.com/api/v2/items", method: .get)
            .responseJSON {
                response in
                guard let object = response.result.value else {
                    return
                }
            
                self.articles = []
                let json = JSON(object)
                json.forEach { (_, json) in
                    let article = Article()
                    article.title = json["title"].string!
                    article.userId = json["user"]["id"].string!
                    article.url = json["url"].string!
                    self.articles.append(article)
                }
                self.table.reloadData()
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offset = (scrollView.contentOffset.y * -1)
        var message = "Keep pulling."

        switch offset {
        case 0...100:
            message = "Keep pulling."
        case 100...140:
            message = "Keep pulling..."
        case 140...160:
            message = "Keep pulling....."
        case 160...180:
            message = "Keep pulling......."
        case 180...200:
            message = "Keep pulling........."
        case 200...220:
            message = "Keep pulling..........."
        case 220...240:
            message = "Keep pulling............."
        case 240...260:
            message = "Keep pulling..............."
        case 260...280:
            message = "Keep pulling................."
        case 280...300:
            message = "Keep pulling..................."
        case _ where offset > 300:
            message = "OK, YOU CAN LET GO NOW!"
        default: break
        }
        
        refreshControl.attributedTitle = NSAttributedString(string: message, attributes: [NSForegroundColorAttributeName: refreshControl.tintColor])
        
        refreshControl.backgroundColor = UIColor.gray
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = CustomTableViewCell(style: .subtitle, reuseIdentifier: "cell")
        
        let article = articles[indexPath.row] // 行数番目の記事を取得
        cell.textLabel?.text = article.title // 記事のタイトルをtextLabelにセット
        cell.detailTextLabel?.text = article.userId // 投稿者のユーザーIDをdetailTextLabelにセット
        cell.url = article.url
        return cell
    }
    
    // Cell が選択された場合
    func tableView(_ table: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = table.cellForRow(at: indexPath) as! CustomTableViewCell
        selectedUrl = cell.url

        // SubViewController へ遷移するために Segue を呼び出す
        performSegue(withIdentifier: "toSubViewController",sender: nil)
    }
    
    // Segue 準備
    override func prepare(for segue: UIStoryboardSegue, sender: Any!) {
        if (segue.identifier == "toSubViewController") {
            let subVC: SubViewController = (segue.destination as? SubViewController)!
            subVC.selectedUrl = selectedUrl
        }
    }
    
}
