//
//  FirebaseEntryRepository.swift
//  Everyday
//
//  Created by Cocoa on 2018. 9. 1..
//  Copyright © 2018년 ksjung. All rights reserved.
//

import FirebaseDatabase

class FirebaseEntryRepository: EntryRepository {
    
    private let reference: DatabaseReference
    
    init(reference: DatabaseReference = Database.database().reference()) {
        self.reference = reference.child("entries")
    }
    
    var numberOfEntries: Int { return 0 }
    
    func add(_ entry: EntryType) {
        guard let entry = entry as? Entry else { fatalError() }
        reference.child(entry.id.uuidString).setValue(entry.toDitionary())
    }
    func update(_ entry: EntryType, text: String) { }
    func remove(_ entry: EntryType) { }
    func entries(contains string: String) -> [EntryType] {
        return []
    }
    func entry(with id: UUID) -> EntryType? {
        return nil
    }
    func recentEntries(max: Int, completion: @escaping ([EntryType]) -> Void) {
        reference
            .queryOrdered(byChild: "createdAt")
            .queryLimited(toLast: UInt(max))
            .observeSingleEvent(of: .value, with: { (snapshot: DataSnapshot) in
            let entries: [Entry] = snapshot.children.compactMap {
                guard
                    let childSnapshot = $0 as? DataSnapshot,
                    let dict = childSnapshot.value as? [String: Any],
                    let entry = Entry(dictionary: dict)
                    else { return nil }
                return entry
            }
            completion(entries.reversed())
        })
    }
}
