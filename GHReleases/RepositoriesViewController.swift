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
//
//        var repo = Repository.instance(dict: ["owner": "fastlane", "name": "fastlane"])
//        repositories.append(repo)
//        repo = Repository.instance(dict: ["owner": "danger", "name": "danger"])
//        repositories.append(repo)
//        repo = Repository.instance(dict: ["owner": "RishabhTayal", "name": "GHReleases"])
//        repositories.append(repo)
        
        if let repos = UserDefaults.standard.array(forKey: UserDefaultsKey.Repositories) {
            for repoObj in repos {
                let repo = Repository.instance(dict: repoObj as! [String : Any])
                repositories.append(repo)
            }
        }
        
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
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let action = UITableViewRowAction.init(style: UITableViewRowActionStyle.destructive, title: "Delete") { (action, indexPath) in
            self.repositories.remove(at: indexPath.row)
            self.tableView.reloadSections([0], with: .automatic)
        }
        return [action]
    }
}

extension RepositoriesViewController: AddRepositoryVCDelegate {
    func addRepositoryVCDidAddRepo(repo: Repository) {
        self.repositories.append(repo)
        var repos = UserDefaults.standard.array(forKey: UserDefaultsKey.Repositories) ?? []
        repos.append(repo.toJSON())
        UserDefaults.standard.set(repos, forKey: UserDefaultsKey.Repositories)
        self.tableView.reloadData()
    }
}
