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
    
   // MARK: - Overriden function
    override func viewDidLoad() {
        super.viewDidLoad()
        [titleText, nextButton, VerifyNumberStackView, txtOTPStackView].forEach { view.addSubview($0) }
       
        setUpLayout()
        customNavigationBar()
    }
    
  // MARK: - Private function
   
    private let titleText: UITextView = {
        let textView = UITextView()
        let attributedText = NSMutableAttributedString(string: "Enter the 4-digit code sent to you at (310) 123-4567", attributes: [NSAttributedString.Key.font:UIFont(name: Fonts.montserratMedium, size: 18) as Any, NSAttributedString.Key.foregroundColor:UIColor.darkGray])
            textView.attributedText = attributedText
            textView.textAlignment = .center
            textView.isEditable = false
            return textView
    }()
    
    lazy var VerifyNumberStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [codeOne, codeTwo, codeThree, codeFour])
            stackView.translatesAutoresizingMaskIntoConstraints = false
            stackView.axis = .horizontal
            stackView.spacing = 10
            stackView.distribution = .fillEqually
            return stackView
    }()
    
    lazy var txtOTPStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [txtOPT1, txtOPT2, txtOPT3, txtOPT4])
            stackView.translatesAutoresizingMaskIntoConstraints = false
            stackView.axis = .horizontal
            stackView.spacing = 10
            stackView.distribution = .fillEqually
            return stackView
    }()
    
  private let txtOPT1: UITextField = {
        let textField = codeTextField()
            textField.attributedPlaceholder = NSAttributedString(string: "1", attributes: [NSAttributedString.Key.font:UIFont(name: Fonts.montserratBold, size: 18) as Any, NSAttributedString.Key.foregroundColor:UIColor.darkGray])
            return textField
        
    }()
   
    private let txtOPT2: UITextField = {
        let textField = codeTextField()
            textField.attributedPlaceholder = NSAttributedString(string: "2", attributes: [NSAttributedString.Key.font:UIFont(name: Fonts.montserratBold, size: 18) as Any, NSAttributedString.Key.foregroundColor:UIColor.darkGray])
            return textField
    }()
   
    private let txtOPT3: UITextField = {
        let textField = codeTextField()
        textField.attributedPlaceholder = NSAttributedString(string: "3", attributes: [NSAttributedString.Key.font:UIFont(name: Fonts.montserratBold, size: 18) as Any, NSAttributedString.Key.foregroundColor:UIColor.darkGray])
        return textField
    }()
    
    private let txtOPT4: UITextField = {
        let textField = codeTextField()
        textField.attributedPlaceholder = NSAttributedString(string: "4", attributes: [NSAttributedString.Key.font:UIFont(name: Fonts.montserratBold, size: 18) as Any, NSAttributedString.Key.foregroundColor:UIColor.darkGray])
        return textField
      
    }()
    
    private let nextButton: UIButton = {
        let button = purpleButton(type: .system)
        button.setTitle("Next", for: .normal)
        button.titleLabel?.font = UIFont(name: Fonts.montserratSemiBold, size: 20)
        button.addTarget(self, action: #selector(handleNextPage), for: .touchUpInside)
        return button
        
    }()
    
    @objc private func handleNextPage() {
        let nextViewController = self.storyboard?.instantiateViewController(withIdentifier: "email")
        self.show(nextViewController!, sender: nil)
        
    }
    
    
    
    
   
   private func setUpLayout() {
          titleText.anchor(top: view.topAnchor, bottom: view.bottomAnchor, leading: view.leadingAnchor, trailing: view.trailingAnchor, padding: .init(top: 100, left: 16, bottom: 0, right: 16))
        
        
        nextButton.anchor(top: view.topAnchor, bottom: nil, leading: view.leadingAnchor, trailing: view.trailingAnchor, padding: .init(top: 270, left: 16, bottom: 0, right: 16), size: .init(width:0, height: 50))
        
        VerifyNumberStackView.anchor(top: view.topAnchor, bottom: nil, leading: view.leadingAnchor, trailing: view.trailingAnchor, padding: .init(top: 210, left: 32, bottom: 0, right: 32), size: .init(width: 0, height: 1.2))
    
       txtOTPStackView.anchor(top: view.topAnchor, bottom: nil, leading: view.leadingAnchor, trailing: view.trailingAnchor, padding: .init(top: 185, left: 32, bottom: 0, right: 32))
    }
    
    private func customNavigationBar() {
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = .clear
        self.navigationController?.navigationBar.tintColor = UIColor.black
    }
    
}
