//
//  TabBarViewC.swift
//
//  Created by Sandeep Vishwakarma on 4/16/18.
//  Copyright © 2018 Sandeep. All rights reserved.
//


import UIKit

class TabBarViewC: UITabBarController {

    //MARK:- All Properties
    
    var isMenuActive = false
    
    //MAKR:- View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
        self.selectedIndex = 0
        for tabBarItem in tabBar.items! {
            tabBarItem.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: AppColor.themeColor], for: .selected)
            tabBarItem.imageInsets = UIEdgeInsets(top: -6, left: 0, bottom: -6, right: 0)
        }
        self.delegate = self
        
    }
    
    //TODO: View Will appear
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
    
     //MARK: - Post View Method

    func setUpView() {
        
        //Add seprators Line
        if let items = self.tabBar.items {
            //Get the height of the tab bar
            let height = self.tabBar.bounds.height - 20
            //Calculate the size of the items
            let numItems = CGFloat(items.count)
            let itemSize = CGSize(
                width: tabBar.frame.width / numItems,
                height: tabBar.frame.height)
            
            for (index, _) in items.enumerated() {
                //We don't want a separator on the left of the first item.
                if index > 0 {
                    //Xposition of the item
                    let xPosition = itemSize.width * CGFloat(index)
                    /* Create UI view at the Xposition,
                     with a width of 0.5 and height equal
                     to the tab bar height, and give the
                     view a background color
                     */
                    let separator = UIView(frame: CGRect(
                        x: xPosition, y: 10, width: 0.5, height: height))
                    separator.backgroundColor = UIColor.lightGray
                    tabBar.insertSubview(separator, at: 1)
                }
            }
        }
        
        let homeSelectImage: UIImage! = UIImage(named: "home_salected")?.withRenderingMode(.alwaysOriginal)
        let homeImage: UIImage! = UIImage(named: "home")?.withRenderingMode(.alwaysOriginal)

        let locationSelectImage: UIImage! = UIImage(named: "search_ic")?.withRenderingMode(.alwaysOriginal)
        let locationImage: UIImage! = UIImage(named: "_search_icon")?.withRenderingMode(.alwaysOriginal)

        let notificationSelectImage: UIImage! = UIImage(named: "form_my_order")?.withRenderingMode(.alwaysOriginal)
        let notificationImage: UIImage! = UIImage(named: "listing_ic")?.withRenderingMode(.alwaysOriginal)

        let profileSelectImage = UIImage(named: "user_salected")?.withRenderingMode(.alwaysOriginal)
        let profileImage = UIImage(named: "user_ic")?.withRenderingMode(.alwaysOriginal)

        (tabBar.items![0]).selectedImage = homeSelectImage
        (tabBar.items![0]).image = homeImage
        (tabBar.items![0]).title = "Home"
        
        (tabBar.items![1] ).selectedImage = locationSelectImage
        (tabBar.items![1] ).image = locationImage
        (tabBar.items![1]).title = "Search"

        (tabBar.items![2] ).selectedImage = notificationSelectImage
        (tabBar.items![2] ).image = notificationImage
        (tabBar.items![2]).title = "My Orders"

        (tabBar.items![3] ).selectedImage = profileSelectImage
        (tabBar.items![3] ).image = profileImage
        (tabBar.items![3]).title = "My Profile"
    }
    
    
    
    
}

// MARK: - Tab Bar Delegate Method

extension TabBarViewC: UITabBarControllerDelegate {
    
    
    
    
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool{
        
        return true
    }
    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController){
        
    }
}
