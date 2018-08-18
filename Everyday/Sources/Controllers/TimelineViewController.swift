//
//  TimelineViewController.swift
//  Everyday
//
//  Created by Cocoa on 2018. 8. 18..
//  Copyright © 2018년 ksjung. All rights reserved.
//

import UIKit

class TimelineViewController: UIViewController {
    
    @IBOutlet weak var tableview: UITableView!
    
    var environment: Environment!
    private var entries: [Entry] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Everyday"
        tableview.dataSource = self
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        entries = environment.entryRepository.recentEntries(max: environment.entryRepository.numberOfEntries)
        
        tableview.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case .some("addEntry"):
            if let entryVC = segue.destination as? EntryViewController {
                entryVC.environmnet = environment
            }
        case .some("showEntry"):
            if
                let entryVC = segue.destination as? EntryViewController,
                let selectedIndexPath = tableview.indexPathForSelectedRow {
                entryVC.environmnet = environment
                let entry = entries[selectedIndexPath.row]
                entryVC.editingEntry = entry
            }
        default:
            break
        }
    }
}
    
extension TimelineViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return entries.count
    }
        
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let tableViewCell = tableview.dequeueReusableCell(withIdentifier: "EntryCell", for: indexPath)
        
        let entry = entries[indexPath.row]
       
        tableViewCell.textLabel?.text = "\(entry.text)"
        tableViewCell.detailTextLabel?.text = DateFormatter.entryDateFormatter.string(from: entry.createdAt)
        
        return tableViewCell
    }
}

