//
//  ViewController.swift
//  riderapp
//
//  Created by Gregory Jones on 6/17/19.
//  Copyright © 2019 Gregory Jones. All rights reserved.
//

import UIKit
import Lottie


class ViewController: UIViewController {
   
    
    private var revealingLoaded = false
  
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(animationView)
        setupLayout()
        switchScreen()
        customNavigationBar()
       
    }
   
    
    let animationView: AnimationView = {
        let animation = AnimationView(name: "Loading_Animation")
        animation.loopMode = .loop
        animation.play()
        animation.translatesAutoresizingMaskIntoConstraints = false
        return animation
    }()
    
    func setupLayout() {
        animationView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        animationView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 50).isActive = true
        animationView.widthAnchor.constraint(equalToConstant: 100).isActive = true
        animationView.heightAnchor.constraint(equalToConstant: 500).isActive = true
        
    }
   
    func switchScreen() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) { // Delay the time to push to the next view controller by 7 seconds
            let nextViewController = self.storyboard?.instantiateViewController(withIdentifier: "SwipingScreens")
            self.show(nextViewController!, sender: nil)
        }
    }
    
    func customNavigationBar() {
        /* Customizing the navigation bar */
        self.navigationItem.setHidesBackButton(true, animated: false)
        self.navigationItem.backBarButtonItem = UIBarButtonItem()
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = .clear
    }
  
    


} // end of the class
