//
//  BottomTabBar.swift
//  riderapp
//
//  Created by Gregory Jones on 10/31/19.
//  Copyright © 2019 Gregory Jones. All rights reserved.
//

import UIKit


class BottomTabBarController: UITabBarController, UITabBarControllerDelegate {
    
  let tabBarHeight = 80;
    
  override func viewDidLoad() {
        super.viewDidLoad()
       setupBottomBar()
       self.tabBarController?.delegate = self
      // self.tabBarController?.view.removeFromSuperview()
 
   
    }
   
 
      
  
    
 func setupBottomBar() {
          UITabBar.appearance().backgroundColor = .lightGray
          UITabBar.appearance().tintColor = .black
          tabBar.isTranslucent = false
        let homeController = HomeViewController()
           let navHome  = UINavigationController(rootViewController: homeController)
           navHome.tabBarItem.image = UIImage(named: "tabbar_car@2x")
           navHome.tabBarItem.selectedImage = UIImage(named: "tabbar_selectedcar@2x")
           navHome.tabBarItem.imageInsets =  UIEdgeInsets(top: 6, left: 0, bottom: -6, right: -80)
           navHome.tabBarItem.tag = 1
           
           
           let getPublicTransit = OpenTransitApp()
           let navpublicTransit = UINavigationController(rootViewController: getPublicTransit)
           navpublicTransit.tabBarItem.image = UIImage(named: "tabbar_train@2x")
           navpublicTransit.tabBarItem.selectedImage = UIImage(named: "tabbar_selectedtrain@2x")
           navpublicTransit.tabBarItem.imageInsets =  UIEdgeInsets(top: 6, left: -80, bottom: -6, right: 0)
           navpublicTransit.tabBarItem.tag = 2
          
         
             
           viewControllers = [navHome, navpublicTransit]
           
      
       }
 
   
    
    private func createDummyNavControllerWithTitle(title: String, imageName: String) -> UINavigationController {
        let viewController = UIViewController()
        let navController = UINavigationController(rootViewController: viewController)
        navController.tabBarItem.title = title
        navController.tabBarItem.image = UIImage(named: imageName)
        return navController
    }
    
  /*  override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {

        if(item.tag == 3) {
          let helpVC = HelpViewController()
           helpVC.modalPresentationStyle =  .popover
              self.navigationController?.pushViewController(helpVC, animated: true)
             present(helpVC, animated: true, completion: nil)
           
          
           }
       
        if(item.tag == 2) {
            openTransitApp()
             dismiss(animated: true, completion: nil)
           
        }
    } */
    
  
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
    
  



  

   



