//
//  DrawerControllerTableViewDataSourceAndDelegateExtenion.swift
//  JustBite
//
//  Created by Aman on 14/05/19.
//  Copyright © 2019 Mobulous. All rights reserved.
//

import Foundation
//
//  LoginTableView+TextField.swift
//  JustBite
//
//  Created by Aman on 05/05/19.
//  Copyright © 2019 Mobulous. All rights reserved.
//

import Foundation
import UIKit
import RealmSwift

extension DrawerControllerVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
        
        if tableView == self.tblViewDrawer{
            if indexPath.row == 0{
                
                kAppDelegate.drawerController?.setDrawerState(.closed, animated: true)
                let homeVC = AppStoryboard.tabbarClass as! TabBarViewC
                let drawerVC = AppStoryboard.home.instantiateViewController(withIdentifier: DrawerControllerVC.className) as! DrawerControllerVC
                let navigationController = UINavigationController(rootViewController: kAppDelegate.drawerController!)
                homeVC.selectedIndex = 0
                kAppDelegate.drawerController!.mainViewController = homeVC
                kAppDelegate.drawerController!.drawerViewController = drawerVC
                kAppDelegate.window?.rootViewController = navigationController
                navigationController.isNavigationBarHidden = true
                kAppDelegate.window?.makeKeyAndVisible()
                
            }else if indexPath.row == 1{
                super.moveToNextViewC(name: "Home", withIdentifier: MyFavroiteVC.className)
                
                /*  let realm = try! Realm()
                 if let userInfo = realm.objects(SignupDataModel.self).first{
                 if userInfo.id == ""{
                 _ = SweetAlert().showAlert(APP_NAME, subTitle: ConstantTexts.LoginRwq, style: AlertStyle.warning, buttonTitle:ConstantTexts.cancel, buttonColor: AppColor.themeColor , otherButtonTitle:  ConstantTexts.Ok,  otherButtonColor: AppColor.stepperColor) { (isOtherButton) -> Void in
                 if isOtherButton == true {
                 print("Cancel Button  Pressed", terminator: "")
                 }
                 else
                 {
                 super.moveToNextViewCViaRoot(name:"Auth",withIdentifier: LoginVC.className)
                 }
                 
                 }
                 }
                 else{
                 super.moveToNextViewC(name: "Home", withIdentifier: MyFavroiteVC.className)
                 }
                 }
                 else{
                 print("do nothing")
                 _ = SweetAlert().showAlert(APP_NAME, subTitle: ConstantTexts.LoginRwq, style: AlertStyle.warning, buttonTitle:ConstantTexts.cancel, buttonColor: AppColor.themeColor , otherButtonTitle:  ConstantTexts.Ok,  otherButtonColor: AppColor.stepperColor) { (isOtherButton) -> Void in
                 if isOtherButton == true {
                 print("Cancel Button  Pressed", terminator: "")
                 }
                 else
                 {
                 super.moveToNextViewCViaRoot(name:"Auth",withIdentifier: LoginVC.className)
                 }
                 
                 }
                 
                 } */
                
            }
            else if indexPath.row == 2{
                super.moveToNextViewC(name: "Remaining", withIdentifier: OfferVC.className)
            }
                //            else if indexPath.row == 3{
                //
                //                let realm = try! Realm()
                //                if let userInfo = realm.objects(SignupDataModel.self).first{
                //                    if userInfo.id == ""{
                //                        _ = SweetAlert().showAlert(APP_NAME, subTitle: ConstantTexts.LoginRwq, style: AlertStyle.warning, buttonTitle:ConstantTexts.cancel, buttonColor: AppColor.themeColor , otherButtonTitle:  ConstantTexts.Ok,  otherButtonColor: AppColor.stepperColor) { (isOtherButton) -> Void in
                //                            if isOtherButton == true {
                //                                print("Cancel Button  Pressed", terminator: "")
                //                            }
                //                            else
                //                            {
                //                                super.moveToNextViewCViaRoot(name:"Auth",withIdentifier: LoginVC.className)
                //                            }
                //
                //                        }
                //                    }
                //                    else{
                //                        super.moveToNextViewC(name: "Remaining", withIdentifier: JustBiteCreditVC.className)
                //                    }
                //                }
                //                else{
                //                    _ = SweetAlert().showAlert(APP_NAME, subTitle: ConstantTexts.LoginRwq, style: AlertStyle.warning, buttonTitle:ConstantTexts.cancel, buttonColor: AppColor.themeColor , otherButtonTitle:  ConstantTexts.Ok,  otherButtonColor: AppColor.stepperColor) { (isOtherButton) -> Void in
                //                        if isOtherButton == true {
                //                            print("Cancel Button  Pressed", terminator: "")
                //                        }
                //                        else
                //                        {
                //                            super.moveToNextViewCViaRoot(name:"Auth",withIdentifier: LoginVC.className)
                //                        }
                //
                //                    }
                //                    print("do nothing")
                //                }
                //
                //            }
                //            else if indexPath.row == 3{
                //
                //                let realm = try! Realm()
                //                if let userInfo = realm.objects(SignupDataModel.self).first{
                //                    if userInfo.id == ""{
                //                        _ = SweetAlert().showAlert(APP_NAME, subTitle: ConstantTexts.LoginRwq, style: AlertStyle.warning, buttonTitle:ConstantTexts.cancel, buttonColor: AppColor.themeColor , otherButtonTitle:  ConstantTexts.Ok,  otherButtonColor: AppColor.stepperColor) { (isOtherButton) -> Void in
                //                            if isOtherButton == true {
                //                                print("Cancel Button  Pressed", terminator: "")
                //                            }
                //                            else
                //                            {
                //
                //                                super.moveToNextViewCViaRoot(name:"Auth",withIdentifier: LoginVC.className)
                //
                //                            }
                //
                //                        }
                //
                //                    }
                //                    else{
                //                        super.moveToNextViewC(name: "Remaining", withIdentifier: PaymentsVC.className)
                //                    }
                //                }
                //                else{
                //                    _ = SweetAlert().showAlert(APP_NAME, subTitle: ConstantTexts.LoginRwq, style: AlertStyle.warning, buttonTitle:ConstantTexts.cancel, buttonColor: AppColor.themeColor , otherButtonTitle:  ConstantTexts.Ok,  otherButtonColor: AppColor.stepperColor) { (isOtherButton) -> Void in
                //                        if isOtherButton == true {
                //                            print("Cancel Button  Pressed", terminator: "")
                //                        }
                //                        else
                //                        {
                //                            super.moveToNextViewCViaRoot(name:"Auth",withIdentifier: LoginVC.className)
                //                        }
                //
                //                    }
                //                    print("do nothing")
                //                }
                //
                //            }
                
            else if indexPath.row == 3{
                super.moveToNextViewC(name: "Remaining", withIdentifier: NotificationsViewController.className)
            }
                
            else if indexPath.row == 4{
                super.moveToNextViewC(name: "Auth", withIdentifier: SettingsVC.className)
            }
                /*   let realm = try! Realm()
                 if let userInfo = realm.objects(SignupDataModel.self).first{
                 if userInfo.id == ""{
                 _ = SweetAlert().showAlert(APP_NAME, subTitle: ConstantTexts.LoginRwq, style: AlertStyle.warning, buttonTitle:ConstantTexts.cancel, buttonColor: AppColor.themeColor , otherButtonTitle:  ConstantTexts.Ok,  otherButtonColor: AppColor.stepperColor) { (isOtherButton) -> Void in
                 if isOtherButton == true {
                 print("Cancel Button  Pressed", terminator: "")
                 }
                 else
                 {
                 super.moveToNextViewCViaRoot(name:"Auth",withIdentifier: LoginVC.className)
                 }
                 
                 }
                 }
                 else{
                 super.moveToNextViewC(name: "Auth", withIdentifier: SettingsVC.className)
                 }
                 }
                 else{
                 _ = SweetAlert().showAlert(APP_NAME, subTitle: ConstantTexts.LoginRwq, style: AlertStyle.warning, buttonTitle:ConstantTexts.cancel, buttonColor: AppColor.themeColor , otherButtonTitle:  ConstantTexts.Ok,  otherButtonColor: AppColor.stepperColor) { (isOtherButton) -> Void in
                 if isOtherButton == true {
                 print("Cancel Button  Pressed", terminator: "")
                 }
                 else
                 {
                 super.moveToNextViewCViaRoot(name:"Auth",withIdentifier: LoginVC.className)
                 }
                 
                 }
                 print("do nothing")
                 }*/
                
            else if indexPath.row == 5{
                _ = SweetAlert().showAlert(APP_NAME, subTitle: "Are you sure you want to share app..?", style: AlertStyle.warning, buttonTitle:ConstantTexts.cancel, buttonColor: AppColor.themeColor , otherButtonTitle:  ConstantTexts.Ok,  otherButtonColor: AppColor.stepperColor) { (isOtherButton) -> Void in
                    if isOtherButton == true {
                        print("Ok Button  Pressed")
                    }
                    else
                    {
                        print("Cancel Button  Pressed")
                    }
                }
                
            }else if indexPath.row == 6{
                let storyboard = UIStoryboard (name: "Remaining", bundle: nil)
                let resultVC = storyboard.instantiateViewController(withIdentifier: CustomerStoriesViewController.className)as! CustomerStoriesViewController
                // resultVC.comingFrom = "Stories"
                self.navigationController?.pushViewController(resultVC, animated: true)
                
            }
                
                
            else if indexPath.row == 7{
                let storyboard = UIStoryboard (name: "Remaining", bundle: nil)
                let resultVC = storyboard.instantiateViewController(withIdentifier: HelpAboutUsFaQT_CVC.className)as! HelpAboutUsFaQT_CVC
                resultVC.weblinks = "https://mobulous.app/justbiteweb/appview/aboutus.html"
                resultVC.comingFrom = "AboutUs"
                
                self.navigationController?.pushViewController(resultVC, animated: true)
                
            }
            else if indexPath.row == 8{
                
                let storyboard = UIStoryboard (name: "Remaining", bundle: nil)
                let resultVC = storyboard.instantiateViewController(withIdentifier: HelpAboutUsFaQT_CVC.className)as! HelpAboutUsFaQT_CVC
                resultVC.weblinks = "https://mobulous.app/justbiteweb/appview/termscondition.html"
                resultVC.comingFrom = "Terms"
                self.navigationController?.pushViewController(resultVC, animated: true)
            }
            else if indexPath.row == 9{
                super.moveToNextViewC(name: "Remaining", withIdentifier: ContactUsVC.className)
            }
            else if indexPath.row == 10{
                let storyboard = UIStoryboard (name: "Remaining", bundle: nil)
                let resultVC = storyboard.instantiateViewController(withIdentifier: HelpAboutUsFaQT_CVC.className)as! HelpAboutUsFaQT_CVC
                resultVC.weblinks = "https://mobulous.app/justbiteweb/appview/privacy.html"
                resultVC.comingFrom = "FAQ"
                self.navigationController?.pushViewController(resultVC, animated: true)
            }
            else{
                let storyboard = UIStoryboard (name: "Remaining", bundle: nil)
                let resultVC = storyboard.instantiateViewController(withIdentifier: HelpAboutUsFaQT_CVC.className)as! HelpAboutUsFaQT_CVC
                resultVC.weblinks = "https://mobulous.app/justbiteweb/appview/help.html"
                resultVC.comingFrom = "Help"
                self.navigationController?.pushViewController(resultVC, animated: true)
            }
            kAppDelegate.drawerController?.setDrawerState(.closed, animated: true)
        }else{
            print("Bhag yaha se")
        }
        
    }
    
}

extension DrawerControllerVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataStore.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: DrawerTableViewCellAndXib.className, for: indexPath) as? DrawerTableViewCellAndXib else {
            fatalError(ConstantTexts.unexpectedIndexPath)
        }
        GlobalCustomMethods.shared.provideCustomCornarRadius(btnRef: cell.lblMoney, radius: 5)
        cell.configureCellWith(info:dataStore[indexPath.row])
        return cell
    }
    
    //    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
    //
    //
    //        let footer:DrawerFooter = Bundle.main.loadNibNamed("DrawerFooter", owner: self, options: nil)!.last! as! DrawerFooter
    //
    //
    //        footer.btnLoginRef.titleLabel?.font = AppFont.Regular.size(AppFontName.SourceSansPro, size: 17)
    //        footer.btnLoginRef.setTitleColor(AppColor.whiteColor, for: .normal)
    //        footer.btnLoginRef.setTitle("Login", for: .normal)
    //        footer.btnLoginRef.backgroundColor = AppColor.themeColor
    //
    //        footer.btnLoginRef.addTarget(self, action: #selector(self.tapSectionBtn(sender:)), for: UIControl.Event.touchUpInside)
    //
    //        GlobalCustomMethods.shared.provideCustomCornarRadius(btnRef: footer.btnLoginRef, radius: 5)
    //
    //        let realm = try! Realm()
    //        if let userInfo = realm.objects(SignupDataModel.self).first{
    //            if userInfo.access_token != ""{
    //                footer.btnLoginRef.isHidden = true
    //
    //
    //            }
    //            else{
    //                footer.btnLoginRef.isHidden = false
    //            }
    //        }
    //        else{
    //
    //            footer.btnLoginRef.isHidden = true
    //
    //        }
    //
    //        return footer
    //
    //
    //    }
    //
    //    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
    //
    //        return 80
    //
    //
    //    }
    //
    
}


