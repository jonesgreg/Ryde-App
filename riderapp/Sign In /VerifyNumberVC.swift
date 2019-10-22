//
//  VerifyNumberViewController.swift
//  riderapp
//
//  Created by Gregory Jones on 6/30/19.
//  Copyright © 2019 Gregory Jones. All rights reserved.
//

import UIKit

class VerifyNumberViewController: UIViewController {
    
    let codeOne = VerifyView()
    let codeTwo = VerifyView()
    let codeThree = VerifyView()
    let codeFour = VerifyView()
    let codeFive = VerifyView()
    let codeSix = VerifyView()
    var buttonConstraint: NSLayoutConstraint?
    
   // MARK: - Overriden function
    override func viewDidLoad() {
        super.viewDidLoad()
        [titleTextView, nextButton,nextButtonImage,  VerifyNumberStackView, txtOTPStackView, resendCodeButton].forEach { view.addSubview($0) }
       setUpLayout()
       configureUI()
      
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
       // verifyInput.becomeFirstResponder()
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
       
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self)
          self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }
  
   
    // MARK: - Private function
    
    private let titleTextView: UITextView =  {
        let textView = UITextView()
        let attributedText = NSMutableAttributedString(string: "What's the 6 digit code?", attributes: [NSAttributedString.Key.font:UIFont(name: Fonts.gilroyBold, size:22) as Any, NSAttributedString.Key.foregroundColor:UIColor.black])
        attributedText.append(NSAttributedString(string: "\nEnter the code sent to your phone number.", attributes: [NSAttributedString.Key.font:UIFont(name: Fonts.gilroyMedium, size: 15) as Any, NSAttributedString.Key.foregroundColor: UIColor.black]))
            textView.attributedText = attributedText
            textView.translatesAutoresizingMaskIntoConstraints = false
            textView.textAlignment = .left
            textView.isEditable = false
            textView.isScrollEnabled = false
        return textView
    }()
   
    private let descText: UITextView = {
        let textView = UITextView()
        let attributedText = NSMutableAttributedString(string: "Enter the 4-digit code sent to you at (310) 123-4567", attributes: [NSAttributedString.Key.font:UIFont(name: Fonts.gilroyRegular, size: 16) as Any, NSAttributedString.Key.foregroundColor:UIColor.black])
            textView.attributedText = attributedText
            textView.textAlignment = .center
            textView.isEditable = false
            return textView
    }()
    
    lazy var VerifyNumberStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [codeOne, codeTwo, codeThree, codeFour, codeFive, codeSix])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = 8
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    lazy var txtOTPStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [txtOPT1, txtOPT2, txtOPT3, txtOPT4, txtOPT5, txtOPT6])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = 10
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    private let txtOPT1: UITextField = {
        let textField = codeTextField()
        textField.attributedPlaceholder = NSAttributedString(string: "1", attributes: [NSAttributedString.Key.font:UIFont(name: Fonts.gilroySemiBold, size: 32) as Any, NSAttributedString.Key.foregroundColor:UIColor.black])
        return textField
        
    }()
    
    private let txtOPT2: UITextField = {
        let textField = codeTextField()
        textField.attributedPlaceholder = NSAttributedString(string: "2", attributes: [NSAttributedString.Key.font:UIFont(name: Fonts.gilroySemiBold, size: 32) as Any, NSAttributedString.Key.foregroundColor:UIColor.black])
        return textField
    }()
    
    private let txtOPT3: UITextField = {
        let textField = codeTextField()
        textField.attributedPlaceholder = NSAttributedString(string: "3", attributes: [NSAttributedString.Key.font:UIFont(name: Fonts.gilroySemiBold, size: 32) as Any, NSAttributedString.Key.foregroundColor:UIColor.black])
        return textField
    }()
    
    private let txtOPT4: UITextField = {
        let textField = codeTextField()
        textField.attributedPlaceholder = NSAttributedString(string: "4", attributes: [NSAttributedString.Key.font:UIFont(name: Fonts.gilroySemiBold, size: 32) as Any, NSAttributedString.Key.foregroundColor:UIColor.black])
        return textField
        
    }()
    
    private let txtOPT5: UITextField = {
        let textField = codeTextField()
        textField.attributedPlaceholder = NSAttributedString(string: "5", attributes: [NSAttributedString.Key.font:UIFont(name: Fonts.gilroySemiBold, size: 32) as Any, NSAttributedString.Key.foregroundColor:UIColor.black])
        return textField
        
    }()
    
    private let txtOPT6: UITextField = {
        let textField = codeTextField()
        textField.attributedPlaceholder = NSAttributedString(string: "6", attributes: [NSAttributedString.Key.font:UIFont(name: Fonts.gilroySemiBold, size: 32) as Any, NSAttributedString.Key.foregroundColor:UIColor.black])
        return textField
        
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
    
    
    private let resendCodeButton: UIButton =  {
        let button = UIButton(type: .system)
        button.setTitle("Resend Code", for: .normal)
        button.titleLabel?.font = UIFont(name: Fonts.gilroyRegular, size: 14)
        button.setTitleColor(Colors.fleetGreen, for: .normal)
        return button
    }()
    
    
      private func setUpLayout() {
        titleTextView.anchor(top: view.safeAreaLayoutGuide.topAnchor, bottom: view.bottomAnchor, leading: view.leadingAnchor, trailing: view.trailingAnchor, padding: .init(top: 0, left: 32, bottom: 0, right: 32))
       
        nextButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10).isActive = true
        buttonConstraint = nextButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10)
        buttonConstraint?.isActive = true
        
        nextButtonImage.centerXAnchor.constraint(equalTo: nextButton.centerXAnchor).isActive = true
        nextButtonImage.centerYAnchor.constraint(equalTo: nextButton.centerYAnchor).isActive = true
        
        VerifyNumberStackView.anchor(top: view.topAnchor, bottom: nil, leading: view.leadingAnchor, trailing: view.trailingAnchor, padding: .init(top: 200, left: 40, bottom: 0, right: 40), size: .init(width: 0, height: 1.2))
        
        txtOTPStackView.anchor(top: view.topAnchor, bottom: nil, leading: view.leadingAnchor, trailing: view.trailingAnchor, padding: .init(top: 155, left: 40, bottom: 0, right: 40))
       
        resendCodeButton.anchor(top: view.topAnchor, bottom: nil, leading: view.safeAreaLayoutGuide.leadingAnchor, trailing: view.safeAreaLayoutGuide.trailingAnchor, padding: .init(top: 218, left: 32, bottom: 0, right: 32))
    
      
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
        
        // Custom Back Button
        let backButton = UIButton(type: .system)
        backButton.setBackgroundImage(#imageLiteral(resourceName: "backarrow"), for:.normal)
        backButton.addTarget(self, action: #selector(handlePreviousPage), for: .touchUpInside)
        backButton.width(constant: 17)
        backButton.height(constant: 17)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backButton)
     
    }
    
    // MARK: - Selectors
    
    @objc private func handleNextPage() {
        let nextViewController = AgreementViewController()
        self.navigationController?.pushViewController(nextViewController, animated: false)
       let generator = UIImpactFeedbackGenerator(style: .heavy) // Add the vibration tap to the button
              generator.impactOccurred()
    }
    
    @objc private func handlePreviousPage() {
       self.navigationController?.popViewController(animated: false)
        
    }
    
  
    
}
