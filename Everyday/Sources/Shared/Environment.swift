//
//  Environment.swift
//  Everyday
//
//  Created by Cocoa on 2018. 8. 18..
//  Copyright © 2018년 ksjung. All rights reserved.
//

import Foundation

class Environment {
    let entryRepository: EntryRepository
    var settings: Settings
    let now: () -> Date
    
    init(entryRepository: EntryRepository = InMemoryEntryRepository(),
         settings: Settings = InMemorySettings(),
         now: @escaping () -> Date = Date.init
        ) {
        self.entryRepository = entryRepository
        self.settings = settings
        self.now = now
    }
}
 
