//
//  EntryRepository.swift
//  Everyday
//
//  Created by Cocoa on 2018. 7. 28..
//  Copyright © 2018년 ksjung. All rights reserved.
//

import Foundation

protocol EntryRepository {
    var numberOfEntries: Int { get }
    func add(_ entry: EntryType)
    func update(_ entry: EntryType, text: String)
    func remove(_ entry: EntryType)
    
    func entries(contains string: String) -> [EntryType]
    func entry(with id: UUID) -> EntryType?
    
    func recentEntries(max: Int) -> [EntryType]
}

class InMemoryEntryRepository: EntryRepository{
    private var entries: [UUID: EntryType]
    
    init(entries: [Entry] = []) {
        var result: [UUID: EntryType] = [:]
        entries.forEach { entry in
            result[entry.id] = entry
        }
        self.entries = result
    }
    
    static var shared: InMemoryEntryRepository = {
        let repository = InMemoryEntryRepository()
        return repository
    }()
    
    var numberOfEntries: Int {
        return entries.count
        
    }
    
    func add(_ entry: EntryType){
        entries[entry.id] = entry
    }
    func update(_ entry: EntryType, text: String){
        guard let entry = entry as? Entry else { fatalError() }
        entry.text = text
    }
    func remove(_ entry: EntryType){
        entries[entry.id] = nil
    }
    
    func entries(contains string: String) -> [EntryType] {
        let result = entries
            .values
            .filter { $0.text.contains(string) }
            .sorted { $0.createdAt > $1.createdAt  }
        
        return Array(result)
    }
    
    func entry(with id: UUID) -> EntryType?{
        return entries[id]
    }
    func recentEntries(max: Int) -> [EntryType]{
        let result = entries
            .values
            .sorted{ $0.createdAt > $1.createdAt }
            .prefix(max)
        
        return Array(result)
    }
}

