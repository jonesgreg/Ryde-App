//
//  PasswordSignUpViewController.swift
//  riderapp
//
//  Created by Gregory Jones on 7/24/19.
//  Copyright © 2019 Gregory Jones. All rights reserved.
//

import UIKit

class PasswordSignUpViewController: UIViewController {
    
    // MARK: - Overriden function
    
    override func viewDidLoad() {
        super.viewDidLoad()
        [titleText,passwordView, passwordInput, descText, nextButton, forgotPasswordButton].forEach { view.addSubview($0) }
        setUpLayout()
        customNavigationBar()
    }
   
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        passwordInput.becomeFirstResponder()
        
    }
    
    // MARK: - Private functions
    
    private let titleText: UITextView = {
        let textView = UITextView()
        let attributedText = NSMutableAttributedString(string: "Password?", attributes: [NSAttributedString.Key.font:UIFont(name: Fonts.montserratSemiBold, size: 20) as Any, NSAttributedString.Key.foregroundColor:UIColor.black])
            textView.attributedText = attributedText
            textView.textAlignment = .center
            textView.isEditable = false
            return textView
    }()
    
    private let passwordInput: UITextField = {
        let textField = UITextField()
            textField.borderStyle = .none
            textField.textColor = UIColor.darkGray
            textField.textAlignment = .center
            textField.tintColor = UIColor.init(red: 144/255, green: 19/255, blue: 254/255, alpha: 1)
            textField.font = UIFont(name: Fonts.montserratSemiBold, size: 20)
            textField.autocapitalizationType = UITextAutocapitalizationType.none
            textField.autocorrectionType = .no
            textField.isSecureTextEntry = true
            textField.returnKeyType = UIReturnKeyType.done
            textField.clearButtonMode = UITextField.ViewMode.whileEditing
            return textField
    }()
    
    private let passwordView: UIView = {
        let view = UIView()
            view.layer.borderWidth = 5
            view.layer.borderColor = Colors.lightGreyColor.cgColor
            return view
    }()
    
    private let descText: UITextView = {
        let textView = UITextView()
        let attributedText = NSMutableAttributedString(string: "At least 8 characters.", attributes: [NSAttributedString.Key.font:UIFont(name: Fonts.montserratMedium, size: 16) as Any, NSAttributedString.Key.foregroundColor:UIColor.lightGray])
            textView.attributedText = attributedText
            textView.textAlignment = .center
            textView.isEditable = false
            return textView
    }()
    
    private let forgotPasswordButton: UIButton =  {
        let button = UIButton(type: .system)
            button.setTitle("Forgot Password?", for: .normal)
            button.titleLabel?.font = UIFont(name: Fonts.montserratMedium, size: 16)
            button.setTitleColor(.lightGray, for: .normal)
            return button
    }()
    
    private let nextButton: UIButton = {
        let button = UIButton(type: .system)
            button.layer.borderWidth = 2
            button.layer.borderColor = Colors.darkPurple.cgColor
            button.backgroundColor = Colors.darkPurple
            button.setTitle("Next", for: .normal)
            button.titleLabel?.font = UIFont(name: Fonts.montserratSemiBold, size: 20)
            button.setTitleColor(.white, for: .normal)
            button.layer.cornerRadius = 15
            button.addTarget(self, action: #selector(handleNextPage), for: .touchUpInside)
            return button
    }()
    
    @objc private func handleNextPage() {
        let nextViewController = self.storyboard?.instantiateViewController(withIdentifier: "homepage")
        self.show(nextViewController!, sender: nil)
        
    }
    
    private func setUpLayout() {
        titleText.anchor(top: view.topAnchor, bottom: view.bottomAnchor, leading: view.leadingAnchor, trailing: view.trailingAnchor, padding: .init(top: 80, left: 0, bottom: 0, right: 0))
        passwordView.anchor(top: view.topAnchor, bottom: nil, leading: view.leadingAnchor, trailing: view.trailingAnchor, padding: .init(top: 180, left: 32, bottom: 0, right: 32), size: .init(width: 0, height: 1))
        passwordInput.anchor(top: view.topAnchor, bottom: passwordView.topAnchor, leading: passwordView.leadingAnchor, trailing: passwordView.trailingAnchor, padding: .init(top: 155, left: 16, bottom: 0, right: 16))
        descText.anchor(top: passwordView.bottomAnchor, bottom: view.bottomAnchor, leading: view.leadingAnchor, trailing: view.trailingAnchor, padding: .init(top: 15, left: 0, bottom: 0, right: 0))
        nextButton.anchor(top: view.topAnchor, bottom: nil, leading: view.leadingAnchor, trailing: view.trailingAnchor, padding: .init(top: 300, left: 16, bottom: 0, right: 16), size: .init(width:0, height: 50))
        forgotPasswordButton.anchor(top: nil, bottom: nextButton.topAnchor, leading: view.leadingAnchor, trailing: view.trailingAnchor, padding: .init(top: 0, left: 16, bottom: 40, right: 16))
    }
    
    private func customNavigationBar() {
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = .clear
        self.navigationController?.navigationBar.tintColor = UIColor.black
    }
    
}
    

