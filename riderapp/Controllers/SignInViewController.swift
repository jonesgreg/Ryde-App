//
//  SignInViewController.swift
//  riderapp
//
//  Created by Gregory Jones on 6/27/19.
//  Copyright © 2019 Gregory Jones. All rights reserved.
//

import UIKit




class SignInViewController: UIViewController {
  
    private let titleText: UITextView = {
        let textView = UITextView()
        
        let attributedText = NSMutableAttributedString(string: "What's your number?", attributes: [NSAttributedString.Key.font:UIFont(name: Fonts.montserratSemiBold, size: 22) as Any, NSAttributedString.Key.foregroundColor:UIColor.darkGray])
        
        attributedText.append(NSAttributedString(string: "\n\nWe'll text a code to verify your number.", attributes: [NSAttributedString.Key.font:UIFont(name: Fonts.montserratMedium, size: 14) as Any, NSAttributedString.Key.foregroundColor: UIColor.darkGray]))
        
        textView.attributedText = attributedText
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.textAlignment = .center
        textView.isEditable = false
        
        
        return textView
    }()
    
    public let phoneNumberInput: UITextField = {
        let textField = UITextField()
            textField.translatesAutoresizingMaskIntoConstraints = false
            textField.textAlignment = .center
            textField.font = UIFont(name: Fonts.montserratSemiBold, size: 16)
            textField.textColor = .darkGray
            textField.placeholder = "(305) 123-4567"
            textField.layer.cornerRadius = 5
            textField.layer.borderColor = UIColor.gray.cgColor.copy(alpha: 0.5)
            textField.layer.borderWidth = 1.5
            textField.layer.shadowOpacity = 0.2
            textField.layer.shadowRadius = 5
            textField.autocorrectionType = .no
            textField.keyboardType = .numberPad
        
        
        
        
    
          return textField
    }()
    
 
    private let ScrollView: UIScrollView = {
        let scrollView = UIScrollView()
            scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        return scrollView
    }()
    
    private let rideNowButton: UIButton = {
        let button = UIButton(type: .system)
        button.layer.borderWidth = 1
        button.layer.borderColor = Colors.darkOrange.cgColor
        button.backgroundColor = Colors.darkOrange
        button.setTitle("Next", for: .normal)
        button.titleLabel?.font = UIFont(name: Fonts.montserratSemiBold, size: 20)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 15
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(handleNextPage), for: .touchUpInside)
        
        return button
        
    }()
    
    @objc private func handleNextPage() {
        let nextViewController = self.storyboard?.instantiateViewController(withIdentifier: "CountryPicker")
        self.show(nextViewController!, sender: nil)
        
    }

   
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(titleText)
        view.addSubview(phoneNumberInput)
        view.addSubview(rideNowButton)
        setupLayout()
        customNavigationBar()
       
       
       
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
      
        
      
    }
    
   
    
    private func setupLayout() {
    titleText.topAnchor.constraint(equalTo: view.topAnchor, constant: 80).isActive = true
    titleText.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
    titleText.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    titleText.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
       
    rideNowButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
    rideNowButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
    rideNowButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -30).isActive = true
    rideNowButton.heightAnchor.constraint(equalToConstant: 45).isActive = true
    
    phoneNumberInput.heightAnchor.constraint(equalToConstant: 45).isActive = true
    phoneNumberInput.topAnchor.constraint(equalTo: view.topAnchor, constant: 180).isActive = true
    phoneNumberInput.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24).isActive = true
    phoneNumberInput.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24).isActive = true
        
  
   
    }
  
   func customNavigationBar() {
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = .clear
    }
    
  
    
     @objc func keyboardWillShow(notification: NSNotification) {
        let userInfo: NSDictionary = notification.userInfo! as NSDictionary
        let keyboardInfo = userInfo[UIResponder.keyboardFrameBeginUserInfoKey] as! NSValue
        let keyboardSize = keyboardInfo.cgRectValue.size
        let contentInsets = UIEdgeInsets(top: 0, left: 0, bottom: keyboardSize.height, right: 0)
        ScrollView.contentInset = contentInsets
        ScrollView.scrollIndicatorInsets = contentInsets
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        ScrollView.contentInset = .zero
        ScrollView.scrollIndicatorInsets = .zero
    }
}

extension UITextField {
    
    func underlined() {
        let border = CALayer()
        let width = CGFloat(2.0)
            border.borderColor = UIColor.darkGray.cgColor
            border.bounds = CGRect(x: 0, y: 0, width:  self.frame.size.width, height: self.frame.size.height)
            border.borderWidth = width
        self.layer.addSublayer(border)
        self.layer.masksToBounds = true
        
    }
}


