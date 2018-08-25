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
    let now: () -> Date
    
    init(entryRepository: EntryRepository = InMemoryEntryRepository(),
         now: @escaping () -> Date = Date.init
        ) {
        self.entryRepository = entryRepository
        self.now = now
    }
}
 
