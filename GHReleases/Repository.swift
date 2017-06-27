//
//  Repository.swift
//  GHReleases
//
//  Created by Tayal, Rishabh on 6/27/17.
//  Copyright © 2017 Tayal, Rishabh. All rights reserved.
//

import Foundation

class Repository {
    
    var owner: String!
    var name: String!
    
    init(dict: [String: Any]) {
        self.owner = dict["owner"] as! String
        self.name = dict["name"] as! String
    }
}
