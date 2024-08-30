//
//  LanguageSelectionCustomMethodsExtension.swift
//  JustBite
//
//  Created by Aman on 12/05/19.
//  Copyright © 2019 Mobulous. All rights reserved.
//

import Foundation
import UIKit

extension LanguageSelectionVC{
    //TODO: Initial Setup
   internal func initialStup(){
    
        GlobalCustomMethods.shared.provideCustomCornarRadius(btnRef: self.viewMain, radius: 5)
        viewLine.backgroundColor = AppColor.placeHolderColor
        btnNextRef.setTitleColor(AppColor.themeColor, for: .normal)
        lblHeader.font = AppFont.Semibold.size(AppFontName.SourceSansPro, size: 17)
    AccessCurrentLocationuser()
    }
}
