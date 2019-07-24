//
//  VerifyNumberViewController.swift
//  riderapp
//
//  Created by Gregory Jones on 6/30/19.
//  Copyright © 2019 Gregory Jones. All rights reserved.
//

import UIKit

class VerifyNumberViewController:UIViewController {
    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        [titleText, nextButton, fourDigitCodeViewOne, fourDigitCodeViewTwo, fourDigitCodeViewThree, fourDigitCodeViewFour, resendCodeButton].forEach { view.addSubview($0) }
        setUpLayout()
        customNavigationBar()
        

    }
    
    private let titleText: UITextView = {
        let textView = UITextView()
        
        let attributedText = NSMutableAttributedString(string: "Enter the 4-digit code sent to you at (310) 123-4567", attributes: [NSAttributedString.Key.font:UIFont(name: Fonts.montserratMedium, size: 18) as Any, NSAttributedString.Key.foregroundColor:UIColor.init(red: 144/255, green: 19/255, blue: 254/255, alpha: 1)])
        
        textView.attributedText = attributedText
        textView.textAlignment = .center
        textView.isEditable = false
        
        return textView
    }()
    
  
    private let resendCodeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Resend code", for: .normal)
        button.titleLabel?.font = UIFont(name: Fonts.montserratMedium, size: 16)
        button.setTitleColor(UIColor.init(red: 144/255, green: 19/255, blue: 254/255, alpha: 1), for: .normal)
        
        
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
        let nextViewController = self.storyboard?.instantiateViewController(withIdentifier: "email")
        self.show(nextViewController!, sender: nil)
        
    }
   
   
    
    private let fourDigitCodeViewOne: UIView = {
        let codeView = UIView()
        codeView.layer.borderWidth = 2
        codeView.layer.borderColor = Colors.lightGreyColor.cgColor
        
        return codeView
     }()
    
    private let fourDigitCodeViewTwo: UIView = {
        let codeView = UIView()
        codeView.layer.borderWidth = 2
        codeView.layer.borderColor = Colors.lightGreyColor.cgColor
        
        return codeView
    }()
    
    private let fourDigitCodeViewThree: UIView = {
        let codeView = UIView()
        codeView.layer.borderWidth = 2
        codeView.layer.borderColor = Colors.lightGreyColor.cgColor
        
        return codeView
    }()
    
    private let fourDigitCodeViewFour: UIView = {
        let codeView = UIView()
        codeView.layer.borderWidth = 2
        codeView.layer.borderColor = Colors.lightGreyColor.cgColor
        
        return codeView
    }()
    
     private func setUpLayout() {
        titleText.anchor(top: view.topAnchor, bottom: view.bottomAnchor, leading: view.leadingAnchor, trailing: view.trailingAnchor, padding: .init(top: 100, left: 16, bottom: 0, right: 16))
        
        
        nextButton.anchor(top: view.topAnchor, bottom: nil, leading: view.leadingAnchor, trailing: view.trailingAnchor, padding: .init(top: 250, left: 16, bottom: 0, right: 16), size: .init(width:0, height: 50))
        
         fourDigitCodeViewOne.anchor(top: view.topAnchor, bottom: nil, leading: titleText.leadingAnchor, trailing: nil, padding: .init(top: 202, left: 75, bottom: 0, right: 0), size:.init(width: 40, height: 1.2))
        
         fourDigitCodeViewTwo.anchor(top: view.topAnchor, bottom: nil, leading: fourDigitCodeViewOne.trailingAnchor, trailing: nil, padding: .init(top: 202, left: 20, bottom: 0, right: 0), size:.init(width: 40, height: 1.2))
        
        fourDigitCodeViewThree.anchor(top: view.topAnchor, bottom: nil, leading: fourDigitCodeViewTwo.trailingAnchor, trailing: nil, padding: .init(top: 202, left: 20, bottom: 0, right: 0), size:.init(width: 40, height: 1.2))
        
         fourDigitCodeViewFour.anchor(top: view.topAnchor, bottom: nil, leading: fourDigitCodeViewThree
            .trailingAnchor, trailing: nil, padding: .init(top: 202, left: 20, bottom: 0, right: 0), size:.init(width: 40, height: 1.2))
        
    
        resendCodeButton.anchor(top: nextButton.bottomAnchor, bottom: nil, leading: view.leadingAnchor, trailing: view.trailingAnchor, padding: .init(top: 15, left: 16, bottom: 0, right: 16))
       
        
       
     
    }
    
    private func customNavigationBar() {
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = .clear
    }
    
}
