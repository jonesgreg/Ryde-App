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
        [emailView,emailIcon,verifyLabel,nextButton, nextButtonImage, emailInput,].forEach { view.addSubview($0) }
        emailInput.delegate = self
        setUpLayout()
        configureUI()
        navigationItem.largeTitleDisplayMode = .never
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
         self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    // MARK: - Private functions
    
    private let titleText: UITextView = {
        let textView = UITextView()
        let attributedText = NSMutableAttributedString(string: "Recover your account", attributes: [NSAttributedString.Key.font:UIFont(name: Fonts.gilroyBold, size: 20) as Any, NSAttributedString.Key.foregroundColor:UIColor.black])
       
                   textView.attributedText = attributedText
        textView.attributedText = attributedText
        textView.textAlignment = .center
        textView.isEditable = false
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()
private let emailInput: UITextField = {
        let textField = userInputField()
        textField.attributedPlaceholder = NSAttributedString(string: "Email Address", attributes: [NSAttributedString.Key.font: UIFont(name: Fonts.gilroyRegular, size: 15) as Any, NSAttributedString.Key.foregroundColor: UIColor.lightGray])
            textField.textColor = UIColor.black
            textField.textAlignment = .left
    
        
            return textField
    }()
    

    
    private let emailView: UIView = {
        let view = UIView()
            view.layer.shadowColor = UIColor.black.cgColor;
            view.layer.masksToBounds = false;
            view.layer.cornerRadius  =  10;
            view.layer.borderWidth   = 1.0;
            view.layer.borderColor = Colors.textFieldBarColor.cgColor
            view.backgroundColor     =  .white
            view.translatesAutoresizingMaskIntoConstraints = false
     return view
    }()
    
    private let emailIcon: UIImageView = {
        let iv = UIImageView(image: #imageLiteral(resourceName: "email_address"))
        iv.contentMode = .scaleAspectFit
        iv.width(constant: 20)
        iv.height(constant: 20)
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
        
    }()
    private let verifyLabel: UILabel = {
        let emailLabel = UILabel()
        let attributedText = NSMutableAttributedString(string: "We'll send you a verification email", attributes: [NSAttributedString.Key.font:UIFont(name: Fonts.gilroyRegular, size: 13) as Any, NSAttributedString.Key.foregroundColor:UIColor.darkGray])
           emailLabel.attributedText = attributedText
            emailLabel.translatesAutoresizingMaskIntoConstraints = true
           emailLabel.textAlignment = .center
          return emailLabel
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
    
   
    private func setUpLayout() {
        
   // nextButton.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 135).isActive = true
    nextButton.trailingAnchor.constraint(equalTo:view.trailingAnchor, constant: -10).isActive = true
        buttonConstraint = nextButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10)
      buttonConstraint?.isActive = true
        
      nextButtonImage.centerXAnchor.constraint(equalTo: nextButton.centerXAnchor).isActive = true
        nextButtonImage.centerYAnchor.constraint(equalTo: nextButton.centerYAnchor).isActive = true
        
        
emailView.anchor(top: view.topAnchor, bottom: nil, leading: view.leadingAnchor, trailing: view.trailingAnchor, padding: .init(top: 50, left: 32, bottom: 0, right: 32), size: .init(width: 0, height: 50))
        emailInput.anchor(top: emailView.topAnchor, bottom: emailView.bottomAnchor, leading: emailIcon.trailingAnchor, trailing: emailView.trailingAnchor, padding: .init(top: 0, left: 8, bottom: 0, right: 0))
       
        
emailIcon.anchor(top: emailView.topAnchor, bottom: nil, leading: emailView.leadingAnchor, trailing: nil, padding: .init(top: 15, left: 13, bottom: 0, right: 0))
        
    verifyLabel.anchor(top: emailView.topAnchor, bottom: nil, leading: emailView.leadingAnchor, trailing: emailView.trailingAnchor, padding: .init(top: 60, left: 16, bottom: 0, right: 16))
               
   
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
        navigationItem.title = "Recover your account"
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.tintColor = .black
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.backgroundColor = .clear
          let textAttributes = [NSAttributedString.Key.font: UIFont(name: Fonts.gilroySemiBold, size: 18) as Any, NSAttributedString.Key.foregroundColor:UIColor.black]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        // Custom back button
        let backButton = UIButton(type: .system)
            backButton.setBackgroundImage(#imageLiteral(resourceName: "backarrow"), for:.normal)
            backButton.addTarget(self, action: #selector(handlePreviousPage), for: .touchUpInside)
            backButton.width(constant: 17)
            backButton.height(constant: 17)
            self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backButton)
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

extension RecoverAcountViewController: UITextFieldDelegate {
    
    // Stop Editing on Return Key Tap
      override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
          self.view.endEditing(true)
          
      }
    private func textFieldShouldReturn(textField: UITextField!) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
}



