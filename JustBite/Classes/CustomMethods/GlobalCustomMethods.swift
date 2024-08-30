//
//  GlobalCustomMethods.swift
//  JustBite
//
//  Created by Aman on 04/05/19.
//  Copyright © 2019 Mobulous. All rights reserved.
//

import Foundation
import UIKit
import SystemConfiguration

class GlobalCustomMethods{
    
    static let shared = GlobalCustomMethods()
    
    //MARK: - Methods for attributed texts
    //TODO: For Login Header
    
    func attributedString(title:String,subTitle:String,delemit:String,sizeTitle:CGFloat,sizeSubtitle:CGFloat,titleColor:UIColor,SubtitleColor:UIColor) -> NSMutableAttributedString{
        let myMutableString = NSMutableAttributedString()
        
        
        let myMutableString1 = NSAttributedString(string: "\(title)\(delemit)", attributes:[.font:AppFont.Regular.size(AppFontName.SourceSansPro, size: sizeTitle), .foregroundColor :titleColor])
        
        let myMutableString2 = NSAttributedString(string: "\(subTitle)", attributes:[.font:AppFont.Semibold.size(AppFontName.SourceSansPro, size: sizeSubtitle), .foregroundColor :SubtitleColor])
        
        myMutableString.append(myMutableString1)
        myMutableString.append(myMutableString2)

        // *** Create instance of `NSMutableParagraphStyle`
        let paragraphStyle = NSMutableParagraphStyle()
        
        // *** set LineSpacing property in points ***
        paragraphStyle.lineSpacing = 5 // Whatever line spacing you want in points
        
        // *** Apply attribute to string ***
        myMutableString.addAttribute(NSAttributedString.Key.paragraphStyle, value:paragraphStyle, range:NSMakeRange(0, myMutableString.length))
        
        return myMutableString
    }

    
    func attributedStringPopUP(title:String,subTitle:String,subTitle2:String,delemit:String,sizeTitle:CGFloat,sizeSubtitle:CGFloat,titleColor:UIColor,SubtitleColor:UIColor) -> NSMutableAttributedString{
        let myMutableString = NSMutableAttributedString()
        
        
        let myMutableString1 = NSAttributedString(string: "\(title)\(delemit)", attributes:[.font:AppFont.Regular.size(AppFontName.SourceSansPro, size: sizeTitle), .foregroundColor :titleColor])
        
        let myMutableString2 = NSAttributedString(string: "\(subTitle)", attributes:[.font:AppFont.Bold.size(AppFontName.SourceSansPro, size: sizeSubtitle), .foregroundColor :SubtitleColor])
        
        let myMutableString3 = NSAttributedString(string: "\(subTitle2)", attributes:[.font:AppFont.Regular.size(AppFontName.SourceSansPro, size: sizeTitle), .foregroundColor :titleColor])
        
        myMutableString.append(myMutableString1)
        myMutableString.append(myMutableString2)
        myMutableString.append(myMutableString3)
        
        
        // *** Create instance of `NSMutableParagraphStyle`
        let paragraphStyle = NSMutableParagraphStyle()
        
        // *** set LineSpacing property in points ***
        paragraphStyle.lineSpacing = 5 // Whatever line spacing you want in points
        
        // *** Apply attribute to string ***
        myMutableString.addAttribute(NSAttributedString.Key.paragraphStyle, value:paragraphStyle, range:NSMakeRange(0, myMutableString.length))
        
        return myMutableString
    }
    
    
    func attributedStringOffer(title:String,subTitle:String,subTitle2:String,delemit:String,sizeTitle:CGFloat,sizeSubtitle2:CGFloat,sizeSubtitle:CGFloat,titleColor:UIColor,SubtitleColor:UIColor,SubtitleColor2:UIColor) -> NSMutableAttributedString{
        let myMutableString = NSMutableAttributedString()
        
        
        if title == ""{
          let myMutableString1 = NSAttributedString(string: "\(title)", attributes:[.font:AppFont.Regular.size(AppFontName.SourceSansPro, size: sizeTitle), .foregroundColor :titleColor])
            let myMutableString2 = NSAttributedString(string: "\(subTitle)\(delemit)", attributes:[.font:AppFont.Bold.size(AppFontName.SourceSansPro, size: sizeSubtitle), .foregroundColor :SubtitleColor])
            
            let myMutableString3 = NSAttributedString(string: "\(subTitle2)", attributes:[.font:AppFont.Regular.size(AppFontName.SourceSansPro, size: sizeSubtitle2), .foregroundColor :SubtitleColor2])
            
            myMutableString.append(myMutableString1)
            myMutableString.append(myMutableString2)
            myMutableString.append(myMutableString3)
            
            
            // *** Create instance of `NSMutableParagraphStyle`
            let paragraphStyle = NSMutableParagraphStyle()
            
            // *** set LineSpacing property in points ***
            paragraphStyle.lineSpacing = 5 // Whatever line spacing you want in points
            
            // *** Apply attribute to string ***
            myMutableString.addAttribute(NSAttributedString.Key.paragraphStyle, value:paragraphStyle, range:NSMakeRange(0, myMutableString.length))
            
            return myMutableString
        }else{
             let myMutableString1 = NSAttributedString(string: "\(title)\(delemit)", attributes:[.font:AppFont.Regular.size(AppFontName.SourceSansPro, size: sizeTitle), .foregroundColor :titleColor])
            let myMutableString2 = NSAttributedString(string: "\(subTitle)\(delemit)", attributes:[.font:AppFont.Bold.size(AppFontName.SourceSansPro, size: sizeSubtitle), .foregroundColor :SubtitleColor])
            
            let myMutableString3 = NSAttributedString(string: "\(subTitle2)", attributes:[.font:AppFont.Regular.size(AppFontName.SourceSansPro, size: sizeSubtitle2), .foregroundColor :SubtitleColor2])
            
            myMutableString.append(myMutableString1)
            myMutableString.append(myMutableString2)
            myMutableString.append(myMutableString3)
            
            
            // *** Create instance of `NSMutableParagraphStyle`
            let paragraphStyle = NSMutableParagraphStyle()
            
            // *** set LineSpacing property in points ***
            paragraphStyle.lineSpacing = 5 // Whatever line spacing you want in points
            
            // *** Apply attribute to string ***
            myMutableString.addAttribute(NSAttributedString.Key.paragraphStyle, value:paragraphStyle, range:NSMakeRange(0, myMutableString.length))
            
            return myMutableString
        }
        

    }
    
    
    //TODO: For Login Header
    
    func attributedStringForUnderLine(title:String,sizeTitle:CGFloat,titleColor:UIColor) -> NSMutableAttributedString{
        let myMutableString = NSMutableAttributedString()
        
        
        let myMutableString1 = NSAttributedString(string: "\(title)", attributes:[.font:AppFont.Regular.size(AppFontName.SourceSansPro, size: sizeTitle), .foregroundColor :titleColor,NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue])
        
       
        
        myMutableString.append(myMutableString1)
        
        
        // *** Create instance of `NSMutableParagraphStyle`
        let paragraphStyle = NSMutableParagraphStyle()
        
        // *** set LineSpacing property in points ***
        paragraphStyle.lineSpacing = 5 // Whatever line spacing you want in points
        
        // *** Apply attribute to string ***
        myMutableString.addAttribute(NSAttributedString.Key.paragraphStyle, value:paragraphStyle, range:NSMakeRange(0, myMutableString.length))
        
        return myMutableString
    }

    
    
    
    //TODO: For Login footer
    func attributedStringFooter(title:String,subTitle:String,delemit:String,sizeTitle:CGFloat,sizeSubtitle:CGFloat,titleColor:UIColor,SubtitleColor:UIColor) -> NSMutableAttributedString{
        let myMutableString = NSMutableAttributedString()
        
        
        let myMutableString1 = NSAttributedString(string: "\(title)\(delemit)", attributes:[.font:AppFont.It.size(AppFontName.SourceSansPro, size: sizeTitle), .foregroundColor :titleColor])
        
        let myMutableString2 = NSAttributedString(string: "\(subTitle)", attributes:[.font:AppFont.Regular.size(AppFontName.SourceSansPro, size: sizeSubtitle), .foregroundColor :SubtitleColor])
        
        myMutableString.append(myMutableString1)
        myMutableString.append(myMutableString2)
        
        // *** Create instance of `NSMutableParagraphStyle`
        let paragraphStyle = NSMutableParagraphStyle()
        
        // *** set LineSpacing property in points ***
        paragraphStyle.lineSpacing = 5 // Whatever line spacing you want in points
        
        // *** Apply attribute to string ***
        myMutableString.addAttribute(NSAttributedString.Key.paragraphStyle, value:paragraphStyle, range:NSMakeRange(0, myMutableString.length))
        
        return myMutableString
    }
    
    
    
    //TODO: Forgot password header
    
    func attributedStringForgotPassword(title:String,subTitle:String,delemit:String,sizeTitle:CGFloat,sizeSubtitle:CGFloat,titleColor:UIColor,SubtitleColor:UIColor) -> NSMutableAttributedString{
        let myMutableString = NSMutableAttributedString()
        
        
        let myMutableString1 = NSAttributedString(string: "\(title)\(delemit)\(delemit)", attributes:[.font:AppFont.Semibold.size(AppFontName.SourceSansPro, size: sizeTitle), .foregroundColor :titleColor])
        
        let myMutableString2 = NSAttributedString(string: "\(subTitle)", attributes:[.font:AppFont.Regular.size(AppFontName.SourceSansPro, size: sizeSubtitle), .foregroundColor :SubtitleColor])
        
        myMutableString.append(myMutableString1)
        myMutableString.append(myMutableString2)
        
        // *** Create instance of `NSMutableParagraphStyle`
        let paragraphStyle = NSMutableParagraphStyle()
        
        paragraphStyle.alignment = .center
        
        // *** set LineSpacing property in points ***
        paragraphStyle.lineSpacing = 3 // Whatever line spacing you want in points
        
        // *** Apply attribute to string ***
        myMutableString.addAttribute(NSAttributedString.Key.paragraphStyle, value:paragraphStyle, range:NSMakeRange(0, myMutableString.length))
        
        return myMutableString
    }
    
    
    func attributedStringOnGing(title:String,subTitle:String,delemit:String,sizeTitle:CGFloat,sizeSubtitle:CGFloat,titleColor:UIColor,SubtitleColor:UIColor) -> NSMutableAttributedString{
        let myMutableString = NSMutableAttributedString()
        
        
        let myMutableString1 = NSAttributedString(string: "\(title)\(delemit)", attributes:[.font:AppFont.Regular.size(AppFontName.SourceSansPro, size: sizeTitle), .foregroundColor :titleColor])
        
        let myMutableString2 = NSAttributedString(string: "\(subTitle)", attributes:[.font:AppFont.Regular.size(AppFontName.SourceSansPro, size: sizeSubtitle), .foregroundColor :SubtitleColor])
        
        myMutableString.append(myMutableString1)
        myMutableString.append(myMutableString2)
        
        // *** Create instance of `NSMutableParagraphStyle`
        let paragraphStyle = NSMutableParagraphStyle()
        
        paragraphStyle.alignment = .left
        
        // *** set LineSpacing property in points ***
        paragraphStyle.lineSpacing = 3 // Whatever line spacing you want in points
        
        // *** Apply attribute to string ***
        myMutableString.addAttribute(NSAttributedString.Key.paragraphStyle, value:paragraphStyle, range:NSMakeRange(0, myMutableString.length))
        
        return myMutableString
    }
    
    func attributedStringOnGing2(title:String,subTitle:String,delemit:String,sizeTitle:CGFloat,sizeSubtitle:CGFloat,titleColor:UIColor,SubtitleColor:UIColor) -> NSMutableAttributedString{
        let myMutableString = NSMutableAttributedString()
        
        
        let myMutableString1 = NSAttributedString(string: "\(title)\(delemit)", attributes:[.font:AppFont.Regular.size(AppFontName.SourceSansPro, size: sizeTitle), .foregroundColor :titleColor])
        
        let myMutableString2 = NSAttributedString(string: "\(subTitle)", attributes:[.font:AppFont.Regular.size(AppFontName.SourceSansPro, size: sizeSubtitle), .foregroundColor :SubtitleColor])
        
        myMutableString.append(myMutableString1)
        myMutableString.append(myMutableString2)
        
        // *** Create instance of `NSMutableParagraphStyle`
        let paragraphStyle = NSMutableParagraphStyle()
        
        paragraphStyle.alignment = .left
        
        // *** set LineSpacing property in points ***
        paragraphStyle.lineSpacing = 3 // Whatever line spacing you want in points
        
        // *** Apply attribute to string ***
        myMutableString.addAttribute(NSAttributedString.Key.paragraphStyle, value:paragraphStyle, range:NSMakeRange(0, myMutableString.length))
        
        return myMutableString
    }
    
    
    func attributedStringOnGing1(title:String,subTitle:String,delemit:String,sizeTitle:CGFloat,sizeSubtitle:CGFloat,titleColor:UIColor,SubtitleColor:UIColor) -> NSMutableAttributedString{
        let myMutableString = NSMutableAttributedString()
        
        
        let myMutableString1 = NSAttributedString(string: "\(title)", attributes:[.font:AppFont.Regular.size(AppFontName.SourceSansPro, size: sizeTitle), .foregroundColor :titleColor])
        
        let myMutableString2 = NSAttributedString(string: "\(subTitle)", attributes:[.font:AppFont.Regular.size(AppFontName.SourceSansPro, size: sizeSubtitle), .foregroundColor :SubtitleColor])
        
        myMutableString.append(myMutableString1)
        myMutableString.append(myMutableString2)
        
        // *** Create instance of `NSMutableParagraphStyle`
        let paragraphStyle = NSMutableParagraphStyle()
        
        paragraphStyle.alignment = .left
        
        // *** set LineSpacing property in points ***
        paragraphStyle.lineSpacing = 3 // Whatever line spacing you want in points
        
        // *** Apply attribute to string ***
        myMutableString.addAttribute(NSAttributedString.Key.paragraphStyle, value:paragraphStyle, range:NSMakeRange(0, myMutableString.length))
        
        return myMutableString
    }
    
    
    
    //TODO: OTP footer
    
    func attributedStringOTP(title:String,subTitle:String,delemit:String,sizeTitle:CGFloat,sizeSubtitle:CGFloat,titleColor:UIColor,SubtitleColor:UIColor) -> NSMutableAttributedString{
        let myMutableString = NSMutableAttributedString()
        
        
        let myMutableString1 = NSAttributedString(string: "\(title)\(delemit)\(delemit)", attributes:[.font:AppFont.Regular.size(AppFontName.SourceSansPro, size: sizeTitle), .foregroundColor :titleColor])
        
        let myMutableString2 = NSAttributedString(string: "\(subTitle)", attributes:[.font:AppFont.Regular.size(AppFontName.SourceSansPro, size: sizeSubtitle), .foregroundColor :SubtitleColor])
        
        myMutableString.append(myMutableString1)
        myMutableString.append(myMutableString2)
        
        // *** Create instance of `NSMutableParagraphStyle`
        let paragraphStyle = NSMutableParagraphStyle()
        
        paragraphStyle.alignment = .center
        
        // *** set LineSpacing property in points ***
        paragraphStyle.lineSpacing = 2 // Whatever line spacing you want in points
        
        // *** Apply attribute to string ***
        myMutableString.addAttribute(NSAttributedString.Key.paragraphStyle, value:paragraphStyle, range:NSMakeRange(0, myMutableString.length))
        
        return myMutableString
    }
    
    
    //TODO: Update Home table view cell label
    
    func updateHomeTableViewCellLabel(title:String,cusineArray:[String],address:String,delemit:String)->NSMutableAttributedString{
        let myMutableString = NSMutableAttributedString()
        
        let myMutableString1 = NSAttributedString(string: "\(title)\(delemit)", attributes:[.font:AppFont.Semibold.size(AppFontName.SourceSansPro, size: 17), .foregroundColor :AppColor.textColor])
        
        
        let ineterPunctStr = NSAttributedString(string: " · ", attributes:[.font:AppFont.Regular.size(AppFontName.SourceSansPro, size: 30), .foregroundColor :AppColor.placeHolderColor])
        
        let interPunctJointString = cusineArray.joined(separator: ineterPunctStr.string)
       
        let myMutableString2 = NSAttributedString(string: "\(interPunctJointString)\(delemit)", attributes:[.font:AppFont.Regular.size(AppFontName.SourceSansPro, size: 14), .foregroundColor :AppColor.placeHolderColor])
        
        let myMutableString3 = NSAttributedString(string: "\(address)", attributes:[.font:AppFont.Regular.size(AppFontName.SourceSansPro, size: 14), .foregroundColor :AppColor.subtitleColor])
        
        
        myMutableString.append(myMutableString1)
        myMutableString.append(myMutableString2)
        myMutableString.append(myMutableString3)
        
        // *** Create instance of `NSMutableParagraphStyle`
        let paragraphStyle = NSMutableParagraphStyle()
        
        paragraphStyle.alignment = .left
        
        // *** set LineSpacing property in points ***
        paragraphStyle.lineSpacing = 2 // Whatever line spacing you want in points
        
        // *** Apply attribute to string ***
        myMutableString.addAttribute(NSAttributedString.Key.paragraphStyle, value:paragraphStyle, range:NSMakeRange(0, myMutableString.length))
        
        return myMutableString
    }
    
    
    //TODO: Update Resturent details label
    
    func updateRestaurentDetails(title:String,cusineArray:[String],delemit:String)->NSMutableAttributedString{
        let myMutableString = NSMutableAttributedString()
        
        let myMutableString1 = NSAttributedString(string: "\(title)\(delemit)", attributes:[.font:AppFont.Semibold.size(AppFontName.SourceSansPro, size: 15), .foregroundColor :AppColor.textColor])
        
        
        let myMutableString2 = NSAttributedString(string: "\(cusineArray.joined(separator: " · "))", attributes:[.font:AppFont.Regular.size(AppFontName.SourceSansPro, size: 13), .foregroundColor :AppColor.placeHolderColor])
        
       
        
        
        myMutableString.append(myMutableString1)
        myMutableString.append(myMutableString2)
     
        
        // *** Create instance of `NSMutableParagraphStyle`
        let paragraphStyle = NSMutableParagraphStyle()
        
        paragraphStyle.alignment = .left
        
        // *** set LineSpacing property in points ***
        paragraphStyle.lineSpacing = 2 // Whatever line spacing you want in points
        
        // *** Apply attribute to string ***
        myMutableString.addAttribute(NSAttributedString.Key.paragraphStyle, value:paragraphStyle, range:NSMakeRange(0, myMutableString.length))
        
        return myMutableString
    }
    
    
    //TODO: Update Resturent details label
    
    func updateRestaurentAddressLabel(address:String)->NSMutableAttributedString{
        let myMutableString = NSMutableAttributedString()
        
         let myMutableString1 = NSAttributedString(string: "\(address)", attributes:[.font:AppFont.Regular.size(AppFontName.SourceSansPro, size: 12), .foregroundColor :AppColor.subtitleColor])
     
        myMutableString.append(myMutableString1)
        // *** Create instance of `NSMutableParagraphStyle`
        let paragraphStyle = NSMutableParagraphStyle()
        
        paragraphStyle.alignment = .left
        
        // *** set LineSpacing property in points ***
        paragraphStyle.lineSpacing = 2 // Whatever line spacing you want in points
        
        // *** Apply attribute to string ***
        myMutableString.addAttribute(NSAttributedString.Key.paragraphStyle, value:paragraphStyle, range:NSMakeRange(0, myMutableString.length))
        
        return myMutableString
    }
    
    
    
    
    //MARK: - For customize UIButton
    //TODO: Provide round Corner radius
    
    func provideCornarRadius(btnRef:UIView){
        btnRef.layer.cornerRadius = btnRef.frame.size.height / 2
    }
    
    //TODO: Provide Corner radius
    
    func provideShadow(btnRef:UIView){
        btnRef.layer.shadowColor = AppColor.placeHolderColor.cgColor
        btnRef.layer.shadowOffset = CGSize(width: 2.0, height: 2.0)
        btnRef.layer.shadowOpacity = 1.0
        btnRef.layer.shadowRadius = 2.0
        btnRef.layer.masksToBounds = false
    }
    
    //TODO: Setup SUBMIT buttton
    
    func setupSubmitBtn(btnRef:UIButton,title:String){
        btnRef.titleLabel?.font = AppFont.Semibold.size(AppFontName.SourceSansPro, size: 17)
        btnRef.setTitle(title, for: .normal)
        btnRef.backgroundColor = AppColor.stepperColor
        provideCornarRadius(btnRef:btnRef)
        provideShadow(btnRef:btnRef)
    }
    
    //TODO: Provide custom Corner radius
    func provideCustomCornarRadius(btnRef:UIView,radius:CGFloat){
        btnRef.layer.cornerRadius = radius
    }
    
    //TODO: Provide custom Corner radius
    func provideCustomBorder(btnRef:UIView){
        btnRef.layer.borderColor = AppColor.placeHolderColor.cgColor
        btnRef.layer.borderWidth = 1
    }
    
    func provideCustomBorderWithColor(btnRef:UIView,color:UIColor){
        btnRef.layer.borderColor = color.cgColor
        btnRef.layer.borderWidth = 1
    }
    
    
    func getKbarHeight()->CGFloat{
        let screenSize: CGRect = UIScreen.main.bounds
        let screenHeight = screenSize.height
        if screenHeight == 812 || screenHeight == 896 {
            return 94
        }else{
            return 64
            
        }
    }
    
  
}






public class InternetConnection {
    
    static  let internetshared = InternetConnection()
    
    public func isConnectedToNetwork() -> Bool {
        var zeroAddress = sockaddr_in()
        zeroAddress.sin_len = UInt8(MemoryLayout<sockaddr_in>.size)
        zeroAddress.sin_family = sa_family_t(AF_INET)
        guard let defaultRouteReachability = withUnsafePointer(to: &zeroAddress, {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {
                SCNetworkReachabilityCreateWithAddress(nil, $0)
            }
        }) else {
            return false
        }
        
        var flags: SCNetworkReachabilityFlags = []
        if !SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags) {
            return false
        }
        
        let isReachable = flags.contains(.reachable)
        let needsConnection = flags.contains(.connectionRequired)
        
        return (isReachable && !needsConnection)
    }
    
}


// SINGLTON CLASS FOR SCREEN NAME  that on That screen notification popup will not come
class ScreeNNameClass {
    static let shareScreenInstance = ScreeNNameClass()
    var  screenName = ""
    private init() {}
}
