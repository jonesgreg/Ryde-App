//
//  DriveAndEarnVC.swift
//  riderapp
//
//  Created by Gregory Jones on 9/19/19.
//  Copyright © 2019 Gregory Jones. All rights reserved.
//

import UIKit
import WebKit

class DriveAndEarnViewController: UIViewController, WKNavigationDelegate {
    
    
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
        configureUI()
        super.viewDidLoad()
        let url = URL(string: "https://fleetapp.tech/general-1")!
         webView.load(URLRequest(url: url))
        webView.allowsBackForwardNavigationGestures = true
        
     }
   
    override func viewWillAppear(_ animated: Bool) {
        configureNavigationController()
        hideTabBarController()
    
    
    }
    
    override func viewWillDisappear(_ animated: Bool) {
           super.viewWillDisappear(animated)
           self.navigationController?.setNavigationBarHidden(false, animated: animated)
           showTabBarController()
       }
    
    func configureUI() {
        view.backgroundColor = .white
        
    }
    private func configureNavigationController() {
              navigationItem.title = "Become a driver and earn money"
              navigationItem.setHidesBackButton(true, animated: false)
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

extension DriveAndEarnViewController: UINavigationBarDelegate {
    public func position(for bar: UIBarPositioning) -> UIBarPosition {
               return .topAttached
           }
    
}

