//
//  cartExtensionMethods.swift
//  JustBite
//
//  Created by cst on 03/02/20.
//  Copyright © 2020 Mobulous. All rights reserved.
//

import Foundation
import UIKit

extension cartViewController{
    //TODO: Navigation Setup..
    internal  func navigationSetUp(){
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
        
        super.addColorToNavigationBarAndSafeArea(color: gradientLayer,className:cartViewController.className)
        
        super.setupNavigationBarTitle("My Cart", leftBarButtonsType: [.back], rightBarButtonsType: [])
    }
    
    //TODO: Initial Setup..
    func initialSetUp(){
        registerNib()
    }
    
    //TODO: Register Nib method
    fileprivate func registerNib(){
        self.tblView.register(nib: CartTableViewCellAndXib.className)
    }
}


extension cartViewController:UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
}

