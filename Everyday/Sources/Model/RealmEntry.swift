//
//  RealmEntry.swift
//  Everyday
//
//  Created by Cocoa on 2018. 9. 1..
//  Copyright © 2018년 ksjung. All rights reserved.
//

import Foundation
import RealmSwift

class RealmEntry: Object, EntryType {
    var id: UUID {
        guard let uuid = UUID.init(uuidString: uuidString) else { fatalError() }
        return uuid
    }
    
    @objc dynamic var uuidString: String = ""
    @objc dynamic var createdAt: Date = Date()
    @objc dynamic var text: String = ""
    
    override static func primaryKey() -> String? {
        return "uuidString"
    }
}

