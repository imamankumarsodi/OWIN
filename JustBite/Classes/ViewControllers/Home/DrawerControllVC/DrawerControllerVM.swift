//
//  DrawerControllerVM.swift
//  JustBite
//
//  Created by Aman on 14/05/19.
//  Copyright © 2019 Mobulous. All rights reserved.
//

import Foundation
import UIKit
import RealmSwift

// MARK: - Login Protocol

protocol LeftModeling {
    
    func prepareDataSource() -> [LeftMenuStruct]

}


// MARK: - Class LoginVM

class DrawerControllerVM:LeftModeling{
    
    func prepareDataSource() -> [LeftMenuStruct] {
        var dataSource = [LeftMenuStruct]()
        
        dataSource.append(LeftMenuStruct(title: "Home", image: #imageLiteral(resourceName: "homes"), isHidden: true, price: String()))
        dataSource.append(LeftMenuStruct(title: "My Favorites", image: #imageLiteral(resourceName: "like_icon"), isHidden: true, price: String()))
        dataSource.append(LeftMenuStruct(title: "Offers", image: #imageLiteral(resourceName: "offers"), isHidden: true, price: String()))

//        let realm = try! Realm()
//        if let userInfo = realm.objects(SignupDataModel.self).first{
//            if userInfo.access_token != ""{
//               dataSource.append(LeftMenuStruct(title: "Just Bite Credit", image: #imageLiteral(resourceName: "justbite_credit"), isHidden: false, price: String(userInfo.wallet)))
//            }
//            else{
//                dataSource.append(LeftMenuStruct(title: "Just Bite Credit", image: #imageLiteral(resourceName: "justbite_credit"), isHidden: true, price: String(userInfo.wallet)))
//            }
//        }
//        else{
//
//            dataSource.append(LeftMenuStruct(title: "Just Bite Credit", image: #imageLiteral(resourceName: "justbite_credit"), isHidden: true, price: "0"))
//
//        }
//
//
     //   dataSource.append(LeftMenuStruct(title: "My Payment", image: #imageLiteral(resourceName: "payments"), isHidden: true, price: String()))
        dataSource.append(LeftMenuStruct(title: "Notifications", image: #imageLiteral(resourceName: "sm_notification"), isHidden: true, price: String()))
        dataSource.append(LeftMenuStruct(title: "Settings", image: #imageLiteral(resourceName: "settings"), isHidden: true, price: String()))
        dataSource.append(LeftMenuStruct(title: "Share App", image: #imageLiteral(resourceName: "sm_share"), isHidden: true, price: String()))
        dataSource.append(LeftMenuStruct(title: "Customer Stories", image: #imageLiteral(resourceName: "sm_stories"), isHidden: true, price: String()))
        dataSource.append(LeftMenuStruct(title: "About Us", image: #imageLiteral(resourceName: "about_us"), isHidden: true, price: String()))
        dataSource.append(LeftMenuStruct(title: "Terms & Conditions", image: #imageLiteral(resourceName: "terms_conditions"), isHidden: true, price: String()))
        dataSource.append(LeftMenuStruct(title: "Contact Us", image: #imageLiteral(resourceName: "phone_call"), isHidden: true, price: String()))
        dataSource.append(LeftMenuStruct(title: "FAQ's", image: #imageLiteral(resourceName: "faqs"), isHidden: true, price: String()))
        dataSource.append(LeftMenuStruct(title: "Help", image: #imageLiteral(resourceName: "help"), isHidden: true, price: String()))
   
        return dataSource
    }
    
  
    
}
