//
//  NoteViewController.swift
//  Notes
//
//  Created by Александр Меренков on 30.01.2024.
//

import UIKit

private enum Constants {
    static let horizontalPadding: CGFloat = 15
    static let paddingTop: CGFloat = 12
    static let titleTextFieldHeight: CGFloat = 55
    static let noteViewPaddingTop: CGFloat = 25
}

final class NoteViewController: UIViewController {
    
// MARK: - Properties
    
    private let output: NoteOutput
    private lazy var titleTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Введите заголовок"
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: 15))
        textField.leftViewMode = .always
        return textField
    }()
    private lazy var noteTextView: UITextView = {
        let textView = UITextView()
        textView.text = "Содержание"
        textView.isScrollEnabled = false
        textView.sizeToFit()
        textView.font = UIFont.systemFont(ofSize: 21)
        textView.textColor = .white
        textView.delegate = self
        return textView
    }()
    
// MARK: - Lifecycle
    
    init(output: NoteOutput) {
        self.output = output
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        output.save(title: titleTextField.text, note: noteTextView.text)
    }
    
// MARK: - Helpers
    
    private func configureUI() {
        view.addSubview(titleTextField)
        titleTextField.anchor(leading: view.leadingAnchor, 
                              top: view.safeAreaLayoutGuide.topAnchor,
                              trailing: view.trailingAnchor,
                              paddingLeading: Constants.horizontalPadding,
                              paddingTop: Constants.paddingTop,
                              paddingTrailing: -Constants.horizontalPadding,
                              height: Constants.titleTextFieldHeight)
        titleTextField.backgroundColor = .tableBackground
        
        view.addSubview(noteTextView)
        noteTextView.anchor(leading: view.leadingAnchor,
                             top: titleTextField.bottomAnchor,
                             trailing: view.trailingAnchor,
                             paddingLeading: Constants.horizontalPadding,
                             paddingTop: Constants.noteViewPaddingTop,
                             paddingTrailing: -Constants.horizontalPadding)
        noteTextView.backgroundColor = .background
        view.backgroundColor = .background
    }
}

// MARK: - NoteInput

extension NoteViewController: NoteInput {
    
}

// MARK: - UITextView

extension NoteViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == "Содержание" {
            textView.text = ""
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "Содержание"
        }
    }
}
