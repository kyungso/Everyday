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
    
    var environment: Environment!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Everyday"
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        entryCountLabel.text = environment.entryRepository.numberOfEntries > 0
            ? "엔트리 갯수: \(environment.entryRepository.numberOfEntries)"
            : "엔트리 없음"
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case .some("addEntry"):
            if let timelinevc = segue.destination as? EntryViewController {
                timelinevc.environmnet = environment
            }
        default:
            break
        }
    }
}
