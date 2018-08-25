//
//  SettingsTableViewController.swift
//  Everyday
//
//  Created by Cocoa on 2018. 8. 25..
//  Copyright © 2018년 ksjung. All rights reserved.
//

import UIKit
class SettingsTableViewController: UITableViewController {
    var viewModel: SettingsTableViewViewModel!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.sectionModels.count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return viewModel.sectionModels[section].title
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.sectionModels[section].cellModels.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SettingItemCell", for: indexPath)
        
        let cellModel = viewModel.sectionModels[indexPath.section].cellModels[indexPath.row]
        cell.textLabel?.text = cellModel.title
        cell.textLabel?.font = cellModel.font
        cell.accessoryType = cellModel.isChecked
            ? .checkmark
            : .none
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.selectOption(for: indexPath)
        tableView.reloadData()
    }
}
