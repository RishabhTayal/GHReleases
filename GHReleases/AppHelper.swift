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
