//
//  MenuItemsCustomMethodsExtension.swift
//  JustBite
//
//  Created by Aman on 14/05/19.
//  Copyright © 2019 Mobulous. All rights reserved.
//

import Foundation
import UIKit

extension MenuItemsVC{
    //TODO: Initial Setup
    internal func initialStup(){
        topConstraint.constant = MAIN_SCREEN_HEIGHT/2
        GlobalCustomMethods.shared.provideCustomCornarRadius(btnRef: self.viewMain, radius: 5)
        lblHeader.font = AppFont.Semibold.size(AppFontName.SourceSansPro, size: 17)
        registerNib()
    }
    
    
    //TODO: Register Nib method
    fileprivate func registerNib(){
        self.tblAddOns.register(nib: MenuItemTableViewCell.className)
    }
    
    
    //TODO: Method didScroll
    
    internal func didScrollScrollView(offset: CGFloat){
        let diff = previousOffset - offset
        previousOffset = offset
        
        var newHeight = topConstraint.constant + diff
        print(newHeight)
        
        let kBarHeight:CGFloat = GlobalCustomMethods.shared.getKbarHeight()
        
        if newHeight < kBarHeight {
            newHeight = kBarHeight
        } else if newHeight > MAIN_SCREEN_HEIGHT/2 { // or whatever
            newHeight = MAIN_SCREEN_HEIGHT/2
        }
            //For show hide image profile
        else if newHeight > kBarHeight{
            
            
        }
        topConstraint.constant = newHeight
    }
}
