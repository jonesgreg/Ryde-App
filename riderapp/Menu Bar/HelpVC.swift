//
//  HelpVC.swift
//  riderapp
//
//  Created by Gregory Jones on 9/19/19.
//  Copyright © 2019 Gregory Jones. All rights reserved.
//

import UIKit
import WebKit

class HelpViewController: UIViewController, WKNavigationDelegate {
    //MARK: Properties
    private var activityIndicatorContainer: UIView!
    private var activityIndicator: UIActivityIndicatorView!
    var webView: WKWebView!
    var toolBar = UIToolbar()
    
    //MARK: Override functions
    
    override func viewDidLoad() {
        configureUI()
        super.viewDidLoad()
        let url = URL(string: "https://www.loyola.edu/department/public-safety/services/escort")!
        webView.load(URLRequest(url: url))
        webView.allowsBackForwardNavigationGestures = true
        configureNavigationController()
        configureTabBar()
    }
    
    override func loadView() {
        webView = WKWebView()
        webView.navigationDelegate = self // Delegation
        view = webView
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        addHeightConstraintsToTabBar()
    }
    
    
    func configureUI() {
        view.backgroundColor = .white
        
    }
    
    private func configureTabBar() {
        
        let backButton = UIButton(type: .system)
        backButton.setImage(#imageLiteral(resourceName: "leftarrow"), for: .normal)
        backButton.setTitle("PREVIOUS", for: .normal)
        backButton.semanticContentAttribute = .forceLeftToRight
        backButton.titleLabel?.font = UIFont(name: Fonts.montserratBold, size: 12)
        backButton.tintColor = .black
        backButton.addTarget(self, action: #selector(handlePreviousPage), for: .touchUpInside)
        let leftBarButton = UIBarButtonItem.init(customView: backButton)
        
        let forwardButton = UIButton(type: .system)
        forwardButton.setImage(#imageLiteral(resourceName: "black_rightarrow"), for: .normal)
        forwardButton.setTitle("NEXT", for: .normal)
        forwardButton.semanticContentAttribute = .forceRightToLeft
        forwardButton.titleLabel?.font = UIFont(name: Fonts.montserratBold, size: 12)
        forwardButton.tintColor = .black
        forwardButton.addTarget(self, action: #selector(handleNextPage), for: .touchUpInside)
        let rightBarButton = UIBarButtonItem.init(customView: forwardButton)
        
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        
        toolBar.setShadowImage(UIImage(), forToolbarPosition: .any)
        toolBar.barTintColor = .white
        toolBar.translatesAutoresizingMaskIntoConstraints = false
        toolBar.items = [leftBarButton, flexibleSpace,rightBarButton]
        
        webView.addSubview(toolBar)
        NSLayoutConstraint.activate([toolBar.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
                                     toolBar.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
                                     toolBar.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            ])
    }
    
    func addHeightConstraintsToTabBar() -> Void {
        let heightConstant: CGFloat = self.view.safeAreaInsets.bottom + 40
        toolBar.heightAnchor.constraint(equalToConstant: heightConstant).isActive = true
        
    }
    
    private func configureNavigationController() {
        navigationController?.navigationBar.barTintColor = Colors.lighterGrey
        // navigationController?.navigationBar.tintColor =
        
        navigationItem.title = "Contact Support"
        navigationController?.navigationBar.isTranslucent = false
        let textAttributes = [NSAttributedString.Key.font: UIFont(name: Fonts.montserratSemiBold, size: 16) as Any, NSAttributedString.Key.foregroundColor:UIColor.black]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        navigationItem.leftBarButtonItem = UIBarButtonItem.barButton(self, action: #selector(handlePreviousViewController), imageName: "menuBack")
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
    @objc private func handlePreviousViewController() {
        self.navigationController?.popViewController(animated: false)
    }
    
    @objc private func handlePreviousPage() {
        if webView.canGoBack {
            webView.goBack()
        } else  {
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    @objc private func handleNextPage() {
        if webView.canGoForward {
            webView.goForward()
            
        }
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

    

