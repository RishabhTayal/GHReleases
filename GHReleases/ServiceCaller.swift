//
//  ServiceCaller.swift
//  GHReleases
//
//  Created by Tayal, Rishabh on 6/26/17.
//  Copyright © 2017 Tayal, Rishabh. All rights reserved.
//

import UIKit
import MWFeedParser

class ServiceCaller: NSObject {
    
    typealias CompletionBlock = ((_ result: [MWFeedItem]?, _ error: Error?) -> Void)
    
    var completionBlock: CompletionBlock!
    var items: [MWFeedItem] = []
    
    func makeCall(repository: String, completion: @escaping CompletionBlock) {
        self.completionBlock = completion
        self.items = []
        let feedUrl = URL.init(string: "https://github.com/" + repository + "/releases.atom")!
        let parser = MWFeedParser.init(feedURL: feedUrl)
        parser?.delegate = self
        parser?.parse()
    }
}

extension ServiceCaller: MWFeedParserDelegate {
    func feedParser(_ parser: MWFeedParser!, didParseFeedItem item: MWFeedItem!) {
        self.items.append(item)
    }
    
    func feedParserDidFinish(_ parser: MWFeedParser!) {
        self.completionBlock(self.items, nil)
    }
}
