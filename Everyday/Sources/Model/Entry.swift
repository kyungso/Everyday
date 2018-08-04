//
//  Entry.swift
//  Everyday
//
//  Created by Cocoa on 2018. 7. 28..
//  Copyright © 2018년 ksjung. All rights reserved.
//

import Foundation

class Entry{
    let id: Int
    let createdAt: Date
    var updatedAt: Date
    var text: String{
        didSet{
            updatedAt = Date()
        }
    }
    
    init(id: Int, createdAt: Date, text: String){
        self.id = id
        self.createdAt = createdAt
        self.updatedAt = createdAt
        self.text = text
    }
}

