//
//  EditHomeVC.swift
//  riderapp
//
//  Created by Gregory Jones on 9/20/19.
//  Copyright © 2019 Gregory Jones. All rights reserved.
//


import UIKit

class EditHomeViewController: UIViewController {
    //MARK: - Override functions
           
           override func viewDidLoad() {
               super.viewDidLoad()
               [dormView, dormIcon, dormInput].forEach { view.addSubview($0) }
            dormInput.delegate = self
               configureNavigationBar()
               configureUI()
               ConstraintsLayout()
        
                    
          
           }
           override func viewWillAppear(_ animated: Bool) {
                 super.viewWillAppear(animated)
                dormInput.becomeFirstResponder()
                 
           }
           
           //MARK - Private functions

           private func configureUI() {
               view.backgroundColor = .white
            
           }
        
           private func configureNavigationBar() {
               navigationItem.title = "Add Dorm Hall"
               navigationController?.navigationBar.isTranslucent = false
              let textAttributes = [NSAttributedString.Key.font: UIFont(name: Fonts.gilroySemiBold, size: 18) as Any, NSAttributedString.Key.foregroundColor:UIColor.black]
              navigationController?.navigationBar.titleTextAttributes = textAttributes
              navigationItem.rightBarButtonItem = UIBarButtonItem.barButton(self, action: #selector(handlePreviousPage), imageName: "trash")
           // Custom Back Button
                  let backButton = UIButton(type: .system)
                  backButton.setBackgroundImage(#imageLiteral(resourceName: "backarrow"), for:.normal)
                  backButton.addTarget(self, action: #selector(handlePreviousPage), for: .touchUpInside)
                  backButton.width(constant: 20)
                  backButton.height(constant: 20)
                  self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backButton)
           }
        private let dormView: UIView = {
                   let view = UIView()
                       view.layer.shadowColor = UIColor.black.cgColor;
                                            view.layer.masksToBounds = false;
                                            view.layer.cornerRadius  =  10;
                                            view.layer.borderWidth   = 2.0;
                                            view.layer.borderColor = UIColor.darkGray.cgColor
                                            view.backgroundColor     =  .white
                                            view.translatesAutoresizingMaskIntoConstraints = false
                return view
               }()
        
        
              private let dormInput: UITextField = {
                  let textField = searchLocation()
                  textField.attributedPlaceholder = NSAttributedString(string: "Enter Address", attributes: [NSAttributedString.Key.font: UIFont(name: Fonts.gilroyMedium, size: 14) as Any, NSAttributedString.Key.foregroundColor: UIColor.lightGray])
                      textField.textColor = UIColor.black
                      textField.textAlignment = .left
                  
                      return textField
              }()
            
               
               private let dormIcon: UIImageView = {
                   let iv = UIImageView(image: #imageLiteral(resourceName: "setting_home"))
                   iv.contentMode = .scaleAspectFit
                   iv.width(constant: 18)
                   iv.height(constant: 18)
                   iv.translatesAutoresizingMaskIntoConstraints = false
                   return iv
                   
               }()
           
           private func ConstraintsLayout() {
                dormView.anchor(top: view.topAnchor, bottom: nil, leading: view.leadingAnchor, trailing: view.trailingAnchor, padding: .init(top: 20, left: 16, bottom: 0, right: 16), size: .init(width: 0, height: 55))
           
            dormIcon.anchor(top: dormView.topAnchor, bottom: nil, leading: dormView.leadingAnchor, trailing: nil, padding: .init(top: 18, left: 13, bottom: 0, right: 0))
               
            dormInput.anchor(top:dormView.topAnchor, bottom: dormView.bottomAnchor, leading: dormIcon.trailingAnchor, trailing: dormView.trailingAnchor, padding: .init(top: 0, left: 8, bottom: 0, right: 0))
               
            }
        
       
           // MARK: - Selectors
           @objc private func handlePreviousPage() {
               self.navigationController?.popViewController(animated: false)
               
           }
           
           // MARK: - Selectors
              @objc private func saveToggle() {
               
              }
    }

extension EditHomeViewController: UITextFieldDelegate {
    // Stop Editing on Return Key Tap
        override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
            self.view.endEditing(true)
            
        }
      private func textFieldShouldReturn(textField: UITextField!) -> Bool {
          textField.resignFirstResponder()
          return true
      }
}

