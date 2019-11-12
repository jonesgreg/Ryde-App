//
//  OpenTransitApp.swift
//  riderapp
//
//  Created by Gregory Jones on 11/5/19.
//  Copyright © 2019 Gregory Jones. All rights reserved.
//

import UIKit
import WebKit

class OpenTransitApp: UIViewController {
    
    override func loadView() {
        openTransitApp()
    }
    
    func openTransitApp() {
          let application = UIApplication.shared
          let transitAppPath = "transit://app"
          let appUrl = URL(string: transitAppPath)!
          let websiteURL = URL(string: "https://apps.apple.com/app/apple-store/id498151501")!
        
        if application.canOpenURL(appUrl) {
            application.open(appUrl, options: [:], completionHandler: nil)
        } else {
            application.open(websiteURL)
        }
    }
}

