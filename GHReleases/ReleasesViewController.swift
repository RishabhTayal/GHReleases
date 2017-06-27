//
//  ViewController.swift
//  GHReleases
//
//  Created by Tayal, Rishabh on 6/26/17.
//  Copyright © 2017 Tayal, Rishabh. All rights reserved.
//

import UIKit
import MWFeedParser
import SafariServices

class ReleasesViewController: UIViewController {
    
    @IBOutlet var tableView: UITableView!
    
    var repository: Repository?
    var items: [MWFeedItem] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = repository?.name
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = 64
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.fetchData(repository: repository!) { (d, error) in
            self.items = d!
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
}

extension ReleasesViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.releasesTableViewCell.identifier) as! ReleasesTableViewCell
        cell.config(item: items[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let svc = SFSafariViewController(url: URL.init(string: "https://github.com" + items[indexPath.row].link)!)
        self.present(svc, animated: true, completion: nil)
    }
}
