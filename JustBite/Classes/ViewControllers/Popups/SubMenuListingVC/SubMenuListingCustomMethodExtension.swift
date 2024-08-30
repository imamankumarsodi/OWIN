//
//  SubMenuListingCustomMethodExtension.swift
//  JustBite
//
//  Created by Aman on 14/05/19.
//  Copyright © 2019 Mobulous. All rights reserved.
//

import Foundation
import UIKit

extension SubMenuListingVC{
    //TODO: Initial Setup
    internal func initialStup(){
        self.tblAddOns.tableFooterView = UIView()
        self.tblAddOns.backgroundColor = AppColor.whiteColor
        topConstraint.constant = MAIN_SCREEN_HEIGHT/2
        GlobalCustomMethods.shared.provideCustomCornarRadius(btnRef: self.viewMain, radius: 5)
        lblHeader.font = AppFont.Semibold.size(AppFontName.SourceSansPro, size: 15)
        btnTotal.attributedText = GlobalCustomMethods.shared.attributedString(title: "Total", subTitle: "AED \(0)", delemit: "   ", sizeTitle: 14, sizeSubtitle: 17, titleColor: AppColor.textColor, SubtitleColor: AppColor.whiteColor)
        viewFooter.backgroundColor = AppColor.stepperColor
        GlobalCustomMethods.shared.provideCornarRadius(btnRef: viewFooter)
        GlobalCustomMethods.shared.provideShadow(btnRef: viewFooter)
        registerNib()
    }
    
    
    //TODO: Register Nib method
    fileprivate func registerNib(){
        
        self.tblAddOns.register(nib: ChooseYorTasteTableViewCell.className)
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
    
    
    internal func assignValueForSum(){
        var sum = Int()
        var adOnArry = [String]()
        for item in customizeDataModelArray{
                for addOnItem in item.addons{
                    if addOnItem.isSelected{
                       sum += addOnItem.price
                        adOnArry.append(String(addOnItem.id))
                    }
                }
            
        }
        btnTotal.attributedText = GlobalCustomMethods.shared.attributedString(title: "Total", subTitle: "AED \(sum)", delemit: "   ", sizeTitle: 14, sizeSubtitle: 17, titleColor: AppColor.textColor, SubtitleColor: AppColor.whiteColor)
    }
    
    
    internal func saveTapped(index:Int){
        
        
        if addOnArray.count > 0{
            addOnArray.removeAll()
        }
        if index == 1{

            if isComing == "CART"{

                for item in customizeDataModelArray{
                    for addOnItem in item.addons{
                        if addOnItem.isSelected{
                            totalPrice += addOnItem.price
                            addOnArray.append(String(addOnItem.id))
                        }
                    }
                    
                }
                if totalPrice == 0{
                    totalPrice = price
                }

                addOnString = addOnArray.joined(separator: ",")
                print(addOnString)
                backObjC?.sendDataBack(index:self.index,price:Double(totalPrice),addon:addOnString, isNewOrder: self.isNewOrder)
                print(addOnString)
                self.dismiss(animated: true, completion: nil)
            }else{
                
                
                for item in customizeDataModelArray{
                    for addOnItem in item.addons{
                        if addOnItem.isSelected{
                            totalPrice += addOnItem.price
                            addOnArray.append(String(addOnItem.id))
                        }
                    }
                    
                }
                
                if totalPrice == 0{
                    totalPrice = price
                }

                addOnArray.sort()
                addOnString = addOnArray.joined(separator: ",")
                print(addOnString)
                backObj?.sendDataBack(index:self.index,price:Double(totalPrice),addon:self.addOnString, isNewOrder: self.isNewOrder, userType: userType, catIndex: self.catIndex)
                self.dismiss(animated: true, completion: nil)
            }

        }else{
            self.dismiss(animated: true, completion: nil)
        }
        
    }
    
    
}

