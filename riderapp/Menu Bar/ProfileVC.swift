//
//  ProfileVC.swift
//  riderapp
//
//  Created by Gregory Jones on 9/18/19.
//  Copyright © 2019 Gregory Jones. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // Hide the navigation bar on the this view controller
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
        
        
    }
    
    private func configureUI() {
        view.backgroundColor = .white
    }
    
}

