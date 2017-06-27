//
//  RepositoriesViewController.swift
//  GHReleases
//
//  Created by Tayal, Rishabh on 6/27/17.
//  Copyright © 2017 Tayal, Rishabh. All rights reserved.
//

import UIKit

class RepositoriesViewController: UIViewController {
    
    var repositories: [String] = ["fastlane/fastlane", "danger/danger"]
    @IBOutlet var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if let indexPath = tableView.indexPathForSelectedRow {
            tableView.deselectRow(at: indexPath, animated: true)
        }
    }
}

extension RepositoriesViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return repositories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.cell.identifier)
        cell?.textLabel?.text = repositories[indexPath.row]
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let repo = repositories[indexPath.row]
        let releasesVC = storyboard?.instantiateViewController(withIdentifier: R.storyboard.main.releasesViewController.identifier) as! ReleasesViewController
        releasesVC.repository = repo
        self.navigationController?.pushViewController(releasesVC, animated: true)
    }
}
