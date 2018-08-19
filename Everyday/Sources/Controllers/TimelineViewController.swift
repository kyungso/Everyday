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
    
    private var dates: [Date] = []
    private var entries: [Entry] {
        return environment.entryRepository.recentEntries(max: environment.entryRepository.numberOfEntries)
    }
    
    private func entries(for date: Date) -> [Entry] {
        return entries
            .filter { $0.createdAt.hmsRemoved == date }
    }

    private func entry(for indexPath: IndexPath) -> Entry {
        let date = dates[indexPath.section]
        let entriesOfDate = entries(for: date)
        let entry = entriesOfDate[indexPath.row]
        return entry
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Everyday"
    
        tableview.dataSource = self
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        dates = entries
            .compactMap { $0.createdAt.hmsRemoved }
            .unique()
        
        tableview.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let identifier = segue.identifier else { return }
        switch identifier {
        case "addEntry":
            if let entryVC = segue.destination as? EntryViewController {
                entryVC.environmnet = environment
                entryVC.delegate = self
            }
        case "showEntry":
            if
                let entryVC = segue.destination as? EntryViewController,
                let selectedIndexPath = tableview.indexPathForSelectedRow {
                entryVC.environmnet = environment
                entryVC.editingEntry = entry(for: selectedIndexPath)
                entryVC.delegate = self
            }
        default:
            break
        }
    }
}
    
extension TimelineViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return dates.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let date = dates[section]
        return DateFormatter.entryDateFormatter.string(from: date)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let date = dates[section]
        return entries(for: date).count
    }
        
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let tableViewCell = tableview.dequeueReusableCell(withIdentifier: "EntryCell", for: indexPath) as! EntryTableViewCell
        
        let entry = self.entry(for: indexPath)
       
        tableViewCell.entryTextLabel.text = entry.text
        tableViewCell.timeLabel.text = DateFormatter.entryTimeFormatter.string(from: entry.createdAt)
        tableViewCell.ampmLabel.text = DateFormatter.ampmFormatter.string(from: entry.createdAt)
        
        return tableViewCell
    }
}

extension TimelineViewController: EntryViewControllerDelegate {
    func didRemoveEntry(_ entry: Entry) {
        navigationController?.popViewController(animated: true)
    }
}

