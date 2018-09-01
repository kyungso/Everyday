//
//  Entry.swift
//  Everyday
//
//  Created by Cocoa on 2018. 7. 28..
//  Copyright © 2018년 ksjung. All rights reserved.
//

import Foundation

protocol EntryType: Identifiable {
    var createdAt: Date { get }
    var text: String { get set }
}

extension EntryType {
    static func == (lhs: EntryType, rhs: EntryType) -> Bool{
        return lhs.id == rhs.id
            && lhs.createdAt == rhs.createdAt
            && lhs.text == rhs.text
    }
}

class Entry: EntryType{
    let id: UUID
    let createdAt: Date
    var text: String
    
    init(id: UUID = UUID(), createdAt: Date = Date(), text: String){
        self.id = id
        self.createdAt = createdAt
        self.text = text
    }
}

