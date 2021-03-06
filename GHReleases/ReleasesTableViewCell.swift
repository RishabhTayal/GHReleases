//
//  ReleasesTableViewCell.swift
//  GHReleases
//
//  Created by Tayal, Rishabh on 6/26/17.
//  Copyright © 2017 Tayal, Rishabh. All rights reserved.
//

import UIKit
import MWFeedParser
import FormatterKit

class ReleasesTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var summaryLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func config(item: MWFeedItem) {
        self.titleLabel.text = item.title
        self.summaryLabel.attributedText = item.summary.stringFromHtml()
        let formatter = TTTTimeIntervalFormatter()
        self.releaseDateLabel.text = formatter.stringForTimeInterval(from: item.updated, to: Date())
        self.authorLabel.text = item.author
    }
}
