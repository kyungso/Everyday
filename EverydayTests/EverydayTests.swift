//
//  EverydayTests.swift
//  EverydayTests
//
//  Created by Cocoa on 2018. 7. 28..
//  Copyright © 2018년 ksjung. All rights reserved.
//

import XCTest
import Nimble
@testable import Everyday

extension Entry {
    static var dayBeforeYesterday: Entry { return Entry(id: UUID(), createdAt: Date.distantPast, text: "그저께 일기") }
    static var yesterDay: Entry { return Entry(id: UUID(), createdAt: Date(), text: "어제 일기") }
    static var today: Entry { return Entry(id: UUID(), createdAt: Date.distantFuture, text: "오늘 일기") }
}
// 공통선언을 하면 밑에 let today = Entry.today 로 작성가능

class EverydayTests: XCTestCase {
    
    // 공통 선언
    var newEntry: Entry!
    
    func testEditEntryText() {
        // Setup
        let entry = Entry(id: UUID(), createdAt: Date(), text: "첫 번째 일기")
        
        // Run
        entry.text = "첫 번째 테스트"
        
        // Verify
        //XCTAssertEqual(entry.text, "첫 번째 테스트")
        expect(entry.text) == "첫 번째 테스트"
    }
    
    func testAddEntryToJournal() {
        //Setup
        let journal = InMemoryEntryRepository()
        let newEntry = Entry.today
        
        // Run
        journal.add(newEntry)
        
        // Verify
        let entryInJournal: Entry? = journal.entry(with: newEntry.id)
        
        //XCTAssertFalse(entryInJournal, .some(newEntry))
        //XCTAssertFalse(entryInJournal === newEntry)
        //XCTAssertFalse(entryInJournal?.isIdentical(to: newEntry) == true)
        expect(entryInJournal) == newEntry
        expect(entryInJournal?.isIdentical(to: newEntry)).to(beTrue())
    }
    
    func testGetEntryWithId() {
        // Setup
        let oldEntry = Entry.yesterDay
        let journal = InMemoryEntryRepository(entries: [oldEntry])
        
        // Run
        let entry = journal.entry(with: oldEntry.id)
        
        // Verify
        // XCTAssertNotNil(entry, .some(oldEntry))
        //XCTAssertFalse(entry?.isIdentical(to: oldEntry) == true)
        expect(entry) == oldEntry
        expect(entry?.isIdentical(to: oldEntry)).to(beTrue())
    }
    
    func testUpdateEntry() {
        // Setup
        let oldEntry = Entry.yesterDay
        let journal = InMemoryEntryRepository(entries: [oldEntry])
        
        // Run
        oldEntry.text = "일기 내용을 수정했습니다"
        journal.update(oldEntry)
        
        // Verify
        let entry = journal.entry(with: oldEntry.id)
        expect(entry) == oldEntry
        expect(entry?.isIdentical(to: oldEntry)).to(beTrue())
        //XCTAssertEqual(entry, .some(oldEntry))
        //XCTAssertFalse(entry?.isIdentical(to: oldEntry) == true)
        //XCTAssertEqual(entry?.text, .some("일기 내용을 수정했습니다"))
    }
    
    func testRemoveEntryFromJournal(){
        // Setup
        let oldEntry = Entry.yesterDay
        let journal = InMemoryEntryRepository(entries: [oldEntry])
        
        // Run
        journal.remove(oldEntry)
        
        // Verify
        let entry = journal.entry(with: oldEntry.id)
        //XCTAssertEqual(entry, nil)
        expect(entry).to(beNil())
    }
    
    func test_최근_순으로_엔트리를_불러올_수_있다() { // Setup
        let dayBeforeYesterday = Entry.dayBeforeYesterday
        let yesterDay = Entry.yesterDay
        let today = Entry.today
        
        let journal = InMemoryEntryRepository(entries: [dayBeforeYesterday, yesterDay, today])
        
        // Run
        let entries = journal.recentEntries(max: 3)
        
        // Verify
        //XCTAssertEqual(entries.count, 3)
        //XCTAssertEqual(entries, [today, yesterDay, dayBeforeYesterday])
        expect(entries.count) == 3
        expect(entries).to(equal([today, yesterDay, dayBeforeYesterday]))
    }
    
    func test_요청한_엔트리의_수만큼_최신_순으로_반환한다() { // Setup
        let dayBeforeYesterday = Entry.dayBeforeYesterday
        let yesterDay = Entry.yesterDay
        let today = Entry.today
        
        let journal = InMemoryEntryRepository(entries: [dayBeforeYesterday, yesterDay, today])
        
        // Run
        let entries = journal.recentEntries(max: 1)
        
        // Verify
        //XCTAssertEqual(entries.count, 1)
        //XCTAssertEqual(entries, [today])
        expect(entries.count) == 1
        expect(entries) == [today]
    }
    
    func test_존재하는_엔트리보다_많은_수를_요청하면_존재하는_엔트리만큼만_반환한다() { // Setup
        let dayBeforeYesterday = Entry.dayBeforeYesterday
        let yesterDay = Entry.yesterDay
        let today = Entry.today
        
        let journal = InMemoryEntryRepository(entries: [dayBeforeYesterday, yesterDay, today])
        
        // Run
        let entries = journal.recentEntries(max: 10)
        
        // Verify
        //XCTAssertEqual(entries.count, 3)
        //XCTAssertEqual(entries, [today, yesterDay, dayBeforeYesterday])
        expect(entries.count) == 3
        expect(entries) == [today, yesterDay, dayBeforeYesterday]
    }
    
//    func testJournalReturnsNilWhenMaxIsNegative() {
//        // Setup
//        let journal = InMemoryEntryRepository()
//        
//        // Run
//        let entries = journal.recentEntries(max: -10)
//        
//        // Verify
//        expect(entries).to(beEmpty())
//    }
    
}
