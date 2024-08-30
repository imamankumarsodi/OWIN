//
//  ConstantsText.swift
//  JustBite
//
//  Created by Aman on 04/05/19.
//  Copyright © 2019 Mobulous. All rights reserved.
//

import Foundation
struct ConstantTexts{
    
    // MARK: - App Specific
    static let  completeAdress               = "Your Profile is not complete. Please complete your Profile before Ordering."
    static let  AppName               =     "OWIN"
    static let  requestTimedOut       =     "Request timed out"
    static let  noInterNet            =     "No Internet Connection"
    static let  selectRating          =     "Please select rating."
    static let  ErrorMessage          = "There is some error occured. Please try again later."
    
    static let  WelcomeAppName        =     "Welcome to OWIN"
    
    
    static var screenName = String()
    
    
    // MARK: - Localized Value
    
    static let signIn                         =  "SIGN IN"
    static let facebook                       =  "FACEBOOK"
    static let unexpectedIndexPath            =  "Unexpected Index Path"
    static let name                           =  "Name"
    static let nameFirst                      =  "First Name"
    static let nameLast                       =  "Last Name"
    static let restaurantName                 =  "Restaurant Name"
    static let contactPersonName              =  "Contact Person Name"
    static let newPassword                    =  "New Password"
    static let confirmNewPassword             =  "Confirm New Password"
    static let myProfile                      =  "My Profile"
    static let selectAddress                  =  "Select Address"
    static let selectCountryCode              =  "Choose Country"
    static let area                           =  "Area"
    static let payment                        =  "Payment"
    static let myFavorite                     =  "Favorites "
    static let addNewCard                     =  "Add New Card"
    static let savedPlace                     =  "Saved Place"
    static let houseFlat                      =  "Address Type"
    static let pinCode                        =  "Street"
    static let landmark                       =  "Landmark"
    static let appartmentNo                       =  "Appartment No."
    static let floor                       =  "Floor"
    static let building                       =  "Building"
    static let deliveryToDoor                 =  "DELIVERY TO DOOR "
    static let addNewAddress                  =  "Add New Address"
    static let promotions                     =  "Promotions"
    static let setting                        =  "Settings"
    static let changePassword                 =  "Change Password"
    static let oldPassword                    =  "Old Password "
    static let currentPassword                =  "Current Password"
    static let inviteFriends                  =  "Invite Your Friends"
    static let chooseImage                    =  "Choose Image"
    static let camera                         =  "Camera"
    static let gallery                        =  "Gallery"
    static let cancel                         =  "Cancel"
    static let countryCode                    =  "Code"
    static let Ok                             =  "OK"
    static let filterMessage                  = "Please select at least one field for filter menu list."
    static let yes                    =  "YES"
    static let no                    =  "NO"
    static let removeItem = "This item has multiple customizations added. Proceed to cart to remove item ?"
    
    
    //MARK:- Placeholder
    
    static let emailPhonePlaceHoler           =  "Email Id/Phone"
    static let forgetEmailPlaceHoler          =  "Email ID"
    static let passwordPlaceHolder            =  "Password"
    static let mobileNumberPlaceHolder        =  "Phone Number"
    static let yearEx                         =  "Enter Year"
    static let cvvNumber                      =  "CVV"
    static let location                       =  "Location"
    static let confirmPasswordPlaceHolder     =  "Confirm Password"
    static let nameOnCard                     =  "Enter Name On Card"
    static let cardNumber                     =  "Enter Card Number"
    static let montOfExpiry                   =  "Enter Month"
    
    
    
    
    // MARK: - Validation Messages
    
    //TODO:- Auth Message
    
    static let enterName                      =  "Please enter name"
    static let enterFirstName                 =  "Please enter first name"
    static let enterValidFirstName            =  "Please enter valid first name"
    static let enterLastName                  =  "Please enter last name"
    static let enterValidLastName             =  "Please enter valid last name"
    static let enterEmailPhone                =  "Please enter email Id / Phone Number"
    static let enterEmail                     =  "Please enter email Id"
    static let enterAddress                   =  "Please enter address"
    static let enterVaidEmail                 =  "Please enter valid email Id"
    static let enterMobile                    =  "Please enter mobile number"
    static let enterValidMobile               =  "Please enter valid mobile number"
    static let password                       =  "Please enter password"
    static let confirmPassword                =  "Please enter confirm Password"
    static let enterArea                =  "Please enter Area"
    static let enterHouse                =  "Please enter House, Flat, Building Number"
    static let enterPinCode                =  "Please enter area pin code"
    static let enterLandMark                =  "Please enter landmark"
    static let selectAddressType                =  "Please select address type"
    static let profileUpdated                =  "Profile updated successfuly"

    static let validewPassword                  =  "New password should include at least 6 characters"
    static let validPassword                  =  "Password should include at least 6 characters"
    static let validConfirmPassword           =  "Confirm password should include at least 6 characters"
    static let retypePasswordConfirmPassword  =  "Password and Confirm Password should be same."
    
    static let termsAndCondition              =  "Please accept Terms & Conditions"
    static let counrtyCodeAlert               =  "Please choose counrty code"
    static let fbIdNotFound                   =  "Can't connect to facebook"
    static let googleIdNotFound               =  "Can't connect to google"
    static let retypeConfirmPassword          =  "New Password and Confirm Password should be same."
    static let enterRegisteredEmail           =  "Please enter your registered email address."
    static let enterOnlyOneField              =  "Please enter whether email field or phone number field"
    static let enterOneValue                  =  "Please choose one field"
    static let enterOTP                       =  "Please enter correct OTP"
    static let enterNewOTP                    =  "Please enter OTP"
    static let oldPasswordAlert               =  "Please enter your oldpassword."
    static let newPasswordAlert               =  "Please enter your newpassword."
    static let reTypePassword                 =  "Please enter your re-type password."
    static let dontHaveCamera                 =  "You don't have camera"
    static let dontHaveGallery                =  "You don't have perission to access gallery."
    static let cardNumberAlert                =  "Please enter card number"
    static let cardNameAlert                =  "Please enter card name"
    static let cardNameValidAlert                =  "Please enter valid card name"

    static let correctCardNumberAlert         =  "Please enter correct card number"
    static let enterExpireDate                =  "Please enter expire date"
    static let enterExpireMonth              =  "Please enter expire month"
    static let enterExpireValidMonth              =  "Please enter valid expire month"
    static let enterExpireYear              =  "Please enter expire year"
    static let enterExpireValidYear              =  "Please enter valid expire year"
    static let enterCVVnumber                 =  "Please enter CVV number"
    static let enterCorrectCVVnumber          =  "Please enter correct CVV number"
    static let deleteCard                     =  "Are you sure you want to delete this card?"
    static let deleteAddress                  =  "Are you sure you want to delete this address?"
    static let houseAddress                   =  "Please enter house/flat number"
    static let addressType                    =  "Please select address type"
    static let enableLocation                 =  "Please enable locations to track the your location."
    static let address                        =  "Address"
    static let order                          =  "Order"
    static let orderDetails                   =  "Order Details"
    static let cart                           =  "Cart"
    static let homeAddress                    =  "Home Address"
    static let officeAddress                  =  "Office Address"

    static let forgetAttributedString         =  "Please enter your registered Email ID or Phone Number"
    static let deliverTimeAttributedString    =  "Delivery Time:"
    static let customAlertViewMessage         =  "Motivate your driver add a tip"
    static let customAlertViewMsg             =  "Your order successfully placed"
    static let customAlertVewMsg              =  "Thank You!"
    static let logOut                         =  "Are you sure you want to sign out?"
    static let camra                          =  "Image Not found"
    static let tranding                       =  "Tranding"
    static let socialAlert                    =  "Your password does not match."
    static let SearchItem                     =  "Search Item"
    static let becomeDriver                   =  "Become Driver"
    static let becomeRestaurant               =  "Become Restaurant"
    static let dataNotFound                   =  "Data not found"
    static let WantToLogout                   = "Are you sure?\nYou want to Log out!"
    static let WantToChangeRest                  = "Are you sure?\nYou want to change restaurent!"
    static let RepeatCust                   = "Do you want to repeat customize?"
    static let CancelOrder                   = "Are you sure?\nYou want to cancel your order!"
    static let LoginRwq                   = "You are not logged in!\nRedirect to log in page!"
    static let deleteReq                   = "Are you sure?\nYou want to delete your card!"
    static let selectWallet                   = "Please select amount first."

    
    
    // MARK: - User Default Keys
    
    static let authToken                      =  "AUTHTOKEN"
    static let userID                         =  "USERID"
    static let deviceToken                    =  "DEVICETOKEN"
    static let email                          =  "EMAIL"
    static let mobile                         =  "MOBILE"
    static let empty                          =  ""
   // static let countryCode                    =  "COUNTRYCODE"
    static let profileImage                   =  "POFILEIMAGE"
    static let userName                       =  "USERNAME"
    static let result                         =  "RESULT"
    static let googleId                       =  "GOOGLEID"
    static let faceBookId                     =  "FACEBOOKID"
    
    
}
