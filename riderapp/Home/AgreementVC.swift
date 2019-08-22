//
//  AgreementVC.swift
//  riderapp
//
//  Created by Gregory Jones on 8/6/19.
//  Copyright © 2019 Gregory Jones. All rights reserved.
//

import UIKit

class AgreementViewController: UIViewController {
    
    let termsURL = "https://urydeapp.wixsite.com/website/terms-of-use"
    let policyURL =  "https://urydeapp.wixsite.com/website/privacy-policy"
     var string = "Terms of Service and Policy Privacy?"
    // MARK: - Overriden function
    
    override func viewDidLoad() {
        super.viewDidLoad()
     [titleText, subTitleText,agreementImageView,yesButton].forEach { view.addSubview($0) }
       setupLayout()
       configureUI()
     // termsHyperLink()
      // privacyHyperLink()
        
    }
    
   override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
       self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }
   
    private let titleText: UITextView = {
        let textView = UITextView()
        let attributedText = NSMutableAttributedString(string: "Do you agree to Ryde's", attributes: [NSAttributedString.Key.font:UIFont(name: Fonts.montserratSemiBold, size: 22) as Any, NSAttributedString.Key.foregroundColor:UIColor.black])
            textView.attributedText = attributedText
            textView.textAlignment = .left
            textView.isEditable = false
        return textView
    }()
    
      private lazy var subTitleText: UITextView = {
      //  let termsURL = "https://urydeapp.wixsite.com/website/terms-of-use"
      //  let policyURL =  "https://urydeapp.wixsite.com/website/privacy-policy"
   
        let textView = UITextView()
       
       
        textView.tintColor = UIColor.black
        textView.textAlignment = .left
        textView.isEditable = false
        textView.backgroundColor = .none
        textView.isScrollEnabled = false
        textView.isSelectable = true
        textView.delegate = self
        //textView.font = UIFont(name: Fonts.montserratMedium, size: 14)
        textView.dataDetectorTypes = UIDataDetectorTypes.link
        textView.text = "Terms of Service and Policy Privacy?"
        textView.attributedText = textView.attributedText.replace(placeholder: "Terms of Service", with: "Terms of Service", url: termsURL)
            .replace(placeholder: "Policy Privacy", with: "Policy Privacy", url: policyURL)
        
        let linkAttributes: [NSAttributedString.Key : Any] = [
           NSAttributedString.Key.font:UIFont(name: Fonts.montserratMedium, size: 14) as Any,
            NSAttributedString.Key.foregroundColor: Colors.primaryRed,
            NSAttributedString.Key.underlineColor: Colors.primaryRed,
            NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue,
           
            
        ]
        textView.linkTextAttributes = linkAttributes
        
        
        return textView
    }()

private let agreementImageView: UIImageView = {
        let imageView = UIImageView(image:#imageLiteral(resourceName: "agreementphoto"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
   
private let yesButton: UIButton = {
        let button = redButton(type: .system)
        button.setTitle("YES", for: .normal)
        button.titleLabel?.font = UIFont(name: Fonts.montserratSemiBold, size: 20)
        button.addTarget(self, action: #selector(handleNextPage), for: .touchUpInside)
        return button
    }()
    
   private func setupLayout() {
        agreementImageView.contentMode = .scaleAspectFit
        agreementImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        agreementImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -60).isActive = true
        agreementImageView.widthAnchor.constraint(equalToConstant:350).isActive = true
        agreementImageView.heightAnchor.constraint(equalToConstant:350).isActive = true
        titleText.anchor(top: view.topAnchor, bottom: view.bottomAnchor, leading: view.leadingAnchor, trailing: view.trailingAnchor, padding: .init(top: 70 , left: 32, bottom: 0, right: 32))
    subTitleText.anchor(top: view.topAnchor, bottom: view.bottomAnchor, leading: view.leadingAnchor, trailing: view.trailingAnchor,  padding: .init(top: 120, left: 32, bottom: 0, right: 32))
        yesButton.anchor(top: nil, bottom: view.safeAreaLayoutGuide.bottomAnchor, leading: view.leadingAnchor, trailing: view.trailingAnchor, padding: .init(top:0, left: 60, bottom: 80, right: 80), size: .init(width: 0, height: 50))
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
        let nextViewController = HomeViewController()
        self.navigationController?.pushViewController(nextViewController, animated: false)
        let generator = UIImpactFeedbackGenerator(style: .heavy) // Add the vibration tap to the button
        generator.impactOccurred()
    }
    @objc private func handlePreviousPage() {
        self.navigationController?.popViewController(animated: false)
        
    }
}

extension AgreementViewController: UITextViewDelegate {
    
 /*   func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool {
     UIApplication.shared.open(URL)
     
     return false
     } */
    
    func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool {
        
        if (URL.absoluteString == termsURL) {
            let nextViewController = TermsViewController()
            self.navigationController?.pushViewController(nextViewController, animated: false)
            print("test")
         
            
        } else if(URL.absoluteString == policyURL) {
            let nextViewController = PrivacyViewController()
            self.navigationController?.pushViewController(nextViewController, animated: false)
            print("test")
            return false
    }
        return true
    }
    /*    if(textView.text.contains("Terms of Service")) {
            let nextViewController = TermsViewController()
            self.navigationController?.pushViewController(nextViewController, animated: false)
            return false
        } else  {
            
        }
        if(textView.text.contains("Policy Privacy")) {
            let nextViewController = PrivacyViewController()
            self.navigationController?.pushViewController(nextViewController, animated: false)
            return true
        }
        return false
    } */
    
    
}


