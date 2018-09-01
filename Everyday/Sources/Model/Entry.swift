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

extension Entry {
    convenience init?(dictionary: [String: Any]) {
        guard
            let uuidString = dictionary["uuidString"] as? String,
            let uuid = UUID(uuidString: uuidString),
            let createdAtTimeInterval = dictionary["createdAt"] as? Double,
            let text = dictionary["text"] as? String
            else { return nil }
        self.init(id: uuid, createdAt: Date(timeIntervalSince1970: createdAtTimeInterval), text: text)
    }
}
    
extension EntryType {
    func toDitionary() -> [String: Any] {
        return [
            "uuidString": id.uuidString,
            "createdAt": createdAt.timeIntervalSince1970,
            "text": text
        ] }
}
