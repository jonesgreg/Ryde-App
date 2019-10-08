//
//  PrivacyVC.swift
//  riderapp
//
//  Created by Gregory Jones on 8/21/19.
//  Copyright © 2019 Gregory Jones. All rights reserved.
//

import UIKit
import SafariServices
import WebKit

class PrivacyViewController: UIViewController, WKNavigationDelegate {
        
        //MARK: Properties
        private var activityIndicatorContainer: UIView!
        private var activityIndicator: UIActivityIndicatorView!
        var webView: WKWebView!
        var toolBar = UIToolbar()
      
      
        //MARK: Override functions
        override func loadView() {
            webView = WKWebView()
            webView.navigationDelegate = self // Delegation
            view = webView
              
        }
       
        override func viewDidLoad() {
            super.viewDidLoad()
            
            let url = URL(string: "https://www.lyft.com/terms")!
            webView.load(URLRequest(url: url))
            webView.allowsBackForwardNavigationGestures = true
        }

        
        override func viewWillAppear(_ animated: Bool) {
            configureNavigationController()
        
        }
        
        override func viewWillDisappear(_ animated: Bool) {
            super.viewWillDisappear(animated)
                willMove(toParent: AgreementViewController())
             
        }
  
  
  
       
    private func configureNavigationController() {
           navigationItem.title = "Privacy Policy"
                   navigationController?.navigationBar.isTranslucent = false
          navigationController?.navigationBar.barTintColor = .white // Background color
                  let textAttributes = [NSAttributedString.Key.font: UIFont(name: Fonts.gilroySemiBold, size: 18) as Any, NSAttributedString.Key.foregroundColor:UIColor.black]
                  navigationController?.navigationBar.titleTextAttributes = textAttributes

              //Cancel Button
             let cancelButton = UIButton(type: .custom)
                  cancelButton.setImage(UIImage(named: "delete"), for: .normal)
                  cancelButton.width(constant: 18)
                  cancelButton.height(constant: 18)
                  cancelButton.addTarget(self, action: #selector(handlePreviousPage), for: .touchUpInside)
                  let navigationItem = UIBarButtonItem(customView: cancelButton)
                  self.navigationItem.setLeftBarButton(navigationItem, animated:false)
            }

    private func setActivityIndicator() {
        //configure the background containerview for the indicator original width: 80 and height 80
        activityIndicatorContainer = UIView(frame: CGRect(x:0, y:0, width: 200, height: 200))
        activityIndicatorContainer.center.x = webView.center.x
        // Need to substract 44 because WebView is pineed to SafeAra and we add the toolbar of height 44
        activityIndicatorContainer.center.y = webView.center.y - 44
        activityIndicatorContainer.backgroundColor = UIColor.clear
        activityIndicatorContainer.alpha = 0.8
        activityIndicatorContainer.layer.cornerRadius = 10
        
        activityIndicator = UIActivityIndicatorView()
        activityIndicator.hidesWhenStopped = true
        activityIndicator.style = UIActivityIndicatorView.Style.white
        activityIndicator.color = UIColor.darkGray
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        
        
        activityIndicatorContainer.addSubview(activityIndicator)
        
        webView.addSubview(activityIndicatorContainer)
        
        // Constraints
        activityIndicator.centerXAnchor.constraint(equalTo: activityIndicatorContainer.centerXAnchor).isActive = true
        activityIndicator.centerYAnchor.constraint(equalTo: activityIndicatorContainer.centerYAnchor).isActive = true
    }


    // MARK: - Selectors
        
    @objc private func handlePreviousPage() {
        self.navigationController?.popViewController(animated: false)
        
    }
    
    override func willMove(toParent parent: UIViewController?) {
         super.willMove(toParent: parent)
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
         self.navigationController?.navigationBar.barTintColor = .white //previous color
        navigationController?.navigationBar.tintColor = .black
        navigationController?.navigationBar.barStyle = .default
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.navigationBar.backgroundColor = .clear
        navigationItem.leftBarButtonItem = UIBarButtonItem.barButton(self, action: #selector(handlePreviousPage), imageName: "backarrow")
     
       
    }

   

    private func showActivityIndicator(show: Bool)  {
        if show {
            activityIndicator.startAnimating()
        } else {
            activityIndicator.stopAnimating()
            activityIndicatorContainer.removeFromSuperview()
        }
    }

    // WK Navigation Delegates Extended Methods

    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        self.showActivityIndicator(show: false)
    }

    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        self.setActivityIndicator()
        self.showActivityIndicator(show: true)
    }

    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        self.showActivityIndicator(show: false)
    }


    }

    extension PrivacyViewController: UINavigationBarDelegate {
        
        public func position(for bar: UIBarPositioning) -> UIBarPosition {
            return .topAttached
        }
}



