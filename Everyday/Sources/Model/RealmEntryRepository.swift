//
//  RealmEntryRepository.swift
//  Everyday
//
//  Created by Cocoa on 2018. 9. 1..
//  Copyright © 2018년 ksjung. All rights reserved.
//

import Foundation
import RealmSwift

class RealmEntryRepository: EntryRepository {
    init() {
        
    }
    
    var numberOfEntries: Int {
        return 0
    }
    
    func add(_ entry: EntryType) {
        
    }
    
    func update(_ entry: EntryType) {
        
    }
    
    func remove(_ entry: EntryType) {
        
    }
    
    func entry(with id: UUID) -> EntryType? {
        return nil
    }
    
    func recentEntries(max: Int) -> [EntryType] {
        return []
    }
}
