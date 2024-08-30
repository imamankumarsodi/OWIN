//
//  RestaurentFilterPopVCMethodsExtension.swift
//  JustBite
//
//  Created by Aman on 15/05/19.
//  Copyright © 2019 Mobulous. All rights reserved.
//

import Foundation
import UIKit

extension RestaurentFilterPopVC{
    //TODO: Initial Setup
    internal func initialStup(){
        
        GlobalCustomMethods.shared.provideCustomCornarRadius(btnRef: self.viewMain, radius: 5)
        viewLine.backgroundColor = AppColor.placeHolderColor
        viewHeader.backgroundColor = AppColor.themeColor
        
        lblHeader.font = AppFont.Semibold.size(AppFontName.SourceSansPro, size: 17)
        lblHeader.text = "Filter"
        
        lblPriceTitle.font = AppFont.Regular.size(AppFontName.SourceSansPro, size: 17)
        lblPriceTitle.textColor = AppColor.textColor
        
        lblPriceValue.font = AppFont.Regular.size(AppFontName.SourceSansPro, size: 17)
        lblPriceValue.textColor = AppColor.themeColor
        
        self.btnCancelRef.setTitle("Cancel", for: .normal)
        self.btnDoneRef.setTitle("Apply", for: .normal)
       
        self.btnCancelRef.setTitleColor(AppColor.placeHolderColor, for: .normal)
        self.btnDoneRef.setTitleColor(AppColor.themeColor, for: .normal)
        
        sliderRef.minimumTrackTintColor = AppColor.themeColor
        sliderRef.maximumTrackTintColor = AppColor.placeHolderColor
        sliderRef.maximumValue = 10000
        
    }
}
