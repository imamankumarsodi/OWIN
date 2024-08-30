//
//  AppFonts.swift
//  JustBite
//
//  Created by Aman on 04/05/19.
//  Copyright © 2019 Mobulous. All rights reserved.
//

import Foundation
import UIKit

enum AppFontName: String{
    case SourceSansPro     = "SourceSansPro"
}


enum AppFont:String{
    case BlackIt           = "BlackIt"
    case SemiboldIt        = "SemiboldIt"
    case LightIt           = "LightIt"
    case BoldIt            = "BoldIt"
    case Light             = "Light"
    case ExtraLightIt      = "ExtraLightIt"
    case Regular           = "Regular"
    case It                = "It"
    case ExtraLight        = "ExtraLight"
    case Bold              = "Bold"
    case Semibold          = "Semibold"
    case Black             = "Black"
    
    func size(_ name: AppFontName,size:CGFloat) -> UIFont{
        if let font = UIFont(name: self.fullFontName(name.rawValue), size: size + 1.0){
            return font
        }
        fatalError("Font '\(fullFontName)' does not exist.")
    }
    
    fileprivate func fullFontName(_ fontName:String)->String{
        return rawValue.isEmpty ? fontName : fontName + "-" + rawValue
    }
}



import UIKit

struct staticAppFont {
    //MARK: - Constant fonts
    public static let textFieldsFonts  = AppFont.Regular.size(AppFontName.SourceSansPro, size: 17)
}
