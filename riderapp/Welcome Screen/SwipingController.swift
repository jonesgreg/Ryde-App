//
//  SwipingController.swift
//  riderapp
// Description - Description: This is the controller and it is responsible for coordinating all of the views and models so they know about the correct object and needs to display
//  Created by Gregory Jones on 6/26/19.
//  Copyright © 2019 Gregory Jones. All rights reserved.
//

import UIKit


class SwipingController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    
        let pages = [
            Page(imageName: "profile", headerText: "Create an account", bodyText: "All you need is a valid school email address and a valid phone number. You can request a ride by downloading the app, go to the App Store."),
            Page(imageName: "enterdestination", headerText: "Enter Destination", bodyText: "Open the app and enter where you are going in the where to search bar. Tap to confirm your pickup location and tap request ride to match with a driver.Passengers are restricted to pick up and drop off locations."),
            Page(imageName: "meetadriver", headerText: "Meet your driver", bodyText: "You can track their arrival on the map. When they're a few minutes away, wait for them at your pickup location."),
            Page(imageName: "checkride", headerText: "Check ride", bodyText: "Every time you take a trip with Ryde, please make sure you're getting in the right vehicle with the proper driver by checking to see if the car is registered at your University with a school logo, a tag number, and driver photo with what's provided in your app."),
            Page(imageName: "payment", headerText: "Enjoy your trip", bodyText: "Your trip is free. There is no cash or credit card required for your trip."),
            Page(imageName: "rateme", headerText: "Rate your trip", bodyText: "Let us know how your trip went. We take feedback critical, and we want you to enjoy using this service. ")
    
    ]
    
    /* Ride Now Button */
    private let rideNowButton: UIButton = {
        let button = UIButton(type: .system)
        button.layer.borderWidth = 1
        button.layer.borderColor = Colors.darkPurple.cgColor
        button.backgroundColor = Colors.darkPurple
        button.setTitle("Ryde Now", for: .normal)
        button.titleLabel?.font = UIFont(name: Fonts.montserratSemiBold, size: 20)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 15
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(handleNextPage), for: .touchUpInside)
        
        return button
        
    }()
    
    @objc private func handleNextPage() {
        let nextViewController = self.storyboard?.instantiateViewController(withIdentifier: "SignIn")
        self.show(nextViewController!, sender: nil)
        
    }
    
    private let GoogleLoginButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Login with Google", for: .normal)
        button.titleLabel?.font = UIFont(name: Fonts.montserratSemiBold, size: 16)
        button.setTitleColor(.darkGray, for: .normal)
        
        
        return button
    }()
    
   
    
    /* Page Control */
      private lazy var pageControl: UIPageControl = {
        let pc = UIPageControl()
        pc.currentPage = 0
        pc.numberOfPages = pages.count
        pc.currentPageIndicatorTintColor = Colors.darkPurple
        pc.pageIndicatorTintColor = UIColor.lightGray
        return pc
    }()
    
    private func setupBottomControls() {
      
        let bottomControlsStackView = UIStackView(arrangedSubviews: [pageControl])
        bottomControlsStackView.translatesAutoresizingMaskIntoConstraints = false
        bottomControlsStackView.distribution = .fillEqually
        view.addSubview(bottomControlsStackView)
        bottomControlsStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        bottomControlsStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        bottomControlsStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -115).isActive = true
        
        
        let rideNowButtonStackView = UIStackView(arrangedSubviews: [rideNowButton])
        rideNowButtonStackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(rideNowButtonStackView)
        rideNowButtonStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
        rideNowButtonStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
        rideNowButtonStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50).isActive = true
        rideNowButtonStackView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        
        let googleButtonStackView = UIStackView(arrangedSubviews: [GoogleLoginButton])
            googleButtonStackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview( googleButtonStackView)
         googleButtonStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
         googleButtonStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
         googleButtonStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -6.5).isActive = true
       
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBottomControls()
        collectionView?.backgroundColor = .white
        collectionView?.register(PageCell.self, forCellWithReuseIdentifier: "cellId")
        collectionView?.isPagingEnabled = true
        customNavigationBar()
        
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
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pages.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath) as! PageCell
        
        let page = pages[indexPath.item] // This is done through 45, which is sending the page object into the page cell
        cell.page = page
        
       
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: view.frame.height)
    }
    
    func customNavigationBar() {
        /* Customizing the navigation bar */
        self.navigationItem.setHidesBackButton(true, animated: false)
        self.navigationItem.backBarButtonItem?.title = ""
     self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = .clear
    }
    

    
}

