//
//  JustBiteCreditCustomMethodExtension.swift
//  JustBite
//
//  Created by Aman on 19/05/19.
//  Copyright © 2019 Mobulous. All rights reserved.
//

import Foundation
import UIKit
import RealmSwift

//MARK: - Extension Custom methods
extension JustBiteCreditVC{
    
    //TODO: Initial setup
    internal func initialSetup(){
        updateUI()
    }
    
    //TODO: Update UI
    fileprivate func updateUI(){
        super.hideNavigationBar(false)
        hideKeyboardWhenTappedAround()
        
        btnHeaderRef.titleLabel?.font = AppFont.Regular.size(AppFontName.SourceSansPro, size: 30)
        btnHeaderRef.backgroundColor = UIColor.clear
        btnHeaderRef.setTitleColor(AppColor.textColor, for: .normal)
        let realm = try! Realm()
        if let userInfo = realm.objects(SignupDataModel.self).first{
              btnHeaderRef.setTitle("  AED \(userInfo.wallet)", for: .normal)
        }
      
        
        lblTitle.font = AppFont.Regular.size(AppFontName.SourceSansPro, size: 15)
        lblTitle.textColor = AppColor.placeHolderColor
        lblTitle.text = "Available Credits"
        lblTitle.backgroundColor = UIColor.clear
        
        btnViewAllRef.backgroundColor = UIColor.clear
        btnViewAllRef.setAttributedTitle(GlobalCustomMethods.shared.attributedStringForUnderLine(title: "View Statement", sizeTitle: 15, titleColor: AppColor.themeColor), for: .normal)
        
        
        GlobalCustomMethods.shared.setupSubmitBtn(btnRef:self.btnLoginRef, title: "Top Up Credit")
        
        
    }
    
    
    //TODO: Navigation setup
    
    internal func navigationSetUpView() {
        preferredStatusBarStyle
        super.setupNavigationBarTitle("Payment Mode", leftBarButtonsType: [.back], rightBarButtonsType: [])
        let colorTop =  UIColor(red: 152.0/255.0, green: 24.0/255.0, blue: 37.0/255.0, alpha: 0.8).cgColor
        
        let colorMid = UIColor(red: 254.0/255.0, green: 116.0/255.0, blue: 47.0/255.0, alpha: 0.8).cgColor
        let colorMid1 = UIColor(red: 255.0/255.0, green: 201.0/255.0, blue: 75.0/255.0, alpha: 0.8).cgColor
        let colorBottom = UIColor(red: 119.0/255.0, green: 180.0/255.0, blue: 87.0/255.0, alpha: 0.8).cgColor
        
        gradientLayer.colors = [colorTop,colorMid,colorMid1,colorBottom]
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.4)
        gradientLayer.endPoint = CGPoint(x: 0.8, y: 0.4)
        
        
        gradientLayer.frame = self.GradinetView.bounds
        
        self.GradinetView.layer.insertSublayer(gradientLayer, at:0)
        super.addColorToNavigationBarAndSafeArea(color: gradientLayer, className: JustBiteCreditVC.className)
        super.transparentNavigation()
        super.hideNavigationBar(false)
        updateUI()
        
    }
    
    
    
    
}
