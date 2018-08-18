//
//  TimelineViewController.swift
//  Everyday
//
//  Created by Cocoa on 2018. 8. 18..
//  Copyright © 2018년 ksjung. All rights reserved.
//

import UIKit

class TimelineViewController: UIViewController {
    @IBOutlet weak var entryCountLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Journal"
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let journal = InMemoryEntryRepository.shared
        
        entryCountLabel.text = journal.numberOfEntries > 0
            ? "엔트리 갯수: \(journal.numberOfEntries)"
            : "엔트리 없음"
    }
}
