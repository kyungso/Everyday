//
//  EntryTests.swift
//  EverydayTests
//
//  Created by Cocoa on 2018. 8. 14..
//  Copyright © 2018년 ksjung. All rights reserved.
//

import XCTest
import Nimble
@testable import Everyday

class EntryTests: XCTestCase {
    func testEditEntryText() {
        // Setup
        let entry: Entry = Entry(id: UUID(), createdAt: Date(), text: "첫 번째 일기")
        
        // Run
        entry.text = "첫 번째 테스트"
        
        // Verify
        expect(entry.text) == "첫 번째 테스트"
    }
    
    func testEquality() {
        // Setup
        let date = Date()
        let text = "일기"
        let aEntry = Entry(id: UUID(), createdAt: date, text: text)
        let sameEntry = Entry(id: UUID(), createdAt: date, text: text)
        
        let anotherEntry = Entry(id: UUID(), createdAt: date, text: text)
        
        let identicalButDateChanged = Entry(id: UUID(), createdAt: Date.distantFuture, text: "일기")
        let identicalButTextChanged = Entry(id: UUID(), createdAt: date, text: "다른 일기")
        
        // Verify
        expect(aEntry) != sameEntry
        expect(aEntry) != anotherEntry
        expect(aEntry) != identicalButDateChanged
        expect(aEntry) != identicalButTextChanged
    }
}
