//
//  AddRepositoryViewController.swift
//  GHReleases
//
//  Created by Tayal, Rishabh on 6/27/17.
//  Copyright © 2017 Tayal, Rishabh. All rights reserved.
//

import UIKit

protocol AddRepositoryVCDelegate {
    func addRepositoryVCDidAddRepo(repo: Repository)
}

class AddRepositoryViewController: UIViewController {
    
    @IBOutlet weak var ownerNameTF: UITextField!
    @IBOutlet weak var repoNameTF: UITextField!
    
    var delegate: AddRepositoryVCDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func cancelTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func addTapped(_ sender: Any) {
        let repo = Repository.instance(dict: ["owner": ownerNameTF.text, "name": repoNameTF.text])
        if let delegate = delegate {
            delegate.addRepositoryVCDidAddRepo(repo: repo)
        }
        self.dismiss(animated: true, completion: nil)
    }
}
