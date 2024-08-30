//
//  MacrosForAll.swift
//  Monami
//
//  Created by abc on 22/11/18.
//  Copyright © 2018 mobulous. All rights reserved.
//

import Foundation
import UIKit
import Lottie
public class MacrosForAll:NSObject{
    public class var sharedInstanceMacro: MacrosForAll {
        struct Singleton {
            static let instance: MacrosForAll = MacrosForAll()
        }
        return Singleton.instance
    }
    override init() {}
    //MARK: - Variables
    //TODO: App Delegate
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    //TODO: Base URL
    let API_BASE_URL = "http://3.18.123.247/public/api/"
    let appName = "OWIN"
    
    
    
    let animationView = AnimationView(name: "circle_loading")
    let animationViewLike = AnimationView(name: "501-like")
    let animationViewDisLike = AnimationView(name: "animation-w280-h280")
    //let animationViewNoDataFound = AnimationView(name: "5081-empty-box")
    let animationViewNoDataFound = AnimationView(name: "629-empty-box")
   // let animationViewNoDataFound = AnimationView(name: "2432-fuck-off")
    let animationViewNetFound = AnimationView(name: "2353-network-fail-in-recipe-app")
    let animationViewWentWrong = AnimationView(name: "5484-something-went-wrong")
    
    //TODO: App Languages
    enum AppLanguage : String {
        case ENGLISH = "en"
        case PORTUGUESE  = "portu"
    }
    enum APINAME : String {
        
        case register           = "register"
        case beforesignupcheck  = "before-signup-check"
        case logout             = "logout"
        case resettoken         = "reset-token"
        case restorentlist      = "restorent-list"
        case savefavourite      = "save-favourite"
        case nearbyrestorent    = "near-by-restorent"
        case topratedrestorent  = "top-rated-restorent"
        case userfavourite      = "user-favourite"
        case searchrestorent    = "search-restorent"
        case detailrestorent    = "detail-restorent"
        case informationrestorent = "information-restorent"
        case offer = "offer"
        case filterrestorent = "filter-restorent"
        case userdetails = "user-details"
        case cuisinelist = "cuisines-list"
        case placeOrder = "placeOrder"
        case cardlist = "card-list"
        case cardsave = "card-save"
        case carddelete = "card-delete"
     
        case ParentSignUp       = "parentsignup"
        case CheckEmailId       = "checkemailid"
        case login              = "login"
        case userupdate         = "user-update"
        case mapparentcuid      = "mapparentcuid"
        case followaction       = "followaction"
        case sociallogin        = "socialMedialLogin"
        case postlist           = "postlist"
        case changepassword     = "changepassword"
        case followinglist      = "followinglist"
        case familylist         = "familylist"
        case accessforfamily    = "accessforfamily"
        case deleteaccessoffamily  = "deleteaccessoffamily"
        case forgotpassword     = "forgotpassword"
        case resetpassword      = "resetpassword"
        case notificationtrigger = "notificationtrigger"
        case commentlist        = "commentlist"
        case commentonpost      = "commentonpost"
        case childprofile       = "childprofile"
        case commonsection      = "commonsection"
        case chatlist           = "chatlist"
        case sendmsg            = "sendmsg"
        case aboutus            = "aboutus"
        case reportsection      = "reportsection"
        case getmeal            = "getmeal"
        case notificationList   = "notficationlist"
        case deletepostbyparent   = "deletepostbyparent"
        case reportpreview   = "reportpreview"
        case notify_count   = "notify_count"
        case listmenu      = "list-menu"
        case addtocart   = "add-to-cart"
        case listmenufilter = "list-menu-filter"
        case cartlist = "cart-list"
        case socialmedialogin = "socialmedialogin"
        case ongoingorder = "ongoing_order"
        case upgoingorder = "upcoming_order"
        case previous_order = "previous_order"
        case cancel_order = "cancel_order"
        case reorder = "reorder"
        case restorentrating = "restorent-rating"
        case userpassword = "user-password"
        case topuplist = "topup-list"
        case addwallet = "add-wallet"
        case topuphistory = "topup-history"
        case addtocartall = "add-to-cart-all"
         case saveCartDetail = "card-detail-save"
         case Notifications_List = "myNotification"
       
    }
    enum VALIDMESSAGE : String {
        //Basic Signup
        case EnterFullName                           = "Please enter full name."
        case EnterValidFullName                      = "Please enter your valid full name. (Full Name contains A-Z or a-z, no special character or digits are allowed.)"
        case EnterValidFullNameLength                = "Full name length should atleast of 4 characters."
        case EnterMobileNumber                       = "Please enter phone number."
        case EmailAddressNotBeBlank                  = "Please enter Email ID."
        case EnterValidEmail                         = "Please enter valid email address."
        case PasswordNotBeBlank                      = "Please enter password."
        case PasswordShouldBeLong                    = "Password length should be 6-10 characters."
        case ConfirmPasswordNotBeBlank               = "Please enter confirm password."
        case ConfirmPasswordShouldBeLong             = "Confirm password length should be 6-10 characters."
        case NewPasswordNotBeBlank                   = "Please enter new password."
        case NewPasswordShouldBeLong                 = "New password length should be 6-10 characters."
        case PasswordAndConfimePasswordNotMatched    = "Password and Confirm Pasword is not matching."
        case AcceptTermsAndConditions                = "Please accept terms & conditions."
        case CUIDAlert                               = "Please enter CUID."
        case invalidCUIDAlert                        = "Please enter correct CUID."
        case CUIDMaxLength                           = "CUID length should be 6 digit long."
        case OldPasswordNotBeBlank                      = "Please enter old password."
        case OldPasswordShouldBeLong                    = "Old Password length should be 6-10 characters."
        case NewPasswordAndConfimePasswordNotMatched    = "New Password and Confirm Pasword is not matching."
        case LoginTokenExpire                       = "User already logged in some other device."
        case IncorrectOTP                           = "Incorrect OTP."
        case WantToLogout                           = "Are you sure?\nYou want to Log out!"
        case ContinueApp                           = "Please enter CUID to continue in the app."
        case ProfileUpdate                         = "Profile updated successfully."
        case DeleteAccess                          = "Are you sure?\nYou want to delete access of "
        case UnfollowChild                         = "Are you sure?\nYou want to unfollow "
        case DeletePost                          = "Are you sure?\nYou want to delete post of "
        case AudioMissing                         = "Audio file is missing."
    }
    enum ERRORMESSAGE : String {
        case NoInternet                              = "There is no internet connection. Please try again later."
        case ErrorMessage                            = "There is some error occured. Please try again later."
        
    }
    
    
    
    
}

//MARK: - Extension Lottie loader
extension MacrosForAll{
    
    func showLoaderEmpty(view: UIView) {
        animationViewNoDataFound.isHidden = false
       // animationViewNoDataFound.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
        animationViewLike.frame.size.height = view.frame.height
        animationViewLike.frame.size.width = view.frame.width
        animationViewNoDataFound.center = view.center
        animationViewNoDataFound.contentMode = .center
        animationViewNoDataFound.animationSpeed = 1
        animationViewNoDataFound.loopMode = .loop
        view.addSubview(animationViewNoDataFound)
        animationViewNoDataFound.translatesAutoresizingMaskIntoConstraints = true
        animationViewNoDataFound.center = CGPoint(x: view.bounds.midX, y: view.bounds.midY)
        animationViewNoDataFound.autoresizingMask = [UIView.AutoresizingMask.flexibleLeftMargin, UIView.AutoresizingMask.flexibleRightMargin, UIView.AutoresizingMask.flexibleTopMargin, UIView.AutoresizingMask.flexibleBottomMargin]
        animationViewNoDataFound.play()
    }
    func hideLoaderEmpty(view: UIView) {
        animationViewNoDataFound.isHidden = true
        animationViewNoDataFound.stop()
    }
    
    func showLoaderNet(view: UIView) {
        animationViewNetFound.isHidden = false
        // animationViewNoDataFound.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
        animationViewNetFound.frame.size.height = view.frame.height
        animationViewNetFound.frame.size.width = view.frame.width
        animationViewNetFound.center = view.center
        animationViewNetFound.contentMode = .scaleAspectFit
        animationViewNetFound.animationSpeed = 1
        animationViewNetFound.loopMode = .loop
        view.addSubview(animationViewNetFound)
        animationViewNetFound.translatesAutoresizingMaskIntoConstraints = true
        animationViewNetFound.center = CGPoint(x: view.bounds.midX, y: view.frame.height/2)
        animationViewNetFound.autoresizingMask = [UIView.AutoresizingMask.flexibleLeftMargin, UIView.AutoresizingMask.flexibleRightMargin, UIView.AutoresizingMask.flexibleTopMargin, UIView.AutoresizingMask.flexibleBottomMargin]
        animationViewNetFound.play()
    }
    func hideLoaderNet(view: UIView) {
        animationViewNetFound.isHidden = true
        animationViewNetFound.stop()
    }
    
    
    func showWentWrong(view: UIView) {
        animationViewWentWrong.isHidden = false
        // animationViewNoDataFound.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
        animationViewWentWrong.frame.size.height = view.frame.height
        animationViewWentWrong.frame.size.width = view.frame.width
        animationViewWentWrong.center = view.center
        animationViewWentWrong.contentMode = .scaleAspectFit
        animationViewWentWrong.animationSpeed = 1
        animationViewWentWrong.loopMode = .loop
        view.addSubview(animationViewWentWrong)
        animationViewWentWrong.translatesAutoresizingMaskIntoConstraints = true
        animationViewWentWrong.center = CGPoint(x: view.bounds.midX, y: view.frame.height/2)
        animationViewWentWrong.autoresizingMask = [UIView.AutoresizingMask.flexibleLeftMargin, UIView.AutoresizingMask.flexibleRightMargin, UIView.AutoresizingMask.flexibleTopMargin, UIView.AutoresizingMask.flexibleBottomMargin]
        animationViewWentWrong.play()
    }
    func hideWentWrong(view: UIView) {
        animationViewWentWrong.isHidden = true
        animationViewWentWrong.stop()
    }
    
    
    
    
    func showLoader(view: UIView) {
        animationView.isHidden = false
        animationView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
        animationView.center = view.center
        animationView.contentMode = .center
        animationView.animationSpeed = 1.25
        animationView.loopMode = .loop
        view.addSubview(animationView)
        animationView.play()
    }
    func hideLoader(view: UIView) {
        animationView.isHidden = true
        animationView.stop()
    }
    
    
    func showLoaderHeart(view: UIView) {
        view.isHidden = false
        animationViewLike.isHidden = false
       // animationViewLike.frame = CGRect(x: 0, y: -10, width: 60, height: 60)
        animationViewLike.frame.size.height = 30
        animationViewLike.frame.size.width = 30
       // animationViewDisLike.center = view.center
        animationViewLike.contentMode = .scaleAspectFill
        animationViewLike.animationSpeed = 2
        animationViewLike.loopMode = .loop
        view.addSubview(animationViewLike)
        animationViewLike.translatesAutoresizingMaskIntoConstraints = true
        animationViewLike.center = CGPoint(x: view.bounds.midX - 1, y: view.bounds.midY + 2)
        animationViewLike.autoresizingMask = [UIView.AutoresizingMask.flexibleLeftMargin, UIView.AutoresizingMask.flexibleRightMargin, UIView.AutoresizingMask.flexibleTopMargin, UIView.AutoresizingMask.flexibleBottomMargin]
        animationView.play()
    }
    func hideLoaderHeart(view: UIView) {
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            view.isHidden = true
            self.animationViewLike.isHidden = true
            self.animationViewLike.stop()
        
        }
       
    }
    
    
    
    func showLoaderBrokenHeart(view: UIView) {
        view.isHidden = false
        animationViewDisLike.isHidden = false
     //   animationViewDisLike.frame = CGRect(x: 0, y: -10, width: 40, height: 40)
       // animationViewDisLike.center = view.center
        animationViewDisLike.frame.size.height = 30
        animationViewDisLike.frame.size.width = 30
        animationViewDisLike.contentMode = .scaleAspectFill
        animationViewDisLike.animationSpeed = 1
        animationViewDisLike.loopMode = .loop
        view.addSubview(animationViewDisLike)
        animationViewDisLike.translatesAutoresizingMaskIntoConstraints = true
        animationViewDisLike.center = CGPoint(x: view.bounds.midX - 2, y: view.bounds.midY + 2)
        animationViewDisLike.autoresizingMask = [UIView.AutoresizingMask.flexibleLeftMargin, UIView.AutoresizingMask.flexibleRightMargin, UIView.AutoresizingMask.flexibleTopMargin, UIView.AutoresizingMask.flexibleBottomMargin]
        animationViewDisLike.play()
    }
    func hideLoaderBrokenHeart(view: UIView) {
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            view.isHidden = true
            self.animationViewDisLike.isHidden = true
            self.animationViewDisLike.stop()
        }
        
    }
    
 
    
}
