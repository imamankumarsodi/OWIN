//
//  NewFilterExtensionMethods.swift
//  JustBite
//
//  Created by Deepti Sharma on 04/02/20.
//  Copyright © 2020 Mobulous. All rights reserved.
//

import Foundation
import UIKit
import  RealmSwift
extension NewFilterVCAman{
    
    //TODO: Navigation setup
    
    internal func navigationSetUpView() {
        preferredStatusBarStyle
        super.transparentNavigation()
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
        super.addColorToNavigationBarAndSafeArea(color: gradientLayer, className: NewFilterVCAman.className)
        super.setupNavigationBarTitle("Filters", leftBarButtonsType: [.back], rightBarButtonsType: [])
        
    }
    
  
    
   
}
