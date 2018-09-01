//
//  EntryViewViewModel.swift
//  Everyday
//
//  Created by Cocoa on 2018. 8. 25..
//  Copyright © 2018년 ksjung. All rights reserved.
//
// entryviewcontroller에서  var viewMdoel 선언하고 environment 대신 viewModel

import UIKit

protocol EntryViewViewModelDelegate: class {
    func didAddEntry(_ entry: EntryType)
    func didRemoveEntry(_ entry: EntryType)
}

class EntryViewViewModel {
    private let environment: Environment
    
    weak var delegate: EntryViewViewModelDelegate?
    
    private var entry: EntryType?
    
    init(environment: Environment, entry: EntryType? = nil) {
        self.environment = environment
        self.entry = entry
    }
    
    var hasEntry: Bool {
        return entry != nil
    }
    
    var textViewText: String? {
        return entry?.text
    }
    
    var textViewFont: UIFont {
        return UIFont.systemFont(ofSize: environment.settings.fontSizeOption.rawValue)
    }
    
    var title: String {
        let date: Date = entry?.createdAt ?? environment.now()
        return DateFormatter.formatter(with: environment.settings.dateFormatOption.rawValue)
            .string(from: date) 
    }
    
    var removeButtonEnabled: Bool {
        return hasEntry
    }
    
    private(set) var isEditing: Bool = false
    
    func startEditing() {
        isEditing = true
    }
    
    func completeEditing(with text: String) {
        isEditing = false
        
        if let editingEntry = entry {
            environment.entryRepository.update(editingEntry, text: text)
        } else {
            let newEntry = environment.entryFactory(text)
            environment.entryRepository.add(newEntry)
            delegate?.didAddEntry(newEntry)
        }
    }
    
    func removeEntry() -> EntryType? {
        guard let entryToRemove = entry else { return nil }
        environment.entryRepository.remove(entryToRemove)
        self.entry = nil
        delegate?.didRemoveEntry(entryToRemove)
        return entryToRemove
    }
    
    var textViewEditiable: Bool {
        return isEditing
    }
    
    var buttonImage: UIImage {
        return isEditing ? #imageLiteral(resourceName: "saveIcon") : #imageLiteral(resourceName: "editIcon")
    }
    
}
