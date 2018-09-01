//
//  TimelineViewViewModel.swift
//  Everyday
//
//  Created by Cocoa on 2018. 8. 25..
//  Copyright © 2018년 ksjung. All rights reserved.
//

import Foundation

class TimelineViewViewModel {
    let environment: Environment
    
    private var dates: [Date] = []
    private var entries: [EntryType] = []
    private var filteredEntries: [EntryType] = []

    private(set) var isLoading: Bool = false
    
    private func entries(for date: Date) -> [EntryType] {
        return entries
            .filter { $0.createdAt.hmsRemoved == date }
    }
    
    private func entry(for indexPath: IndexPath) -> EntryType {
        guard isSearching == false else { return filteredEntries[indexPath.row] }
        
        let date = dates[indexPath.section]
        let entriesOfDate = entries(for: date)
        let entry = entriesOfDate[indexPath.row]
        return entry
    }
    
    init(environment: Environment) {
        self.environment = environment
        dates = self.entries
            .compactMap { $0.createdAt.hmsRemoved }
            .unique()
    }
    
    var searchText: String? {
        didSet {
            guard let text = searchText else {
                filteredEntries = []
                return
            }
            filteredEntries = environment.entryRepository.entries(contains: text)
        }
    }
    
    var isSearching: Bool {
        return searchText?.isEmpty == false
    }
    
    func removeEntry(at indexPath: IndexPath) {
        let date = dates[indexPath.section]
        let entries = self.entries(for: date)
        let entry = entries[indexPath.row]
        environment.entryRepository.remove(entry)
        
        if entries.count == 1 {
            dates = self.dates.filter { $0 != date }
        }
    }
    var newEntryViewViewModel: EntryViewViewModel {
        let vm = EntryViewViewModel(environment: environment)
        vm.delegate = self
        return vm
    }
    
    func entryViewViewModel(for indexPath: IndexPath) -> EntryViewViewModel {
        let vm = EntryViewViewModel(environment: environment, entry: entry(for: indexPath))
        vm.delegate = self
        return vm
    }
    
    func entryTableViewCellViewModel(for indexPath: IndexPath) -> EntryTableViewCellViewModel {
        let entry = self.entry(for: indexPath)
        
        return EntryTableViewCellViewModel(
            entry: entry,
            environment: environment
        )
    }
    
    lazy var settingsViewModel: SettingsTableViewViewModel = SettingsTableViewViewModel(environment: environment)
}

extension TimelineViewViewModel {
    var numberOfSections: Int {
        return isSearching ? 1 : dates.count
    }

    func title(for section: Int) -> String? {
        guard isSearching == false else { return nil }
        let date = dates[section]
        return DateFormatter.formatter(with: environment.settings.dateFormatOption.rawValue)
            .string(from: date)
    }
    
    func numberOfRows(in section: Int) -> Int {
        guard isSearching == false else { return filteredEntries.count }
        
        let date = dates[section]
        return entries(for: date).count
    }
}

extension TimelineViewViewModel: EntryViewViewModelDelegate {
    func didAddEntry(_ entry: EntryType) {
        dates = self.entries
            .compactMap { $0.createdAt.hmsRemoved }
            .unique()
    }
    
    func didRemoveEntry(_ entry: EntryType) {
        dates = self.entries
            .compactMap { $0.createdAt.hmsRemoved }
            .unique()
    }
}

extension TimelineViewViewModel {
    func loadEntries(completion: @escaping () -> Void) {
        isLoading = true
        
       environment.entryRepository.recentEntries(max: 10) { [weak self] (entries) in
            self?.entries = entries
            self?.dates = entries
                .compactMap { $0.createdAt.hmsRemoved }
                .unique()
            self?.isLoading = false
            completion()
        }
    }
}
