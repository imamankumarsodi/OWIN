//
//  TopUpCustomMethodExtension.swift
//  JustBite
//
//  Created by Aman on 16/05/19.
//  Copyright © 2019 Mobulous. All rights reserved.
//

import Foundation
import UIKit

extension TopUpOffersVC{
    
    //TODO: Initial Setup
    
    internal func initialSetup(){
        updateUI()
    }
    
    //TODO: Update UI
    
    fileprivate func updateUI(){
        hideKeyboardWhenTappedAround()
        registerNib()
        self.tblAddOns.addSubview(self.refreshControl)
        self.tblAddOns.tableFooterView = UIView()
        topuplist()
        
    }
    
    //TODO: Navigation setup
    
    internal func navigationSetup(){
        preferredStatusBarStyle
        super.hideNavigationBar(false)
        let colorTop =  UIColor(red: 152.0/255.0, green: 24.0/255.0, blue: 37.0/255.0, alpha: 0.8).cgColor
        
        let colorMid = UIColor(red: 254.0/255.0, green: 116.0/255.0, blue: 47.0/255.0, alpha: 0.8).cgColor
        let colorMid1 = UIColor(red: 255.0/255.0, green: 201.0/255.0, blue: 75.0/255.0, alpha: 0.8).cgColor
        let colorBottom = UIColor(red: 119.0/255.0, green: 180.0/255.0, blue: 87.0/255.0, alpha: 0.8).cgColor
        
        gradientLayer.colors = [colorTop,colorMid,colorMid1,colorBottom]
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.4)
        gradientLayer.endPoint = CGPoint(x: 0.8, y: 0.4)
        
        
        gradientLayer.frame = self.GradinetView.bounds
        
        self.GradinetView.layer.insertSublayer(gradientLayer, at:0)
        super.addColorToNavigationBarAndSafeArea(color: gradientLayer, className: TopUpOffersVC.className)
        super.setupNavigationBarTitle("Top-up offers", leftBarButtonsType: [.back], rightBarButtonsType: [])
        GlobalCustomMethods.shared.setupSubmitBtn(btnRef:self.btnLoginRef, title: "Proceed to Chekout")

    }
    
    //TODO: Register Nib method
    fileprivate func registerNib(){
        self.tblAddOns.register(nib: TopUpOfferTableViewCell.className)
    }
    
}
