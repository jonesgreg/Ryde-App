//
//  SignInViewController.swift
//  riderapp
//
//  Created by Gregory Jones on 6/27/19.
//  Copyright © 2019 Gregory Jones. All rights reserved.
//

import UIKit
import Lottie


class PhoneEntryViewController: UIViewController {
 
    var countries: Countries?
    var localeCountry: Country?
    var buttonConstraint: NSLayoutConstraint?
    var isKeyboardAppear = false
  
   // MARK: - Overriden function
    override func viewDidLoad() {
        super.viewDidLoad()
       
        [backgroundView, logoImageView,phoneText, dropDownPicker, countryCodeInput,updateAcountButton,showCountryCode,phoneNumberInput, forwardButton ].forEach { view.addSubview($0) }
        phoneNumberInput.delegate = self
        configureUI()
        constraintsLayout()
        loadCountries()
       
        
        
    }
    
  
  override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // Hide the navigation bar on the this view controller
       self.navigationController?.setNavigationBarHidden(true, animated: animated)
        phoneText.becomeFirstResponder()
    NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
  NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
       NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: self.view.window)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: self.view.window)
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
             countryCodeInput.text = ("+" + (localeCountry?.e164_cc)!)
        }
    }
   
    // MARK: - Private functions
    private let phoneText: UITextView = {
        let textView = UITextView()
        let attributedText = NSMutableAttributedString(string: "Enter your phone number (required)", attributes: [NSAttributedString.Key.font:UIFont(name: Fonts.gilroyMedium, size: 22) as Any, NSAttributedString.Key.foregroundColor:UIColor.black])
            textView.attributedText = attributedText
            textView.textAlignment = .left
            textView.isEditable = false
            textView.backgroundColor = .none
            return textView
    }()
    
    private let updateAcountButton: UIButton = {
            let button = UIButton(type: .custom)
                button.setTitle("Or have an account and need to update number?", for: .normal)
                button.titleLabel?.font = UIFont(name: Fonts.gilroyMedium, size: 12)
                button.setTitleColor(UIColor.blue, for: .normal)
                button.addTarget(self, action: #selector(handleRecoverAccountPage), for: .touchUpInside)
        return button
        
    }()
    
    private let dropDownPicker: UIImageView = {
            let imageView = UIImageView(image:#imageLiteral(resourceName: "dropdown"))
                imageView.translatesAutoresizingMaskIntoConstraints = false
                return imageView
    }()
    
    private let forwardButton: UIButton = {
        let button  = UIButton(type: .custom)
            button.setImage(UIImage(named: "forwardarrow"), for: .normal)
            button.addTarget(self, action: #selector(handleNextPage), for: .touchUpInside)
            return button
    }()
        
    private let backgroundView: UIView = {
        let view = UIView()
            view.layer.borderWidth = 0
            view.backgroundColor = Colors.fleetGreen
            view.translatesAutoresizingMaskIntoConstraints = false
        
       
            return view
    }()
    
    private let phoneNumberInput: UITextField = {
        let textfield = phoneNumberTextField()
        textfield.attributedPlaceholder = NSAttributedString(string: "Phone Number", attributes:[NSAttributedString.Key.font:UIFont(name: Fonts.gilroyRegular, size: 18) as Any, NSAttributedString.Key.foregroundColor:UIColor.lightGray])
        textfield.textColor = UIColor.black
       
        
        return textfield
    }()
    
   private let countryFlagInput: UITextField = {
        let textfield = countryField()
        return  textfield
    }()
    
    private let countryCodeInput: UITextField = {
        let textfield = countryField()
        textfield.attributedPlaceholder = NSAttributedString(string: "", attributes:[NSAttributedString.Key.font:UIFont.systemFont(ofSize: 16) as Any, NSAttributedString.Key.foregroundColor:Colors.darkRedColor])
        textfield.textColor = UIColor.black
        return textfield
       
    }()
    
    private let showCountryCode: UIButton = {
        let button = UIButton(type: .system)
            button.addTarget(self, action: #selector(handleCountryPage), for: .touchUpInside)
        
            return button
    }()
   
    private let logoImageView: UIImageView = {
        let imageView = UIImageView(image:#imageLiteral(resourceName: "fleettext"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private func configureNavigationBar() {
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
             navigationController?.navigationBar.tintColor = .white
             navigationController?.navigationBar.isTranslucent = true
             navigationController?.navigationBar.backgroundColor = .clear
             navigationItem.leftBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "backarrow").withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(handlePreviousPage))
    }
  
    private func constraintsLayout() {
      dropDownPicker.contentMode = .scaleAspectFit
      logoImageView.contentMode = .scaleAspectFit
    
  
      backgroundView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
      backgroundView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -250).isActive = true
      backgroundView.widthAnchor.constraint(equalToConstant:view.frame.width).isActive = true
      backgroundView.heightAnchor.constraint(equalToConstant: view.frame.height).isActive = true
    
   
      logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
      logoImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -100).isActive = true
      logoImageView.widthAnchor.constraint(equalToConstant:100).isActive = true
      logoImageView.heightAnchor.constraint(equalToConstant:100).isActive = true
    
  phoneText.anchor(top: backgroundView.bottomAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, leading: view.leadingAnchor, trailing: view.trailingAnchor, padding: .init(top: 30, left: 10, bottom: 0, right: 0))
   dropDownPicker.anchor(top: backgroundView.bottomAnchor, bottom: nil, leading: phoneText.leadingAnchor, trailing: nil, padding: .init(top: 102, left: 5, bottom: 0, right: 0), size: .init(width: 15, height:15))
    forwardButton.anchor(top: backgroundView.bottomAnchor, bottom:nil, leading: nil, trailing: view.safeAreaLayoutGuide.trailingAnchor, padding: .init(top: 100, left: 0, bottom:0, right: 30), size: .init(width: 25, height: 25))
    
    // Display Country Code, Change Country Code and Country Flag
       showCountryCode.anchor(top: backgroundView.bottomAnchor, bottom: nil, leading: phoneText.leadingAnchor, trailing: nil, padding: .init(top: 95, left: 0, bottom: 0, right: 0))
      
  countryCodeInput.anchor(top: backgroundView.bottomAnchor, bottom: nil, leading: view.leadingAnchor, trailing: view.trailingAnchor, padding: .init(top: 100, left: 40, bottom: 0, right: 70))
   
    // Display background color of Phone View, display border line Phone View, and Phone view Input
  phoneNumberInput.anchor(top: backgroundView.bottomAnchor, bottom: nil, leading: view.leadingAnchor, trailing: forwardButton.leadingAnchor, padding: .init(top: 100, left: 85, bottom: 0, right: 10))
      
    
    updateAcountButton.anchor(top: nil, bottom: view.safeAreaLayoutGuide.bottomAnchor, leading: phoneText.leadingAnchor, trailing: nil, padding: .init(top: 0, left: 5, bottom: 25, right: 0))
    }
      
   
    
    func configureUI() {
        view.backgroundColor = .white
   }
   
    //MARK: - Selectors
    
  
    @objc private func handleNextPage() {
        let nextViewController = VerifyNumberViewController()
        self.navigationController?.pushViewController(nextViewController, animated: false)
        let generator = UIImpactFeedbackGenerator(style: .heavy) // Add the vibration tap to the button
        generator.impactOccurred()
       
    }
    
    @objc private func handleRecoverAccountPage() {
        let nextViewController = RecoverAcountViewController()
        self.navigationController?.pushViewController(nextViewController, animated: false)
        
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
        
    }
    
   func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        phoneNumberInput.resignFirstResponder()
    
        return true
    }
    
}
extension PhoneEntryViewController: countryPickerProtocol {
    
    func didPickCountry(model: Country) {
        localeCountry = model
        //countryFlagInput.text = model.flag
        countryCodeInput.text = "+" + model.e164_cc + "" + ""
    }
}



    
  




