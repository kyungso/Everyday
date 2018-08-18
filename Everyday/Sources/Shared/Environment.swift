//
//  Environment.swift
//  Everyday
//
//  Created by Cocoa on 2018. 8. 18..
//  Copyright © 2018년 ksjung. All rights reserved.
//

class Environment {
    let entryRepository: EntryRepository
    
    init(entryRepository: EntryRepository = InMemoryEntryRepository()){
        self.entryRepository = entryRepository
    }
}
 
