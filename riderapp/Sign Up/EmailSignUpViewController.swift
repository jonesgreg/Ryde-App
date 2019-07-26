//
//  EmailSignUpViewController.swift
//  riderapp
//
//  Created by Gregory Jones on 7/23/19.
//  Copyright © 2019 Gregory Jones. All rights reserved.
//

import UIKit

class EmailSignUpViewController: UIViewController {
   
    
    // MARK: - Overriden function
   
    override func viewDidLoad() {
        super.viewDidLoad()
        [titleText,emailView, emailInput, descText, nextButton].forEach { view.addSubview($0) }
        setUpLayout()
        customNavigationBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        emailInput.becomeFirstResponder()
    }
    
    // MARK: - Private functions
    
    private let titleText: UITextView = {
        let textView = UITextView()
        let attributedText = NSMutableAttributedString(string: "What's your email?", attributes: [NSAttributedString.Key.font:UIFont(name: Fonts.montserratSemiBold, size: 22) as Any, NSAttributedString.Key.foregroundColor:UIColor.black])
            textView.attributedText = attributedText
            textView.textAlignment = .center
            textView.isEditable = false
            return textView
    }()
    
    private let emailInput: UITextField = {
        let textField = userInputField()
           return textField
    }()
    
    private let emailView: UIView = {
        let view = UIView()
            view.layer.borderWidth = 5
            view.layer.borderColor = Colors.lightGreyColor.cgColor
            return view
    }()
    
    private let descText: UITextView = {
        let textView = UITextView()
        let attributedText = NSMutableAttributedString(string: "Enter a school e-mail in order to sign up.", attributes: [NSAttributedString.Key.font:UIFont(name: Fonts.montserratMedium, size: 16) as Any, NSAttributedString.Key.foregroundColor:UIColor.lightGray])
            textView.attributedText = attributedText
            textView.textAlignment = .center
            textView.isEditable = false
            return textView
    }()
    
    private let nextButton: UIButton = {
            let button = purpleButton(type: .system)
            button.setTitle("Next", for: .normal)
            button.titleLabel?.font = UIFont(name: Fonts.montserratSemiBold, size: 20)
            button.addTarget(self, action: #selector(handleNextPage), for: .touchUpInside)
            return button
    }()
    
    @objc private func handleNextPage() {
        let nextViewController = self.storyboard?.instantiateViewController(withIdentifier: "password")
        self.show(nextViewController!, sender: nil)
        
    }
    
    private func setUpLayout() {
        titleText.anchor(top: view.topAnchor, bottom: view.bottomAnchor, leading: view.leadingAnchor, trailing: view.trailingAnchor, padding: .init(top: 80, left: 0, bottom: 0, right: 0))
        emailView.anchor(top: view.topAnchor, bottom: nil, leading: view.leadingAnchor, trailing: view.trailingAnchor, padding: .init(top: 180, left: 32, bottom: 0, right: 32), size: .init(width: 0, height: 1))
        emailInput.anchor(top: view.topAnchor, bottom: emailView.topAnchor, leading: emailView.leadingAnchor, trailing: emailView.trailingAnchor, padding: .init(top: 155, left: 16, bottom: 0, right: 16))
        descText.anchor(top: emailView.bottomAnchor, bottom: view.bottomAnchor, leading: view.leadingAnchor, trailing: view.trailingAnchor, padding: .init(top: 15, left: 0, bottom: 0, right: 0))
        nextButton.anchor(top: view.topAnchor, bottom: nil, leading: view.leadingAnchor, trailing: view.trailingAnchor, padding: .init(top: 250, left: 16, bottom: 0, right: 16), size: .init(width:0, height: 50))
    }
    
    private func customNavigationBar() {
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = .clear
        self.navigationController?.navigationBar.tintColor = UIColor.black
    }
    
}



