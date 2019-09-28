//
//  RideHistoryVC.swift
//  riderapp
//
//  Created by Gregory Jones on 9/19/19.
//  Copyright © 2019 Gregory Jones. All rights reserved.
//

import UIKit

class RideHistoryViewController: UIViewController {
    
    override func viewDidLoad() {
        configureUI()
        configureNavigationController()
        
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
       // self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }
func configureUI() {
    view.backgroundColor = .white
    
}
    
    private func configureNavigationController() {
        navigationController?.navigationBar.barTintColor = Colors.fleetGreen// background color
       // navigationController?.navigationBar.barStyle = .white // Handle
       
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "Ride History"
        navigationItem.largeTitleDisplayMode = .always
        //navigationController?.navigationBar.sizeToFit()
        navigationController?.navigationBar.isTranslucent = false
        let textAttributes = [NSAttributedString.Key.font: UIFont(name: Fonts.montserratSemiBold, size: 18) as Any, NSAttributedString.Key.foregroundColor:UIColor.black]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        navigationItem.leftBarButtonItem = UIBarButtonItem.barButton(self, action: #selector(handlePreviousPage), imageName: "menuBack")
      
    }

 // MARK: - Selectors

@objc private func handlePreviousPage() {
    self.navigationController?.popViewController(animated: false)
    }
}
