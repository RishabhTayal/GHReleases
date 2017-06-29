//
//  AppHelper.swift
//  GHReleases
//
//  Created by Tayal, Rishabh on 6/27/17.
//  Copyright © 2017 Tayal, Rishabh. All rights reserved.
//

import Foundation
import UIKit

extension String {
    func stringFromHtml() -> NSAttributedString? {
        do {
            let data = self.data(using: String.Encoding.utf8, allowLossyConversion: true)
            if let d = data {
                let str = try NSAttributedString(data: d, options: [NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType], documentAttributes: nil)
                return str
            }
        } catch {
        }
        return nil
    }
}

extension Array where Element: Equatable {
    mutating func removeObject(_ object: Element) {
        if let index = self.index(of: object) {
            self.remove(at: index)
        }
    }
}

extension UserDefaults {
    class func storeRepo(repository: Repository) {
        if var defaults = UserDefaults.standard.array(forKey: UserDefaultsKey.Repositories) {
            for (index, repo) in defaults.enumerated() {
                let repoObj = Repository.instance(dict: repo as! [String : Any])
                if repoObj.owner == repository.owner && repoObj.name == repository.name {
                    defaults.insert(repository, at: index)
                }
            }
            UserDefaults.standard.set(defaults, forKey: UserDefaultsKey.Repositories)
            UserDefaults.standard.synchronize()
        } else {
            UserDefaults.standard.set([repository.toJSON()], forKey: UserDefaultsKey.Repositories)
            UserDefaults.standard.synchronize()
        }
    }
}
