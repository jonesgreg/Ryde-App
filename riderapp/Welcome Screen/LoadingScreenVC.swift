//
//  LoadingScreenViewController.swift
//  riderapp
//
//  Created by Gregory Jones on 8/6/19.
//  Copyright © 2019 Gregory Jones. All rights reserved.
//

import UIKit
import Lottie


/// This class is optional -- Animation launch screen class

class LoadingViewController: UIViewController {
    
    
    private var revealingLoaded = false
    
    // MARK: - Overriden function
    override func viewDidLoad() {
        super.viewDidLoad()
      
        view.addSubview(logoImageView)
        setupLayout()
        switchScreen()
        view.backgroundColor = Colors.fleetGreen
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // Hide the navigation bar on the this view controller
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    private let logoImageView: UIImageView = {
        let imageView = UIImageView(image:#imageLiteral(resourceName: "fleet_text"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
   
    private let animationView: AnimationView = {
            let animation = AnimationView(name: "Loading_Animation")
            animation.loopMode = .loop
            animation.play()
        animation.translatesAutoresizingMaskIntoConstraints = false
        return animation
    }()
    
    func setupLayout() {
         logoImageView.contentMode = .scaleAspectFit
     /*   animationView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        animationView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 50).isActive = true
        animationView.widthAnchor.constraint(equalToConstant: 100).isActive = true
        animationView.heightAnchor.constraint(equalToConstant: 500).isActive = true */
        
        logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        logoImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        logoImageView.widthAnchor.constraint(equalToConstant:50).isActive = true
        logoImageView.heightAnchor.constraint(equalToConstant:50).isActive = true
    }
    
    func switchScreen() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) { // Delay the time to push to the next view controller by 7 seconds
            let layout = UICollectionViewFlowLayout()
                layout.scrollDirection = .horizontal
            let nextViewController = GuideViewController(collectionViewLayout: layout)
            self.navigationController?.pushViewController(nextViewController, animated: false)
        }
    }
    
    
    
}

