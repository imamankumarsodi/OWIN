//
//  VarificationCustomMethodsExtensions.swift
//  JustBite
//
//  Created by Aman on 07/05/19.
//  Copyright © 2019 Mobulous. All rights reserved.
//

import Foundation
import UIKit

extension VarificationVC{
    
    //TODO: Initial Setup
    
    internal func initialSetup(){
        updateUI()
    }
    
    //TODO: Update UI
    
    fileprivate func updateUI(){
        ScreeNNameClass.shareScreenInstance.screenName = VarificationVC.className
        lblTitle.attributedText = GlobalCustomMethods.shared.attributedStringForgotPassword(title: "Enter OTP", subTitle: "We have send you access code\nVia SMS for mobile number verification.", delemit: "\n", sizeTitle: 24, sizeSubtitle: 18, titleColor: AppColor.textColor, SubtitleColor: AppColor.textColor)
        
        lblFooter.attributedText = GlobalCustomMethods.shared.attributedStringOTP(title: "Didn't Recieve the OTP?", subTitle: "Resend OTP", delemit: "\n", sizeTitle: 18, sizeSubtitle: 18, titleColor: AppColor.textColor, SubtitleColor: AppColor.themeColor)
        GlobalCustomMethods.shared.setupSubmitBtn(btnRef: self.btnSubmit, title: String())
        hideKeyboardWhenTappedAround()
        

        otpView.otpFieldsCount = 6
        otpView.otpFieldDefaultBorderColor = AppColor.placeHolderColor
        otpView.otpFieldEnteredBorderColor = AppColor.placeHolderColor
        otpView.otpFieldErrorBorderColor = AppColor.placeHolderColor
        otpView.otpFieldBorderWidth = 1
        otpView.delegate = self
        otpView.shouldAllowIntermediateEditing = false
        
        
        // Create the UI
        otpView.initalizeUI()
        
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.tapFunction))
        lblFooter.isUserInteractionEnabled = true
        lblFooter.addGestureRecognizer(tap)
        
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
        
        super.addColorToNavigationBarAndSafeArea(color: gradientLayer, className: VarificationVC.className)
        super.setupNavigationBarTitle("Verification", leftBarButtonsType: [.back], rightBarButtonsType: [])
    }
    
}
