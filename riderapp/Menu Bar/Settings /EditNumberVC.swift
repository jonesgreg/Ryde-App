//
//  EditNumberVC.swift
//  riderapp
//
//  Created by Gregory Jones on 9/20/19.
//  Copyright © 2019 Gregory Jones. All rights reserved.
//

import UIKit

class EditNumberViewController: UIViewController {
    
    //MARK: - Properties
    
     var countries: Countries?
     var localeCountry: Country?
     var buttonConstraint: NSLayoutConstraint?
    
   // MARK:  Override functions
       
       override func viewDidLoad() {
           super.viewDidLoad()
         [phoneText,phoneView,countryFlagInput,dropDownPicker,countryCodeInput,showCountryCode,phoneInput, separatorLine, nextButton, nextButtonImage].forEach { view.addSubview($0) }
      
           phoneInput.delegate = self
           configureNavigationBar()
           configureUI()
           ConstraintsLayout()
           loadCountries()
                
      
       }
       override func viewWillAppear(_ animated: Bool) {
             super.viewWillAppear(animated)
            phoneInput.becomeFirstResponder()
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
                  NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
              hideTabBarController()
       }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
         NotificationCenter.default.removeObserver(self)
        
    }
    func hideTabBarController() {
              tabBarController?.tabBar.isHidden = true
              edgesForExtendedLayout = UIRectEdge.bottom
              extendedLayoutIncludesOpaqueBars = true
          }
       
       func showTabBarController() {
                 tabBarController?.tabBar.isHidden = false
                 edgesForExtendedLayout = UIRectEdge.bottom
                 extendedLayoutIncludesOpaqueBars = false
             }
     
      
          
       //MARK - Private functions
       
       
       private func configureUI() {
           view.backgroundColor = .white
       }
      
    private func configureNavigationBar() {
           navigationItem.title = "Phone Number"
           navigationController?.navigationBar.isTranslucent = false
        let textAttributes = [NSAttributedString.Key.font: UIFont(name: Fonts.gilroySemiBold, size: 18) as Any, NSAttributedString.Key.foregroundColor:UIColor.black]
          navigationController?.navigationBar.titleTextAttributes = textAttributes
        // Custom Back Button
                     let backButton = UIButton(type: .system)
                     backButton.setBackgroundImage(#imageLiteral(resourceName: "backarrow"), for:.normal)
                     backButton.addTarget(self, action: #selector(handlePreviousPage), for: .touchUpInside)
                     backButton.width(constant: 20)
                     backButton.height(constant: 20)
                     self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backButton)
         
    }
       
       private func loadCountries() {
           DispatchQueue.global(qos: .userInitiated).async {
               self.countries = JSONReader.countries()
               DispatchQueue.main.async {
                   self.addLocaleCountryCode()
               }
           }
       }
       
       private func addLocaleCountryCode() {
           if let countryCode = (Locale.current as NSLocale).object(forKey: .countryCode) as? String {
               localeCountry = countries?.countries.filter {($0.iso2_cc == countryCode)}.first
              countryFlagInput.text = (localeCountry?.flag)!
               countryCodeInput.text = ("+" + (localeCountry?.e164_cc)!)
          //  countryCodeInput.text = (localeCountry?.iso2_cc)! + " " + "(+" + (localeCountry?.e164_cc)! + ")"
            //countryCodeInput.text = (localeCountry?.flag)! + "" + "(+" + (localeCountry?.e164_cc)! + ")"
           }
       }
       
        private let phoneView: UIView = {
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

    private let separatorLine: UIView = {
              let view = UIView()
             // view.backgroundColor = UIColor.darkGray
              view.layer.borderWidth   = 2.0;
              view.layer.borderColor = UIColor.darkGray.cgColor
              view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    
       private let phoneText: UITextView = {
           let textView = UITextView()
           let attributedText = NSMutableAttributedString(string: "You can update your number and we'll send a verification code to this number.", attributes: [NSAttributedString.Key.font:UIFont(name: Fonts.gilroyMedium, size: 16) as Any, NSAttributedString.Key.foregroundColor:UIColor.black])
               textView.attributedText = attributedText
               textView.textAlignment = .center
               textView.isEditable = false
        
               return textView
       }()
    
      private let dropDownPicker: UIImageView = {
                 let imageView = UIImageView(image:#imageLiteral(resourceName: "dropdown"))
                     imageView.translatesAutoresizingMaskIntoConstraints = false
                    
        
                     return imageView
         }()
       
       private let phoneInput: UITextField = {
              let textfield = phoneNumberTextField()
                     textfield.attributedPlaceholder = NSAttributedString(string: "456-7890", attributes:[NSAttributedString.Key.font:UIFont(name: Fonts.gilroyMedium, size: 18) as Any, NSAttributedString.Key.foregroundColor:UIColor.lightGray])
                     textfield.textColor = UIColor.black
                     return textfield
        
       }()
    
     private let countryFlagInput: UITextField = {
           let textfield = countryField()
           return  textfield
       }()
       
       private let countryCodeInput: UITextField = {
           let textfield = countryField()
               textfield.attributedPlaceholder = NSAttributedString(string: "+1", attributes:[NSAttributedString.Key.font:UIFont(name: Fonts.gilroyMedium, size: 18) as Any, NSAttributedString.Key.foregroundColor:UIColor.black])
               textfield.textColor = UIColor.black
               
           return textfield
          
       }()
       
       private let showCountryCode: UIButton = {
           let button = UIButton(type: .system)
               button.addTarget(self, action: #selector(handleCountryPage), for: .touchUpInside)
            
               return button
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
       
       private func ConstraintsLayout() {
         phoneView.anchor(top: view.topAnchor, bottom: nil, leading: view.leadingAnchor, trailing: view.trailingAnchor, padding: .init(top: 100, left: 16, bottom: 0, right: 16), size: .init(width: 0, height: 60))
        
     phoneText.anchor(top: view.topAnchor, bottom: view.bottomAnchor, leading: view.leadingAnchor, trailing: view.trailingAnchor, padding: .init(top: 20, left: 16, bottom: 0, right: 16))
       
        //Display Country Code, Change Country Code and Country Flag
       showCountryCode.anchor(top: phoneView.topAnchor, bottom: phoneView.bottomAnchor, leading: phoneView.leadingAnchor, trailing: nil, padding: .init(top: 2, left: 12, bottom: 0, right: 0))
       countryCodeInput.anchor(top: phoneView.topAnchor, bottom: phoneView.bottomAnchor, leading: separatorLine.leadingAnchor, trailing: phoneView.trailingAnchor, padding: .init(top: 2, left: 10, bottom: 0, right: 16))
       countryFlagInput.anchor(top: phoneView.topAnchor, bottom: phoneView.bottomAnchor, leading: phoneView.leadingAnchor, trailing: phoneView.trailingAnchor, padding: .init(top: 2, left: 16, bottom: 0, right: 0))
     
        dropDownPicker.anchor(top: phoneView.topAnchor, bottom: nil, leading: phoneView.leadingAnchor, trailing: nil, padding: .init(top: 24, left: 40, bottom: 0, right: 0), size: .init(width: 12, height: 12))
        
       
        separatorLine.leadingAnchor.constraint(equalTo: phoneView.leadingAnchor, constant: 60).isActive = true
        separatorLine.topAnchor.constraint(equalTo: phoneView.topAnchor, constant: 0).isActive = true
        separatorLine.widthAnchor.constraint(equalToConstant: 2.0).isActive = true
        separatorLine.heightAnchor.constraint(equalTo: phoneView.heightAnchor).isActive = true
       
    phoneInput.anchor(top: phoneView.topAnchor, bottom: phoneView.bottomAnchor, leading: phoneView.leadingAnchor, trailing: phoneView.trailingAnchor, padding: .init(top: 2, left: 110, bottom: 0, right: 16))
          
        nextButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10).isActive = true
               buttonConstraint = nextButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10)
               buttonConstraint?.isActive = true
               
               nextButtonImage.centerXAnchor.constraint(equalTo: nextButton.centerXAnchor).isActive = true
               nextButtonImage.centerYAnchor.constraint(equalTo: nextButton.centerYAnchor).isActive = true
          
          
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
       
       // MARK: - Selectors
    
     @objc private func handleNextPage() {
          let nextViewController = VerifyNumberViewController()
          self.navigationController?.pushViewController(nextViewController, animated: false)
          let generator = UIImpactFeedbackGenerator(style: .heavy) // Add the vibration tap to the button
          generator.impactOccurred()
      }
      
       @objc private func handlePreviousPage() {
           self.navigationController?.popViewController(animated: false)
           
       }
       
     @objc private func handleCountryPage() {
          if let countries = countries {
               let listScene = CountryCodeListController.init(countries: countries)
               listScene.delegate = self
               navigationController?.pushViewController(listScene, animated: false)
           
           } else {
               debugPrint("Countries not yet loaded or failed")
           }
           
       }
      func format(phoneNumber: String, shouldRemoveLastDigit: Bool = false) -> String {
           guard !phoneNumber.isEmpty else { return "" }
           guard let regex = try? NSRegularExpression(pattern: "[\\s-\\(\\)]", options: .caseInsensitive) else { return "" }
           let r = NSString(string: phoneNumber).range(of: phoneNumber)
           var number = regex.stringByReplacingMatches(in: phoneNumber, options: .init(rawValue: 0), range: r, withTemplate: "")
           
           if number.count > 10 {
               let tenthDigitIndex = number.index(number.startIndex, offsetBy: 10)
               number = String(number[number.startIndex..<tenthDigitIndex])
           }
           
           if shouldRemoveLastDigit {
               let end = number.index(number.startIndex, offsetBy: number.count-1)
               number = String(number[number.startIndex..<end])
           }
           
           if number.count < 7 {
               let end = number.index(number.startIndex, offsetBy: number.count)
               let range = number.startIndex..<end
               number = number.replacingOccurrences(of: "(\\d{3})(\\d+)", with: "($1) $2", options: .regularExpression, range: range)
               
           } else {
               let end = number.index(number.startIndex, offsetBy: number.count)
               let range = number.startIndex..<end
               number = number.replacingOccurrences(of: "(\\d{3})(\\d{3})(\\d+)", with: "($1) $2-$3", options: .regularExpression, range: range)
           }
           return number
       }
}
extension EditNumberViewController: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        var fullString = textField.text ?? ""
        fullString.append(string)
        if range.length == 1 {
            textField.text = format(phoneNumber: fullString, shouldRemoveLastDigit: true)
        } else {
            textField.text = format(phoneNumber: fullString)
        }
        return false
    }
    
    
    // Stop Editing on Return Key Tap
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        phoneInput.resignFirstResponder()
        return true
    }
    
}
extension EditNumberViewController: countryPickerProtocol {
    
    func didPickCountry(model: Country) {
        localeCountry = model
        countryCodeInput.text = "+" + model.e164_cc + "" + ""
        countryFlagInput.text = model.flag
        //countryCodeInput.text = "+" + model.e164_cc + "" + ""
      //  countryCodeInput.text = model.iso2_cc + " " + "(+" + model.e164_cc + ")"
    }
}

