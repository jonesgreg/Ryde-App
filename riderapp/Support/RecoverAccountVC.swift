//
//  RecoverAccountViewController.swift
//  riderapp
//
//  Created by Gregory Jones on 8/6/19.
//  Copyright © 2019 Gregory Jones. All rights reserved.
//

import UIKit

class RecoverAcountViewController: UIViewController {
   
    var buttonConstraint: NSLayoutConstraint?
    
    
    // MARK: - Overriden function
    override func viewDidLoad() {
        super.viewDidLoad()
        [titleText,emailView, descText,nextButton, nextButtonImage, emailInput,].forEach { view.addSubview($0) }
        setUpLayout()
        configureUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        emailInput.becomeFirstResponder()
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
        let attributedText = NSMutableAttributedString(string: "Recover your account", attributes: [NSAttributedString.Key.font:UIFont(name: Fonts.montserratSemiBold, size: 20) as Any, NSAttributedString.Key.foregroundColor:UIColor.black])
        textView.attributedText = attributedText
        textView.textAlignment = .center
        textView.isEditable = false
        return textView
    }()
    
    private let emailInput: UITextField = {
        let textField = userInputField()
        textField.attributedPlaceholder = NSAttributedString(string: "Email Address", attributes:[NSAttributedString.Key.font:UIFont(name: Fonts.montserratRegular, size: 18) as Any, NSAttributedString.Key.foregroundColor:UIColor.lightGray])
        textField.keyboardAppearance = .dark
         textField.textColor = UIColor.black
        textField.textAlignment = .left
        return textField
    }()
    
    private let emailView: UIView = {
        let view = UIView()
        view.layer.borderWidth = 0.5
        view.layer.borderColor = Colors.lightGreyColor.cgColor
        view.layer.cornerRadius = 4
        return view
    }()
    
    private let nextButton: UIButton = {
        let button = NextButton(type: .system)
        button.addTarget(self, action: #selector(handleNextPage), for: .touchUpInside)
        return button
    }()
    
 
    
    private let nextButtonImage: UIImageView = {
        let imageView = UIImageView(image:#imageLiteral(resourceName: "rightarrow"))
        imageView.contentMode = .scaleAspectFit
        imageView.width(constant: 22)
        imageView.height(constant: 22)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let descText: UITextView = {
        let textView = UITextView()
        let attributedText = NSMutableAttributedString(string: "We'll send you a vertification email.", attributes: [NSAttributedString.Key.font:UIFont(name: Fonts.montserratRegular, size: 14) as Any, NSAttributedString.Key.foregroundColor:UIColor.lightGray])
        textView.attributedText = attributedText
        textView.textAlignment = .center
        textView.isEditable = false
        return textView
    }()
    
    private func setUpLayout() {
        titleText.anchor(top: view.topAnchor, bottom: view.bottomAnchor, leading: view.leadingAnchor, trailing: view.trailingAnchor, padding: .init(top: 50 , left: 32, bottom: 0, right: 32))
        nextButton.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 145).isActive = true
        buttonConstraint = nextButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10)
        buttonConstraint?.isActive = true
        
        nextButtonImage.centerXAnchor.constraint(equalTo: nextButton.centerXAnchor).isActive = true
        nextButtonImage.centerYAnchor.constraint(equalTo: nextButton.centerYAnchor).isActive = true
        
        
      descText.anchor(top: view.topAnchor, bottom: view.bottomAnchor, leading: view.leadingAnchor, trailing: view.trailingAnchor, padding: .init(top: 220, left: 32, bottom: 0, right: 32))
        
        emailView.anchor(top: view.topAnchor, bottom: nil, leading: view.leadingAnchor, trailing: view.trailingAnchor, padding: .init(top: 160, left: 32, bottom: 0, right: 32), size: .init(width: 0, height: 50))
        emailInput.anchor(top: view.topAnchor, bottom: nil, leading: emailView.leadingAnchor, trailing: emailView.trailingAnchor, padding: .init(top: 173, left: 15, bottom: 0, right: 0))
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
    
    // MARK: - Selectors
    
    @objc private func handleNextPage() {
        let nextViewController = ConfirmationEmailViewController()
        self.navigationController?.pushViewController(nextViewController, animated: false)
        let generator = UIImpactFeedbackGenerator(style: .heavy) // Add the vibration tap to the button
            generator.impactOccurred()
    }
    
    @objc private func handlePreviousPage() {
        self.navigationController?.popViewController(animated: false)
        
    }
    
}




