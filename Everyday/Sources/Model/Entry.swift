//
//  Entry.swift
//  Everyday
//
//  Created by Cocoa on 2018. 7. 28..
//  Copyright © 2018년 ksjung. All rights reserved.
//

import Foundation

class Entry{
    let id: UUID
    let createdAt: Date
    var updatedAt: Date
    var text: String{
        didSet{
            updatedAt = Date()
        }
    }
    
    init(id: UUID = UUID(), createdAt: Date = Date(), text: String){
        self.id = id
        self.createdAt = createdAt
        self.updatedAt = createdAt
        self.text = text
    }
}

extension Entry: Identifiable { }

extension Entry: Equatable {
    static func == (lhs: Entry, rhs: Entry) -> Bool{
        return lhs.id == rhs.id
        && lhs.createdAt == rhs.createdAt
        && lhs.text == rhs.text
    }
}

