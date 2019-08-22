//
//  ConfirmationEmailVC.swift
//  riderapp
//
//  Created by Gregory Jones on 8/6/19.
//  Copyright © 2019 Gregory Jones. All rights reserved.
//

import UIKit

class ConfirmationEmailViewController: UIViewController {
    
    var buttonConstraint: NSLayoutConstraint?
    
    // MARK: - Overriden function
    
    override func viewDidLoad() {
        super.viewDidLoad()
        [titleText,descText, nextButton].forEach { view.addSubview($0) }
        setUpLayout()
        configureUI()
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self)
    }
    
    // MARK: - Private functions
    
    private let titleText: UITextView = {
        let textView = UITextView()
        let attributedText = NSMutableAttributedString(string: "Confirmation Email", attributes: [NSAttributedString.Key.font:UIFont(name: Fonts.montserratSemiBold, size: 20) as Any, NSAttributedString.Key.foregroundColor:UIColor.black])
        textView.attributedText = attributedText
        textView.textAlignment = .center
        textView.isEditable = false
        return textView
    }()
    
    private let nextButton: UIButton = {
        let button = redButton(type: .system)
        button.setTitle("Resend Email", for: .normal)
        button.titleLabel?.font = UIFont(name: Fonts.montserratSemiBold, size: 20)
        button.layer.cornerRadius = 22
        return button
    }()
    
    private let descText: UITextView = {
        let textView = UITextView()
        let attributedText = NSMutableAttributedString(string: "We just sent a confirmation email to the address below. Please confirm your account by tapping on the link in the email. ", attributes: [NSAttributedString.Key.font:UIFont(name: Fonts.montserratMedium, size: 18) as Any, NSAttributedString.Key.foregroundColor:UIColor.lightGray])
        textView.attributedText = attributedText
        textView.textAlignment = .center
        textView.isEditable = false
        return textView
    }()
    
    private func setUpLayout() {
        titleText.anchor(top: view.topAnchor, bottom: view.bottomAnchor, leading: view.leadingAnchor, trailing: view.trailingAnchor, padding: .init(top: 80, left: 32, bottom: 0, right: 32))
        
        nextButton.anchor(top: nil, bottom: nil, leading: view.leadingAnchor, trailing: view.trailingAnchor, padding: .init(top:0, left: 32, bottom: 0, right: 32), size: .init(width: 0, height: 50))
        buttonConstraint = nextButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10)
        buttonConstraint?.isActive = true
        
        descText.anchor(top: view.topAnchor, bottom: view.bottomAnchor, leading: view.leadingAnchor, trailing: view.trailingAnchor, padding: .init(top: 200, left: 32, bottom: 0, right: 32))
    }
    
    @objc func keyboardWillShow(_ notification: Notification) {
        let userInfo = notification.userInfo
        let keyboardSize = userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue
        let keyboardHeight = keyboardSize.cgRectValue.height
        buttonConstraint?.constant = -10 - keyboardHeight
        
        let animationDuration = userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as! Double
        UIView.animate(withDuration: animationDuration) {
            self.view.layoutIfNeeded()
        }
    }
    
    @objc func keyboardWillHide(_ notification: Notification) {
        buttonConstraint?.constant = -10
        let userInfo = notification.userInfo
        let animationDuration = userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as! Double
        UIView.animate(withDuration: animationDuration) {
            self.view.layoutIfNeeded()
        }
    }
    
    func configureUI() {
        view.backgroundColor = .white
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.tintColor = .black
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.navigationBar.backgroundColor = .clear
        navigationItem.leftBarButtonItem = UIBarButtonItem.barButton(self, action: #selector(handlePreviousPage), imageName: "backarrow")
    }
    
    // MARK: - Selector
   @objc private func handlePreviousPage() {
        self.navigationController?.popViewController(animated: false)
        
    }
    
    
}




