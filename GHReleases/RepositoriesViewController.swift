//
//  RepositoriesViewController.swift
//  GHReleases
//
//  Created by Tayal, Rishabh on 6/27/17.
//  Copyright © 2017 Tayal, Rishabh. All rights reserved.
//

import UIKit

class RepositoriesViewController: UIViewController {
    
    var repositories: [Repository] = []
    @IBOutlet var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var repo = Repository.init(dict: ["owner": "fastlane", "name": "fastlane"])
        repositories.append(repo)
        repo = Repository.init(dict: ["owner": "danger", "name": "danger"])
        repositories.append(repo)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if let indexPath = tableView.indexPathForSelectedRow {
            tableView.deselectRow(at: indexPath, animated: true)
        }
    }
    
    @IBAction func addTapped(_ sender: Any) {
        let addRepoVC = storyboard?.instantiateViewController(withIdentifier: R.storyboard.main.addRepositoryViewController.identifier) as! AddRepositoryViewController
        addRepoVC.delegate = self
        self.present(UINavigationController.init(rootViewController: addRepoVC), animated: true, completion: nil)
    }
}

extension RepositoriesViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return repositories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.cell.identifier)
        let repo = repositories[indexPath.row]
        cell?.textLabel?.text = repo.owner + "/" + repo.name
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let repo = repositories[indexPath.row]
        let releasesVC = storyboard?.instantiateViewController(withIdentifier: R.storyboard.main.releasesViewController.identifier) as! ReleasesViewController
        releasesVC.repository = repo
        self.navigationController?.pushViewController(releasesVC, animated: true)
    }
}

extension RepositoriesViewController: AddRepositoryVCDelegate {
    func addRepositoryVCDidAddRepo(repo: Repository) {
        self.repositories.append(repo)
        self.tableView.reloadData()
    }
}
