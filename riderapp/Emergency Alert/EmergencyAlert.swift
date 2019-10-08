//
//  EmergencyAlert.swift
//  riderapp
//
//  Created by Gregory Jones on 10/3/19.
//  Copyright © 2019 Gregory Jones. All rights reserved.
//

import UIKit

class EmergencyAlert: UIView {
    
    static let instance = EmergencyAlert()
    var securityContactNumber = "443-768-9947"
    
    @IBOutlet var parentView: UIView!
    @IBOutlet var alertView: UIView!
    @IBOutlet var redView: UIView!
    @IBOutlet var separatorLine: UIView!
    @IBOutlet var alertTitle: UILabel!
    @IBOutlet var alertMessage: UILabel!
    @IBOutlet var callButton: UIButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
       Bundle.main.loadNibNamed("EmergencyAlert", owner: self, options: nil)
       commonInit()
   }
   
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    private func commonInit() {
        alertView.layer.cornerRadius  =  12;
       
        parentView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        parentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
   }
    
    enum Alert {
        case call
    }
    
    func showAlert(title: String, message: String, alert: Alert) {
        self.alertTitle.text = title
        self.alertMessage.text = message
        
        switch alert {
        case .call:
            callButton.backgroundColor = .clear
        }
       UIApplication.shared.keyWindow?.addSubview(parentView)
        
        }
    
   // Store a number inside and call that number
    @IBAction func onCallAction(_ sender: Any) {
        parentView.removeFromSuperview()
        
       if let phoneCallURL = URL(string: "telprompt://\(securityContactNumber)") {

            let application:UIApplication = UIApplication.shared
            if (application.canOpenURL(phoneCallURL)) {
                if #available(iOS 10.0, *) {
                    application.open(phoneCallURL, options: [:], completionHandler: nil)
                } else {
                    // Fallback on earlier versions
                     application.openURL(phoneCallURL as URL)

                }
            }
        }
        
    }
    
  
    @IBAction func cancelButton(_ sender: Any) {
        parentView.removeFromSuperview()
    }
}
