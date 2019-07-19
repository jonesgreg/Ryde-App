//
//  SignInViewController.swift
//  riderapp
//
//  Created by Gregory Jones on 6/27/19.
//  Copyright © 2019 Gregory Jones. All rights reserved.
//

import UIKit



class SignInViewController: UIViewController {
  
    var countries: Countries?
    var localeCountry: Country?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        [titleText, rideNowButton, phoneNumberView, phoneNumberInput, countryCodeView, countryCodeInput].forEach { view.addSubview($0) }
        
         setUpLayout()
         customNavigationBar()
         loadCountries()
       
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(self.keyboardWillShow(notification:)),
            name: UIResponder.keyboardDidShowNotification, object: nil)
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(self.keyboardWillHide(notification:)),
            name: UIResponder.keyboardDidShowNotification, object: nil)
        
        
    }
    
   override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
       phoneNumberInput.becomeFirstResponder()
        
    }
    
    // MARK: - Private functions
    
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
            //countryFlagInput.text = (localeCountry?.iso2_cc)! + " " + "+" + (localeCountry?.e164_cc)! + ""
            countryCodeInput.text = ("+" + (localeCountry?.e164_cc)!)
            
        }
    }
    
   
    private let titleText: UITextView = {
        let textView = UITextView()
        
        let attributedText = NSMutableAttributedString(string: "What's your number?", attributes: [NSAttributedString.Key.font:UIFont(name: Fonts.montserratSemiBold, size: 22) as Any, NSAttributedString.Key.foregroundColor:UIColor.darkGray])
        
        attributedText.append(NSAttributedString(string: "\n\nWe'll text a code to verify your number.", attributes: [NSAttributedString.Key.font:UIFont(name: Fonts.montserratMedium, size: 14) as Any, NSAttributedString.Key.foregroundColor: UIColor.darkGray]))
        
        textView.attributedText = attributedText
        textView.textAlignment = .center
        textView.isEditable = false
        
        return textView
    }()
    
    
    private let phoneNumberInput: UITextField = {
        let textfield = UITextField()
            textfield.textAlignment = .left
            textfield.borderStyle = .none
            textfield.attributedPlaceholder = NSAttributedString(string: "(310) 123-4567", attributes: [NSAttributedString.Key.font:UIFont(name: Fonts.montserratMedium, size: 16) as Any, NSAttributedString.Key.foregroundColor:UIColor.lightGray])
            textfield.keyboardType = UIKeyboardType.numberPad
        
        return textfield
    }()
    
    
    private let countryCodeInput: UITextField = {
          let textfield = UITextField()
              textfield.textAlignment = .left
              textfield.borderStyle = .none
              textfield.attributedPlaceholder = NSAttributedString(string: "", attributes: [NSAttributedString.Key.font:UIFont(name: Fonts.montserratSemiBold, size: 16) as Any, NSAttributedString.Key.foregroundColor:UIColor.darkGray])
              textfield.isUserInteractionEnabled = false
        
        return textfield
        
    }()
    

   
    private let phoneNumberView: UIView = {
        let phoneView = UIView()
            phoneView.layer.borderWidth = 2.5
            phoneView.layer.borderColor = UIColor.lightGray.cgColor
        
        return phoneView
    }()
    
    private let countryCodeView: UIView = {
        let codeView = UIView()
            codeView.layer.borderWidth = 2.5
            codeView.layer.borderColor = UIColor.lightGray.cgColor
        
        return codeView
    }()
    
    private let countryFlagInput: UITextField = {
            let textfield = UITextField()
                textfield.attributedPlaceholder = NSAttributedString(string: "Flag", attributes: [NSAttributedString.Key.font:UIFont(name: Fonts.montserratSemiBold, size: 16) as Any, NSAttributedString.Key.foregroundColor:UIColor.darkGray])
       
                textfield.isUserInteractionEnabled = false
                textfield.textAlignment = .left
                textfield.borderStyle = .none
        
       return textfield
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
       
    return button
        
    }()
    

    private func setUpLayout() {
        titleText.anchor(top: view.topAnchor, bottom: view.bottomAnchor, leading: view.leadingAnchor, trailing: view.trailingAnchor, padding: .init(top: 80, left: 0, bottom: 0, right: 0))
        
        rideNowButton.anchor(top: nil, bottom: view.safeAreaLayoutGuide.bottomAnchor, leading: view.leadingAnchor, trailing: view.trailingAnchor, padding: .init(top: 0, left: 16, bottom: 30, right: 16))
        
       phoneNumberView.anchor(top: view.topAnchor, bottom: nil, leading: nil, trailing: view.trailingAnchor, padding: .init(top: 202, left:0, bottom: 0, right: 45), size: .init(width: 230, height: 0.5))
        
       countryCodeView.anchor(top: view.topAnchor, bottom: nil, leading: nil, trailing:phoneNumberView.leadingAnchor, padding: .init(top: 202, left: 0, bottom: 0, right: 25), size:.init(width: 50, height: 0.5))
        
       phoneNumberInput.anchor(top: view.topAnchor, bottom: nil, leading:phoneNumberView.leadingAnchor, trailing: view.trailingAnchor, padding: .init(top: 180, left:28, bottom: 0, right: 0))
        
       countryCodeInput.anchor(top: view.topAnchor, bottom: nil, leading: phoneNumberView.leadingAnchor, trailing: nil, padding: .init(top: 180, left: 0, bottom: 0, right: 0))
        
      // countryFlagInput.anchor(top: view.topAnchor, bottom: nil, leading: view.leadingAnchor, trailing: view.trailingAnchor, padding: .init(top: 180, left: 105, bottom: 0, right: 20))
    }

 
   private func customNavigationBar() {
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = .clear
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0 {
                self.view.frame.origin.y -= keyboardSize.height
            }
        }
    }
    @objc func keyboardWillHide(notification: NSNotification) {
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
    }
}

extension SignInViewController: UITextFieldDelegate {
    
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




