//
//  ViewController.swift
//  Everyday
//
//  Created by Cocoa on 2018. 7. 27..
//  Copyright © 2018년 ksjung. All rights reserved.
//

import UIKit

class EntryViewController: UIViewController {

    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var textViewBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var button: UIBarButtonItem!
    @IBOutlet weak var removeButton: UIBarButtonItem!
    
    var viewModel: EntryViewViewModel!
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = viewModel.title
        textView.text = viewModel.textViewText
        
        updateSubviews(for: viewModel.hasEntry == false)
        
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
            let keyboardFrameValue = (userInfo[UIKeyboardFrameEndUserInfoKey] as? NSValue),
            let duration = (userInfo[UIKeyboardAnimationDurationUserInfoKey] as? TimeInterval),
            let animationCurve = (userInfo[UIKeyboardAnimationCurveUserInfoKey] as? UInt)
            else { return }
        
        let isKeyboardWillShow: Bool = note.name == Notification.Name.UIKeyboardWillShow
        let keyboardHeight = isKeyboardWillShow
            ? keyboardFrameValue.cgRectValue.height
            : 0
        
        let animationOption = UIViewAnimationOptions.init(rawValue: animationCurve)
        
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
        if viewModel.hasEntry == false { textView.becomeFirstResponder() }
    }
    
    @objc func saveEntry(_ sender: UIButton) {
        viewModel.completeEditing(with: textView.text)
        updateSubviews(for: false)
        textView.resignFirstResponder()
    }
    
    @objc func editEntry(_ sender: UIButton) {
        viewModel.startEditing()
        updateSubviews(for: true)
        textView.becomeFirstResponder()
    }
    
    @IBAction func removeEntry(_ sender: Any) {
        guard viewModel.hasEntry else { return }
        
        let alertController = UIAlertController(
            title: "현재 일기를 삭제할까요?",
            message: "이 동작은 되돌릴 수 없습니다",
            preferredStyle: .alert
        )
        
        let removeAction: UIAlertAction = UIAlertAction(
            title: "삭제",
            style: .destructive) { (_) in
                guard
                    let _ = self.viewModel.removeEntry()
                    else { return }
                
                // pop
                self.navigationController?.popViewController(animated: true)
        }
        alertController.addAction(removeAction)
        
        let cancelAction: UIAlertAction = UIAlertAction(
            title: "취소",
            style: .cancel,
            handler: nil
        )
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true, completion: nil)
    }
    
    private func updateSubviews(for isEditing: Bool) {
        textView.isEditable = viewModel.textViewEditiable
        removeButton.isEnabled = viewModel.removeButtonEnabled
        button.image = viewModel.buttonImage
        
        button.target = self
        button.action = viewModel.isEditing
            ? #selector(saveEntry(_:))
            : #selector(editEntry(_:))
    }
}

