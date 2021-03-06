//
//  EditEmailVC.swift
//  riderapp
//
//  Created by Gregory Jones on 9/20/19.
//  Copyright © 2019 Gregory Jones. All rights reserved.
//

import UIKit

class EditEmailViewController: UIViewController {
    
    
    //MARK: - Override functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        [emailView, emailText, emailInput].forEach { view.addSubview($0) }
        emailInput.delegate = self
        configureNavigationBar()
        configureUI()
        ConstraintsLayout()
             
   
    }
    override func viewWillAppear(_ animated: Bool) {
          super.viewWillAppear(animated)
          emailInput.becomeFirstResponder()
          hideTabBarController()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
    }
    
    
    func hideTabBarController() {
              tabBarController?.tabBar.isHidden = true
              edgesForExtendedLayout = UIRectEdge.bottom
              extendedLayoutIncludesOpaqueBars = true
          }
       
       
    
    //MARK - Private functions
    
    
    private func configureUI() {
        view.backgroundColor = .white
    }
    private func configureNavigationBar() {
        navigationItem.title = "Email Address"
        navigationController?.navigationBar.isTranslucent = false
        let saveButton = UIBarButtonItem(title: "Save", style: .done, target: self, action: nil)
        saveButton.tintColor = .blue
        self.navigationItem.rightBarButtonItem = saveButton
       let textAttributes = [NSAttributedString.Key.font: UIFont(name: Fonts.gilroySemiBold, size: 18) as Any, NSAttributedString.Key.foregroundColor:UIColor.black]
       navigationController?.navigationBar.titleTextAttributes = textAttributes
        // Custom back button
        let backButton = UIButton(type: .system)
            backButton.setBackgroundImage(#imageLiteral(resourceName: "backarrow"), for:.normal)
            backButton.addTarget(self, action: #selector(handlePreviousPage), for: .touchUpInside)
            backButton.width(constant: 20)
            backButton.height(constant: 20)
            self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backButton)
    
        
        
        // Save Button
       

    }
    
    
    
     private let emailView: UIView = {
               let view = UIView()
                   view.layer.shadowColor = UIColor.black.cgColor;
                     view.layer.masksToBounds = false;
                       view.layer.cornerRadius  =  10;
                       view.layer.borderWidth   = 2.0;
               view.layer.borderColor = UIColor.black.cgColor
                       view.backgroundColor     =  .white
                    view.translatesAutoresizingMaskIntoConstraints = false

                 return view
       }()
    private let emailText: UILabel = {
        let emailLabel = UILabel()
        let attributedText = NSMutableAttributedString(string: "Email", attributes: [NSAttributedString.Key.font:UIFont(name: Fonts.gilroyMedium, size: 13) as Any, NSAttributedString.Key.foregroundColor:UIColor.darkGray])
           emailLabel.attributedText = attributedText
            emailLabel.translatesAutoresizingMaskIntoConstraints = true
           emailLabel.textAlignment = .left
          return emailLabel
    }()
    
    private let emailInput: UITextField = {
           let textField = userInputField()
               textField.textColor = UIColor.black
               textField.textAlignment = .left
            return textField
    
    }()
    
    private func ConstraintsLayout() {
         emailView.anchor(top: view.topAnchor, bottom: nil, leading: view.leadingAnchor, trailing: view.trailingAnchor, padding: .init(top: 20, left: 16, bottom: 0, right: 16), size: .init(width: 0, height: 60))
        
        emailText.anchor(top: emailView.topAnchor, bottom: emailView.bottomAnchor, leading: emailView.leadingAnchor, trailing: emailView.trailingAnchor, padding: .init(top: 0, left: 16, bottom: 22, right: 0))
        
         emailInput.anchor(top: emailView.topAnchor, bottom: nil, leading: emailView.leadingAnchor, trailing: emailView.trailingAnchor, padding: .init(top: 30, left: 16, bottom: 0, right: 0))
        
       
       
    }
    
    // MARK: - Selectors
    @objc private func handlePreviousPage() {
        self.navigationController?.popViewController(animated: false)
        
    }
    
    // MARK: - Selectors
       @objc private func saveToggle() {
        
       }
}

extension EditEmailViewController: UITextFieldDelegate {
    // Stop Editing on Return Key Tap
        override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
            self.view.endEditing(true)
            
        }
      private func textFieldShouldReturn(textField: UITextField!) -> Bool {
          textField.resignFirstResponder()
          return true
      }
}
