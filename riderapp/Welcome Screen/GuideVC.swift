//
//  GuideViewController.swift
//  riderapp
// This is the controller and it is responsible for coordinating all of the views and models so they know about the correct object and needs to display
//  Created by Gregory Jones on 8/5/19.
//  Copyright © 2019 Gregory Jones. All rights reserved.
//

import UIKit

class GuideViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout{
    
    let pages = [
        Page(imageName: "profile", headerText: "Login your account", bodyText: "Enter your phone number if you have account with ryde or login with Google."),
        Page(imageName: "enterdestination", headerText: "Enter Destination", bodyText: "Open the app and enter where you are going in the where to search bar. Passengers are restricted to pick up and drop off locations."),
        Page(imageName: "meetdriver", headerText: "Meet your driver", bodyText: "You can track their arrival on the map. When they're a few minutes away, wait for them at your pickup location."),
        Page(imageName: "checkride", headerText: "Check ride", bodyText: "Please check for the right vehicle with the proper driver. Check for logos, numbers, and tags."),
        Page(imageName: "payment", headerText: "Enjoy your trip", bodyText: "Your trip is free. There is no cash or credit card required for your trip."),
        Page(imageName: "rateme", headerText: "Rate your trip", bodyText: "Let us know how your trip went. We take feedback critical, and we want you to enjoy using this service. ")
    ]
   
  // MARK: - Private functions

    private let rideNowButton: UIButton = {
        let button = redButton(type: .system)
        button.setTitle("RYDE NOW", for: .normal)
        button.titleLabel?.font = UIFont(name: Fonts.montserratBold, size: 20)
        button.addTarget(self, action: #selector(handleNextPage), for: .touchUpInside)
        return button
    }()
   
   private let GoogleLoginButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Login with Google", for: .normal)
        button.titleLabel?.font = UIFont(name: Fonts.montserratMedium, size: 18)
        button.setTitleColor(.black, for: .normal)
        return button
    }()
    
    lazy var pageControl: UIPageControl = {
        let pc = UIPageControl()
        pc.currentPage = 0
        pc.numberOfPages = pages.count
        pc.currentPageIndicatorTintColor = Colors.primaryRed
        pc.pageIndicatorTintColor = UIColor.lightGray
        return pc
    }()
    
    
   private func setupBottomControls() {
        
        let bottomControlsStackView = UIStackView(arrangedSubviews: [pageControl])
        bottomControlsStackView.distribution = .fillEqually
        view.addSubview(bottomControlsStackView)
        let rideNowButtonStackView = UIStackView(arrangedSubviews: [rideNowButton])
        view.addSubview(rideNowButtonStackView)
        let googleButtonStackView = UIStackView(arrangedSubviews: [GoogleLoginButton])
        view.addSubview( googleButtonStackView)
        
        bottomControlsStackView.anchor(top: nil, bottom: view.safeAreaLayoutGuide.bottomAnchor, leading: view.safeAreaLayoutGuide.leadingAnchor, trailing: view.safeAreaLayoutGuide.trailingAnchor, padding: .init(top: 0, left: 0, bottom: 150, right: 0))
        rideNowButtonStackView.anchor(top: nil, bottom: view.safeAreaLayoutGuide.bottomAnchor, leading: view.safeAreaLayoutGuide.leadingAnchor, trailing:view.safeAreaLayoutGuide.trailingAnchor, padding: .init(top: 0, left: 16, bottom: 70, right: 16), size: .init(width: 0, height: 50))
        googleButtonStackView.anchor(top: nil, bottom: view.safeAreaLayoutGuide.bottomAnchor, leading: view.safeAreaLayoutGuide.leadingAnchor, trailing: view.safeAreaLayoutGuide.trailingAnchor, padding: .init(top: 0, left:16, bottom: 20, right: 16))
    }
    
    /* This allows you to scroll your views
     * It is unsafemutablepointer and inside that pointer is a CGPoint value
     * And the pointee gives your that CGPoint Value
     * You just access the x value on CGPoints
     *
     */
   override func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let x = targetContentOffset.pointee.x  // The x value is going to let you know where to stop the dragging/animation
        pageControl.currentPage = Int(x / view.frame.width)
    }
   
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // Hide the navigation bar on the this view controller
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        // Show the navigation bar on other view controllers
      //  navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBottomControls()
        collectionView?.backgroundColor = .white
        collectionView?.register(PageCell.self, forCellWithReuseIdentifier: PageCell.identifer)
    }
    
    // MARK: - Selectors
    @objc private func handleNextPage() {
        let nextViewController = PhoneEntryViewController()
        self.navigationController?.pushViewController(nextViewController, animated: false)
        let generator = UIImpactFeedbackGenerator(style: .heavy) // Add the vibration tap to the button
        generator.impactOccurred()
    }
    
   
   
    
}



    
    
    
   
    

