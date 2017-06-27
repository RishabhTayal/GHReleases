//
//  Repository.swift
//  GHReleases
//
//  Created by Tayal, Rishabh on 6/27/17.
//  Copyright © 2017 Tayal, Rishabh. All rights reserved.
//

import Foundation
import ObjectMapper

class Repository: Mappable {
    
    var owner: String!
    var name: String!
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        self.owner <- map["owner"]
        self.name <- map["name"]
    }
    
    class func instance(dict: [String: Any]) -> Repository {
        return Mapper<Repository>().map(JSON: dict)!
    }
}
