//
//  AgreementVC.swift
//  riderapp
//
//  Created by Gregory Jones on 8/6/19.
//  Copyright © 2019 Gregory Jones. All rights reserved.
//

import UIKit
import SafariServices

class AgreementViewController: UIViewController {
    
    let termsURL = "https://www.lyft.com/terms"
    let policyURL =  "https://urydeapp.wixsite.com/website/privacy-policy"
    var string = "Terms of Service and Policy Privacy?"
   
    // MARK: - Overriden function
    override func viewDidLoad() {
        super.viewDidLoad()
     [titleText,agreementImageView,yesButton].forEach { view.addSubview($0) }
       customizeTextViewLink()
       setupLayout()
       configureUI()
        navigationItem.largeTitleDisplayMode = .never
     
    }
    override func viewWillAppear(_ animated: Bool) {
     //  self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
   override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    // Hide the navigation bar on the this view controller
     self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
   
    private let titleText: UITextView = {
        let textView = UITextView()
        let attributedText = NSMutableAttributedString(string: "Do you agree to Fleet's", attributes: [NSAttributedString.Key.font:UIFont(name: Fonts.gilroySemiBold, size: 18) as Any, NSAttributedString.Key.foregroundColor:UIColor.black])
        attributedText.append(NSAttributedString(string: "\nTerms of Service and Policy Privacy?", attributes: [NSAttributedString.Key.font:UIFont(name: Fonts.gilroySemiBold, size: 18) as Any, NSAttributedString.Key.foregroundColor: UIColor.black]))
            textView.attributedText = attributedText
            textView.dataDetectorTypes = UIDataDetectorTypes.link
            textView.isSelectable = true
            textView.textAlignment = .left
            textView.isEditable = false
        
        let linkAttributes: [NSAttributedString.Key : Any] = [
            NSAttributedString.Key.foregroundColor: Colors.fleetGreen,
            NSAttributedString.Key.underlineColor: Colors.fleetGreen,
        ]
        textView.linkTextAttributes = linkAttributes
        
        return textView
    }()
    
      private lazy var subTitleText: UITextView = {
         let textView = UITextView()
        textView.tintColor = UIColor.black
        textView.textAlignment = .left
        textView.isEditable = false
        textView.backgroundColor = .none
        textView.isScrollEnabled = false
        textView.isSelectable = true
        textView.delegate = self
        textView.font = UIFont(name: Fonts.gilroyMedium, size: 14)
        textView.dataDetectorTypes = UIDataDetectorTypes.link
        textView.text = "Terms of Service and Policy Privacy?"
        let linkAttributes: [NSAttributedString.Key : Any] = [
            NSAttributedString.Key.foregroundColor: Colors.fleetGreen,
            NSAttributedString.Key.underlineColor: Colors.fleetGreen,
         ]
        textView.linkTextAttributes = linkAttributes
        
        return textView
    }()
    
  /*  private func customizeTextViewLink() {
        let font = subTitleText.font
        let textAlignment = subTitleText.textAlignment
        let attributedText = subTitleText.attributedText.replace(placeholder: "Terms of Service", with: "Terms of Service", url: termsURL)
           .replace(placeholder: "Policy Privacy", with: "Policy Privacy", url: policyURL)
        
        subTitleText.attributedText = attributedText
        subTitleText.font = font
        subTitleText.textAlignment = textAlignment
        subTitleText.delegate = self
        subTitleText.dataDetectorTypes = UIDataDetectorTypes.link
    } */
    
    private func customizeTextViewLink() {
        let font = titleText.font
        let textAlignment = titleText.textAlignment
        let attributedText = titleText.attributedText.replace(placeholder: "Terms of Service", with: "Terms of Service", url: termsURL)
            .replace(placeholder: "Policy Privacy", with: "Policy Privacy", url: policyURL)
        
       titleText.attributedText = attributedText
       titleText.font = font
        titleText.textAlignment = textAlignment
        titleText.delegate = self
        titleText.dataDetectorTypes = UIDataDetectorTypes.link
    }
   
  

private let agreementImageView: UIImageView = {
        let imageView = UIImageView(image:#imageLiteral(resourceName: "terms"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
   
private let yesButton: UIButton = {
        let button = greenButton(type: .system)
        button.setTitle("YES", for: .normal)
        button.titleLabel?.font = UIFont(name: Fonts.gilroySemiBold, size: 20)
        button.addTarget(self, action: #selector(handleNextPage), for: .touchUpInside)
        return button
    }()
    
   private func setupLayout() {
        agreementImageView.contentMode = .scaleAspectFit
        agreementImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        agreementImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        agreementImageView.widthAnchor.constraint(equalToConstant:300).isActive = true
        agreementImageView.heightAnchor.constraint(equalToConstant:300).isActive = true
        titleText.anchor(top: view.topAnchor, bottom: view.bottomAnchor, leading: view.leadingAnchor, trailing: view.trailingAnchor, padding: .init(top: 70 , left: 32, bottom: 0, right: 32))
 //   subTitleText.anchor(top: view.topAnchor, bottom: view.bottomAnchor, leading: view.leadingAnchor, trailing: view.trailingAnchor,  padding: .init(top: 120, left: 32, bottom: 0, right: 32))
        yesButton.anchor(top: nil, bottom: view.safeAreaLayoutGuide.bottomAnchor, leading: view.leadingAnchor, trailing: view.trailingAnchor, padding: .init(top:0, left: 60, bottom: 60, right: 80), size: .init(width: 0, height: 50))
    }
    
    func configureUI() {
         view.backgroundColor = .white
         self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
         self.navigationController?.navigationBar.shadowImage = UIImage()
         navigationController?.navigationBar.tintColor = .black
         navigationController?.navigationBar.isTranslucent = true
         navigationController?.navigationBar.backgroundColor = .clear
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
            return false
         
            
        } else if(URL.absoluteString == policyURL) {
            let nextViewController = PrivacyViewController()
            self.navigationController?.pushViewController(nextViewController, animated: false)
            print("test")
            return false
    }
        return true
    }

    
    
}


