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

    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var textViewBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var button: UIBarButtonItem!
    
    var environmnet: Environment!
    
    var journal: EntryRepository { return environmnet.entryRepository }
    var editingEntry: Entry?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let date: Date = editingEntry?.createdAt ?? Date()
        
        title = DateFormatter.entryDateFormatter.string(from: date)
        textView.text = editingEntry?.text
        
        button.action = #selector(saveEntry(_:))
        
        NotificationCenter.default
            .addObserver(self,
                         selector: #selector(handleKeyboardAppearance(note:)),
                         name: Notification.Name.UIKeyboardWillShow,
                         object: nil)
        NotificationCenter.default
            .addObserver(self,
                         selector: #selector(handleKeyboardAppearance(note:)),
                         name: Notification.Name.UIKeyboardWillHide,
                         object: nil)
    }
    
    @objc func handleKeyboardAppearance(note: Notification) {
        guard
            let userInfo = note.userInfo,
            let keyboardFrameValue = userInfo[UIKeyboardFrameEndUserInfoKey] as? NSValue,
            let duration = userInfo[UIKeyboardAnimationDurationUserInfoKey] as? TimeInterval,
            let animationCurve = userInfo[UIKeyboardAnimationCurveUserInfoKey] as? UInt
            else { return }
        let isKeyboardWillShow = note.name == Notification.Name.UIKeyboardWillShow
        let keyboardHeight: CGFloat = isKeyboardWillShow
            ? keyboardFrameValue.cgRectValue.height
            : 0
        
        let animationOption = UIViewAnimationOptions(rawValue: animationCurve)
        
        UIView.animate(
            withDuration: duration,
            delay: 0.0,
            options: animationOption,
            animations: {
                self.textViewBottomConstraint.constant = -keyboardHeight
                self.view.layoutIfNeeded()
        },
            completion: nil
        )
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        updateSubviews(for: true)
    }
    
    @objc func saveEntry(_ sender: UIButton) {
        if let editing = editingEntry {
            editing.text = textView.text
            journal.update(editing)
        }else {
            let entry: Entry = Entry(text: textView.text)
            journal.add(entry)
            editingEntry = entry
        }
        updateSubviews(for: false)
    }
    
    @objc func editEntry(_ sender: UIButton) {
        updateSubviews(for: true)
    }
    
    private func updateSubviews(for isEditing: Bool) {
        textView.isEditable = isEditing
        _ = isEditing
            ? textView.becomeFirstResponder()
            : textView.resignFirstResponder()
        
        button.image = isEditing ? #imageLiteral(resourceName: "saveIcon") : #imageLiteral(resourceName: "editIcon")
        button.target = self
        button.action = isEditing
            ? #selector(saveEntry(_:))
            : #selector(editEntry(_:))
    }
}

