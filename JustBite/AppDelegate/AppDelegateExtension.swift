//
//  AppDelegateExtension.swift
//  JustBite
//
//  Created by Aman on 14/05/19.
//  Copyright © 2019 Mobulous. All rights reserved.
//

import Foundation
import UIKit
import KYDrawerController
import UserNotifications
import RealmSwift

extension AppDelegate{
    
    internal func openDrawer(){
        
        drawerController = KYDrawerController.init(drawerDirection: .left, drawerWidth: MAIN_SCREEN_WIDTH - 80)
        
        let homeVC = AppStoryboard.tabbarClass as! TabBarViewC
        let drawerVC = AppStoryboard.home.instantiateViewController(withIdentifier: DrawerControllerVC.className) as! DrawerControllerVC
        let navigationController = UINavigationController(rootViewController: drawerController!)
        self.drawerController!.mainViewController = homeVC
        self.drawerController!.drawerViewController = drawerVC
        self.window?.rootViewController = navigationController
        navigationController.isNavigationBarHidden = true
        self.window?.makeKeyAndVisible()
        drawerController?.setDrawerState(.opened, animated: true)
        
    }
    
    internal func openDrawer1(){
        
        drawerController = KYDrawerController.init(drawerDirection: .left, drawerWidth: MAIN_SCREEN_WIDTH - 80)
        
        let homeVC = AppStoryboard.tabbarClass as! TabBarViewC
        let drawerVC = AppStoryboard.home.instantiateViewController(withIdentifier: DrawerControllerVC.className) as! DrawerControllerVC
        let navigationController = UINavigationController(rootViewController: drawerController!)
        self.drawerController!.mainViewController = homeVC
        self.drawerController!.drawerViewController = drawerVC
        self.window?.rootViewController = navigationController
        homeVC.selectedIndex = 2
        navigationController.isNavigationBarHidden = true
        self.window?.makeKeyAndVisible()
        drawerController?.setDrawerState(.closed, animated: true)
        
    }
    
    
    func checkAutoLogin()
    {
        let realm = try! Realm()
        if realm.objects(SignupDataModel.self).first != nil{
                
            let viewController = AppStoryboard.tabbarClass as! TabBarViewC
            let navigationController = UINavigationController(rootViewController: viewController)
            viewController.selectedIndex = 0
            navigationController.navigationBar.isHidden = true
            (UIApplication.shared.delegate as! AppDelegate).window?.rootViewController = navigationController
            
            APPLICATION.keyWindow?.rootViewController = navigationController
        }else{
            let vc = AppStoryboard.auth.instantiateViewController(withIdentifier: LoginVC.className) as! LoginVC
            let nav = UINavigationController(rootViewController: vc)
            nav.isNavigationBarHidden = true
            (UIApplication.shared.delegate as! AppDelegate).window?.rootViewController = nav

            
        }
    }
    
    
}
