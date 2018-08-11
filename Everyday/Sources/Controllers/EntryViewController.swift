//
//  ViewController.swift
//  Everyday
//
//  Created by Cocoa on 2018. 7. 27..
//  Copyright © 2018년 ksjung. All rights reserved.
//

import UIKit

extension DateFormatter {
    static var entryDateFormatter: DateFormatter = {
        let df = DateFormatter()
        df.dateFormat = "yyyy. M. dd. EEE"
        return df
    }()
}

class EntryViewController: UIViewController {

    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var button: UIButton!
    
    private let journal: Everyday = InMemoryJournal()
    private var editingEntry: Entry?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textView.text = "첫 번쨰 일기"
        
        dateLabel.text = DateFormatter.entryDateFormatter.string(from: Date())

        button.addTarget(self, action: #selector(saveEntry(_:)), for: .touchUpInside)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        updateSubviews(for: true)
    }
    
    @objc func saveEntry(_ sender: UIButton) {
        if let editing = self.editingEntry {
            editing.text = textView.text
            journal.update(editing)
            print("수정")
        }else {
            let entry: Entry = Entry(text: textView.text)
            journal.add(entry)
            editingEntry = entry
            print("추가")
        }
        updateSubviews(for: false)
    }
    
    @objc func editEntry(_ sender: UIButton) {
        updateSubviews(for: true)
    }
    
    private func updateSubviews(for isEditing: Bool) {
        if isEditing {
            textView.isEditable = true
            textView.becomeFirstResponder()
        
            button.setTitle("저장하기", for: .normal)
            button.addTarget(self, action: #selector(saveEntry(_:)), for: .touchUpInside)
        } else {
            textView.isEditable = false
            textView.resignFirstResponder()
            
            button.setTitle("수정하기", for: .normal)
            button.addTarget(self, action: #selector(editEntry), for: .touchUpInside)
        }
    }

}

