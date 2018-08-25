//
//  EntryTableViewCell.swift
//  Everyday
//
//  Created by Cocoa on 2018. 8. 18..
//  Copyright © 2018년 ksjung. All rights reserved.
//

import UIKit

struct EntryTableViewCellViewModel {
    let entryText: String
    let timeText: String
    let ampmText: String
}

class EntryTableViewCell: UITableViewCell {
    
    @IBOutlet weak var entryTextLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var ampmLabel: UILabel!
    
    var viewModel: EntryTableViewCellViewModel? {
        didSet {
            guard let vm = viewModel else { return }
            entryTextLabel.text = vm.entryText
            timeLabel.text = vm.timeText
            ampmLabel.text = vm.ampmText
        }
    }
    
}
