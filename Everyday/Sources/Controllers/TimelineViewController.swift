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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let identifier = segue.identifier else { return }
        switch identifier {
        case "addEntry":
            if let entryVC = segue.destination as? EntryViewController {
                entryVC.viewModel = EntryViewViewModel(environment: environment)
                entryVC.delegate = self
            }
        case "showEntry":
            if
                let entryVC = segue.destination as? EntryViewController,
                let selectedIndexPath = tableview.indexPathForSelectedRow {
                entryVC.viewModel = EntryViewViewModel(environment: environment, entry: entry(for: selectedIndexPath))
                entryVC.delegate = self
            }
        default:
            break
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Everyday"
        tableview.delegate = self
        //tableview.dataSource = self
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        dates = entries
            .compactMap { $0.createdAt.hmsRemoved }
            .unique()
        
        tableview.reloadData()
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

extension TimelineViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .normal, title:  nil) { (ac:UIContextualAction, view:UIView, success:(Bool) -> Void) in
            
            let date = self.dates[indexPath.section]
            let entries = self.entries(for: date)
            let entry = entries[indexPath.row]
            
            self.environment.entryRepository.remove(entry)
            
            if entries.count == 1 {
                self.dates = self.dates.filter { $0 != date }
            }
            
            UIView.animate(withDuration: 0.3) {
                
                tableView.beginUpdates()
                
                if entries.count == 1 {
                    
                    tableView.deleteSections(IndexSet.init(integer: indexPath.section), with: .automatic)
                    
                } else {
                    
                    tableView.deleteRows(at: [indexPath], with: .automatic)
                    
                }
                
                tableView.endUpdates()
            }
            
            success(true)
        }
        
        deleteAction.image = #imageLiteral(resourceName: "deleteIcon")
        deleteAction.backgroundColor = UIColor.gradientEnd
        
        return UISwipeActionsConfiguration(actions:
            [deleteAction]
        )
    }
}

extension TimelineViewController: EntryViewControllerDelegate {
    func didRemoveEntry(_ entry: Entry) {
        navigationController?.popViewController(animated: true)
    }
}

