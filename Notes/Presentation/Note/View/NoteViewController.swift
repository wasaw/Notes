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
    static let fontSizeSliderPaddingBottom: CGFloat = 20
    static let attributesToolsWidth: CGFloat = 250
    static let minimunSliderValue: Float = 15
    static let maximumSliderValue: Float = 30
    static let toolBarPaddingBottom: CGFloat = 10
    static let toolBarHeight: CGFloat = 45
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
    
    private lazy var fontSizeSlider: UISlider = {
        let slider = UISlider()
        slider.minimumValue = Constants.minimunSliderValue
        slider.maximumValue = Constants.maximumSliderValue
        slider.value = 21
        slider.addTarget(self, action: #selector(sliderValueChanged), for: .valueChanged)
        return slider
    }()
    private lazy var minimumValueLabel: UILabel = {
        let label = UILabel()
        let size = Int(Constants.minimunSliderValue)
        label.text = String(size)
        return label
    }()
    private lazy var maximumValueLabel: UILabel = {
        let label = UILabel()
        let size = Int(Constants.maximumSliderValue)
        label.text = String(size)
        return label
    }()
    private lazy var sliderTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Установите размер шрифта"
        return label
    }()
    
    private lazy var selectFontStyle: UIToolbar = {
        let toolBar = UIToolbar(frame:CGRect(x: 0, y: 0, width: 250, height: 45))
        let italicButton = UIBarButtonItem(title: "Курсив", style: .plain, target: self, action: #selector(italicButtonTapped))
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        let boldButton = UIBarButtonItem(title: "Жирный", style: .plain, target: self, action: #selector(boldButtonTapped))
        toolBar.items = [italicButton, flexibleSpace, boldButton]
        toolBar.tintColor = .black
        toolBar.barTintColor = .background
        return toolBar
    }()
    private let notification = NotificationCenter.default
    private var fontSizeSliderConstraint: NSLayoutConstraint?
    private lazy var doneButton: UIBarButtonItem = {
        let button = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(handleDoneButton))
        return button
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
        configureForKeyboard()
        output.viewIsReady()
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
        
        configureFontSizeSlider()
        configureFontStyleToolbar()
        view.backgroundColor = .background
    }
    
    private func configureFontSizeSlider() {
        view.addSubview(fontSizeSlider)
        fontSizeSlider.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        fontSizeSlider.anchor(width: Constants.attributesToolsWidth)
        fontSizeSliderConstraint = fontSizeSlider.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, 
                                                                          constant: -Constants.fontSizeSliderPaddingBottom)
        fontSizeSliderConstraint?.isActive = true
        
        view.addSubview(sliderTitleLabel)
        sliderTitleLabel.anchor(leading: fontSizeSlider.leadingAnchor,
                                trailing: fontSizeSlider.trailingAnchor,
                                bottom: fontSizeSlider.topAnchor)
        view.addSubview(minimumValueLabel)
        minimumValueLabel.anchor(leading: fontSizeSlider.leadingAnchor, top: fontSizeSlider.bottomAnchor)
        view.addSubview(maximumValueLabel)
        maximumValueLabel.anchor(top: fontSizeSlider.bottomAnchor, trailing: fontSizeSlider.trailingAnchor)
    }
    
    private func configureFontStyleToolbar() {
        view.addSubview(selectFontStyle)
        selectFontStyle.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        selectFontStyle.anchor(bottom: sliderTitleLabel.topAnchor,
                               paddingBottom: -Constants.toolBarPaddingBottom,
                               width: Constants.attributesToolsWidth,
                               height: Constants.toolBarHeight)
    }
    
    private func configureForKeyboard() {
        notification.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        notification.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        navigationItem.rightBarButtonItem = doneButton
        doneButton.isHidden = true
    }
    
    private func changeSelectedText(_ font: UIFont) {
        let range = noteTextView.selectedRange
        let string = NSMutableAttributedString(attributedString:
                                                    noteTextView.attributedText)
        let attributes = [NSAttributedString.Key.font: font]
        string.addAttributes(attributes, range: noteTextView.selectedRange)
        noteTextView.attributedText = string
        noteTextView.selectedRange = range
    }
    
// MARK: - Selectors
    
    @objc private func sliderValueChanged() {
        let fontSize = fontSizeSlider.value
        noteTextView.font = UIFont.systemFont(ofSize: CGFloat(fontSize))
        output.saveFontSize(fontSize)
    }
    
    @objc private func italicButtonTapped() {
        let size = CGFloat(fontSizeSlider.value)
        let font = UIFont.italicSystemFont(ofSize: size)
        changeSelectedText(font)
    }
    
    @objc private func boldButtonTapped() {
        let size = CGFloat(fontSizeSlider.value)
        let font = UIFont.boldSystemFont(ofSize: size)
        changeSelectedText(font)
    }
    
    @objc private func keyboardWillShow(_ notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            fontSizeSliderConstraint?.constant = -keyboardSize.height
            doneButton.isHidden = false
        }
    }
    
    @objc private func keyboardWillHide() {
        fontSizeSliderConstraint?.constant = -Constants.fontSizeSliderPaddingBottom
        doneButton.isHidden = true
    }
    
    @objc private func handleDoneButton() {
        view.endEditing(true)
    }
}

// MARK: - NoteInput

extension NoteViewController: NoteInput {
    func showNote(_ displayData: Note) {
        titleTextField.text = displayData.title
        noteTextView.text = displayData.note
    }
    
    func showAlert(_ message: String) {
        let alert = UIAlertController(title: "Внимание", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default))
        present(alert, animated: true)
    }
    
    func setFontSize(_ size: Float) {
        noteTextView.font = UIFont.systemFont(ofSize: CGFloat(size))
        fontSizeSlider.value = size
    }
}

// MARK: - UITextViewDelegate

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
