//
//  SignInViewController.swift
//  riderapp
//
//  Created by Gregory Jones on 6/27/19.
//  Copyright © 2019 Gregory Jones. All rights reserved.
//

import UIKit


class PhoneEntryViewController: UIViewController {
  
    var countries: Countries?
    var localeCountry: Country?
   
    // MARK: - Overriden function
    override func viewDidLoad() {
        super.viewDidLoad()
        [titleText,phoneNumberView,nextButton, phoneNumberInput, countryCodeView, countryCodeInput, countryFlagInput, showCountryCode].forEach { view.addSubview($0) }
        
         setUpLayout()
         customNavigationBar()
         loadCountries()
         phoneNumberInput.delegate = self
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
            countryFlagInput.text =  (localeCountry?.flag)!
            countryCodeInput.text = ("+" + (localeCountry?.e164_cc)!)
        }
    }
    
   private let titleText: UITextView = {
        let textView = UITextView()
        let attributedText = NSMutableAttributedString(string: "What's your number?", attributes: [NSAttributedString.Key.font:UIFont(name: Fonts.montserratSemiBold, size: 22) as Any, NSAttributedString.Key.foregroundColor:UIColor.black])
            attributedText.append(NSAttributedString(string: "\n\nWe'll text a code to verify your number.", attributes: [NSAttributedString.Key.font:UIFont(name: Fonts.montserratMedium, size: 14) as Any, NSAttributedString.Key.foregroundColor: UIColor.darkGray]))
            textView.attributedText = attributedText
            textView.textAlignment = .center
            textView.isEditable = false
            return textView
    }()
    
    private let phoneNumberView: UIView = {
        let phoneView = UIView()
            phoneView.layer.borderWidth = 1
            phoneView.layer.borderColor = Colors.lightGreyColor.cgColor
            return phoneView
    }()
    
    private let phoneNumberInput: UITextField = {
        let textField = UITextField()
            textField.textAlignment = .left
            textField.borderStyle = .none
            textField.attributedPlaceholder = NSAttributedString(string: "(310) 123-4567", attributes: [NSAttributedString.Key.font:UIFont(name: Fonts.montserratMedium, size: 16) as Any, NSAttributedString.Key.foregroundColor:UIColor.lightGray])
            textField.keyboardType = UIKeyboardType.numberPad
            textField.tintColor = UIColor.init(red: 144/255, green: 19/255, blue: 254/255, alpha: 1)
            textField.returnKeyType = UIReturnKeyType.done
            textField.clearButtonMode = UITextField.ViewMode.whileEditing
            return textField
        
    }()
    
    
    private let countryCodeView: UIView = {
        let codeView = UIView()
            codeView.layer.borderWidth = 1
            codeView.layer.borderColor = Colors.lightGreyColor.cgColor
            return codeView
    }()
    
    
    private let countryCodeInput: UITextField = {
          let textField = UITextField()
              textField.textAlignment = .left
              textField.borderStyle = .none
              textField.isUserInteractionEnabled = false
              return textField
    }()
    
    private let countryFlagInput: UITextField = {
            let textField = UITextField()
                textField.isUserInteractionEnabled = false
                textField.textAlignment = .left
                textField.borderStyle = .none
                 return textField
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
        let nextViewController = self.storyboard?.instantiateViewController(withIdentifier: "Verify")
        self.show(nextViewController!, sender: nil)
        
    }
    
  
    private let showCountryCode: UIButton = {
        let button = UIButton(type: .system)
        button.addTarget(self, action: #selector(handleCountryPage), for: .touchUpInside)
        return button
    }()
    
   @objc private func handleCountryPage() {
        if let countries = countries {
            let listScene = CountryCodeListController.init(countries: countries)
            listScene.delegate = self
            navigationController?.pushViewController(listScene, animated: true)
            
        } else {
            debugPrint("Countries not yet loaded or failed")
        }
        
    }
    
      private func setUpLayout() {
        titleText.anchor(top: view.topAnchor, bottom: view.bottomAnchor, leading: view.leadingAnchor, trailing: view.trailingAnchor, padding: .init(top: 80, left: 0, bottom: 0, right: 0))
        nextButton.anchor(top: view.topAnchor, bottom: nil, leading: view.leadingAnchor, trailing: view.trailingAnchor, padding: .init(top: 230, left: 16, bottom: 0, right: 16), size: .init(width:0, height: 50))
        showCountryCode.anchor(top: view.topAnchor, bottom:nil, leading:countryCodeView.leadingAnchor, trailing: countryCodeView.trailingAnchor, padding: .init(top: 178, left: 10, bottom: 0, right: 3))
        phoneNumberView.anchor(top: view.topAnchor, bottom: nil, leading: nil, trailing: view.trailingAnchor, padding: .init(top: 202, left:0, bottom: 0, right: 45), size: .init(width: 230, height: 1.2))
        countryCodeView.anchor(top: view.topAnchor, bottom: nil, leading: nil, trailing:phoneNumberView.leadingAnchor, padding: .init(top: 202, left: 0, bottom: 0, right: 25), size:.init(width: 50, height: 1.2))
        phoneNumberInput.anchor(top: view.topAnchor, bottom: nil, leading:countryCodeInput.trailingAnchor, trailing: phoneNumberView.trailingAnchor, padding: .init(top: 180, left: 0, bottom: 0, right: 55))
        countryCodeInput.anchor(top: view.topAnchor, bottom: nil, leading: phoneNumberView.leadingAnchor, trailing: countryFlagInput.trailingAnchor, padding: .init(top: 180, left: 0, bottom: 0, right: 0))
        countryFlagInput.anchor(top: view.topAnchor, bottom: nil, leading: countryCodeView.leadingAnchor, trailing: countryCodeInput.trailingAnchor, padding: .init(top: 180, left: 15, bottom: 0, right: 0))
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
    
    private func customNavigationBar() {
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = .clear
        self.navigationController?.navigationBar.tintColor = UIColor.black
    }
    
   
}


extension PhoneEntryViewController: UITextFieldDelegate {
    
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
        super.touchesBegan(touches, with: event)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        phoneNumberInput.resignFirstResponder()
        return true
    }
    
}

extension PhoneEntryViewController: countryPickerProtocol {
    
    func didPickCountry(model: Country) {
        localeCountry = model
        countryFlagInput.text = model.flag
        countryCodeInput.text = "+" + model.e164_cc + "" + ""
    }
}






