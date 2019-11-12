//
//  BottomTabBar.swift
//  riderapp
//
//  Created by Gregory Jones on 10/31/19.
//  Copyright © 2019 Gregory Jones. All rights reserved.
//

import UIKit
import ESTabBarController_swift

class BottomTabBarController: UITabBarController, UITabBarControllerDelegate {
     
  override func viewDidLoad() {
        super.viewDidLoad()
       setupBottomBar()
     self.tabBarController?.delegate = self
    
    }

    
 func setupBottomBar() {
          UITabBar.appearance().backgroundColor = .white
          UITabBar.appearance().tintColor = .black
       
   
           
           let homeController = HomeViewController()
           let navHome  = UINavigationController(rootViewController: homeController)
           navHome.tabBarItem.image = UIImage(named: "tabbar_car@3x")
           navHome.tabBarItem.selectedImage = UIImage(named: "tabbar_selectedcar@3x")
           navHome.tabBarItem.imageInsets =  UIEdgeInsets(top: 6, left: 0, bottom: -6, right: 0)
           navHome.tabBarItem.tag = 1
           
           
           let getPublicTransit = HomeViewController()
           let navpublicTransit = UINavigationController(rootViewController: getPublicTransit)
           navpublicTransit.tabBarItem.image = UIImage(named: "tabbar_train@3x")
           navpublicTransit.tabBarItem.selectedImage = UIImage(named: "tabbar_selectedtrain@3x")
           navpublicTransit.tabBarItem.imageInsets =  UIEdgeInsets(top: 6, left: 0, bottom: -6, right: 0)
           navpublicTransit.tabBarItem.tag = 2
          
           let reportIssue = HomeViewController()
           let navReportIssue = UINavigationController(rootViewController: reportIssue)
              navReportIssue.tabBarItem.image = UIImage(named: "tabbar_issue@3x")
           navReportIssue.tabBarItem.selectedImage = UIImage(named: "tabbar_selectedissue@3x")
           navReportIssue.tabBarItem.imageInsets =  UIEdgeInsets(top: 6, left: 0, bottom: -6, right: 0)
          navReportIssue.tabBarItem.tag = 3
             
           viewControllers = [navHome, navpublicTransit,navReportIssue]
           
      
       }
 
    
    private func createDummyNavControllerWithTitle(title: String, imageName: String) -> UINavigationController {
        let viewController = UIViewController()
        let navController = UINavigationController(rootViewController: viewController)
        navController.tabBarItem.title = title
        navController.tabBarItem.image = UIImage(named: imageName)
        return navController
    }
    
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {

        if(item.tag == 3) {
          let helpVC = HelpViewController()
            helpVC.modalPresentationStyle = .popover
              self.navigationController?.pushViewController(helpVC, animated: true)
             present(helpVC, animated: true, completion: nil)
           }
        if(item.tag == 2) {
            openTransitApp()
        }
    }
  
 /*  func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
       if viewController.tabBarItem.tag == 1 {
           let helpVC = HelpViewController()
                      helpVC.modalPresentationStyle = .pageSheet
                        self.navigationController?.pushViewController(helpVC, animated: true)
                       present(helpVC, animated: true, completion: nil)
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
    
  



  

   



