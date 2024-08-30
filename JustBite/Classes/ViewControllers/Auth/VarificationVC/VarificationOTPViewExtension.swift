//
//  VarificationOTPViewExtension.swift
//  JustBite
//
//  Created by Aman on 07/05/19.
//  Copyright © 2019 Mobulous. All rights reserved.
//

import Foundation
import UIKit
import Firebase
import RealmSwift

extension VarificationVC: VPMOTPViewDelegate {
    func hasEnteredAllOTP(hasEntered: Bool) -> Bool {
        print("Has entered all OTP? \(hasEntered)")
        
        return enteredOtp == "12345"
    }
    
    func shouldBecomeFirstResponderForOTP(otpFieldIndex index: Int) -> Bool {
        return true
    }
    
    func enteredOTP(otpString: String) {
        enteredOtp = otpString
        print("OTPString: \(otpString)")
        varifyPhone(otpString:otpString)
        
        
    }
    
    internal func resendOTP(){
        if InternetConnection.internetshared.isConnectedToNetwork(){
            let phoneNumber = "\(countryCode)\(self.phoneNumber)"
            print(phoneNumber)
            macroObj.showLoader(view: view)
            PhoneAuthProvider.provider().verifyPhoneNumber(phoneNumber, uiDelegate: nil) { (verificationID, error) in
                if let error = error {
                    self.macroObj.hideLoader(view: self.view)
                    print(error)
                    print(error.localizedDescription)
                    return
                }else{
                    // Sign in using the verificationID and the code sent to the user
                    // ...
                    self.macroObj.hideLoader(view: self.view)
                    self.varificationCode = verificationID!
                }
                
            }
        }else{
            self.macroObj.hideLoader(view: self.view)
            _ = SweetAlert().showAlert(macroObj.appName, subTitle: ConstantTexts.noInterNet, style: AlertStyle.error)
            
        }
    }
    
    internal func varifyPhone(otpString:String){
        if InternetConnection.internetshared.isConnectedToNetwork(){
            macroObj.showLoader(view: view)
            let credential = PhoneAuthProvider.provider().credential(
                withVerificationID: varificationCode,
                verificationCode: otpString)
            Auth.auth().signInAndRetrieveData(with: credential) { (authResult, error) in
                if let error = error {
                    // ...
                    self.macroObj.hideLoader(view: self.view)
                    print(error)
                    print(error.localizedDescription)
                    return
                }else{
                    // User is signed in
                    // ...
                    self.macroObj.hideLoader(view: self.view)
                    self.registerService()
                }
                
            }

            
            
            //moveToHomeVC()
        }else{
            self.macroObj.hideLoader(view: self.view)
            _ = SweetAlert().showAlert(macroObj.appName, subTitle: ConstantTexts.noInterNet, style: AlertStyle.error)
            
        }
    }
    
    fileprivate func registerService(){
        if InternetConnection.internetshared.isConnectedToNetwork(){
            let header = ["Content-Type":"application/x-www-form-urlencoded",
                          "Accept":"application/x-www-form-urlencoded"]
            
            print(self.dataDict)
            
            macroObj.showLoader(view: view)
            alamoFireObj.postRequestURLUndcoded(MacrosForAll.APINAME.register.rawValue, params: dataDict as? [String : AnyObject], headers: header, success: { (responseJASON) in
                self.macroObj.hideLoader(view: self.view)
                print(responseJASON)
                if responseJASON["status"].string == "true"{
                    if let dataDict = responseJASON["registerResponse"].dictionaryObject as? NSDictionary{
                        let signup_data = SignupDataModel()
                        if let wallet = responseJASON["wallet"].intValue as? Int{
                            signup_data.wallet = wallet
                        }
                        if let authDict = dataDict.value(forKey: "auth") as? NSDictionary{
                            if let token_type = authDict["token_type"] as? String{
                                signup_data.token_type = token_type
                            }
                            
                            if let expires_in = authDict["expires_in"] as? Int{
                                signup_data.expires_in = String(expires_in)
                            }
                            
                            if let access_token = authDict["access_token"] as? String{
                                signup_data.access_token = access_token
                            }
                            
                            if let refresh_token = authDict["refresh_token"] as? String{
                                signup_data.refresh_token = refresh_token
                            }
                            
                        }
                        
                        
                        if let userDict = dataDict.value(forKey: "user") as? NSDictionary{
                            
                            if let id = userDict["id"] as? Int{
                                signup_data.id = String(id)
                            }
                            
                            if let email_id = userDict["email_id"] as? String{
                                signup_data.email_id = email_id
                            }
                            
                            if let first_name = userDict["first_name"] as? String{
                                signup_data.first_name = first_name
                            }
                            
                            if let last_name = userDict["last_name"] as? String{
                                signup_data.last_name = last_name
                            }
                            
                            if let phone = userDict["phone"] as? String{
                                signup_data.phone = phone
                            }
                            
                            if let facebook_id = userDict["facebook_id"] as? String{
                                signup_data.facebook_id = facebook_id
                            }
                            
                            if let google_id = userDict["google_id"] as? String{
                                signup_data.facebook_id = google_id
                            }
                            
                            if let address = userDict["address"] as? String{
                                signup_data.address = address
                            }
                            
                            if let address_type = userDict["address_type"] as? Int{
                                signup_data.address_type = String(address_type)
                            }
                            
                            if let is_phone_verify = userDict["is_phone_verify"] as? Int{
                                signup_data.is_phone_verify = String(is_phone_verify)
                            }
                            
                            if let signup_by = userDict["signup_by"] as? String{
                                signup_data.signup_by = signup_by
                            }
                            
                            if let status = userDict["status"] as? String{
                                signup_data.status = status
                            }
                            
                            if let created_at = userDict["created_at"] as? String{
                                signup_data.created_at = created_at
                            }
                            
                            if let updated_at = userDict["updated_at"] as? String{
                                signup_data.updated_at = updated_at
                            }
                            
                            if let country_code = userDict["country_code"] as? String{
                                signup_data.country_code = country_code
                            }
                            
                            if let area = userDict["area"] as? String{
                                signup_data.area = area
                            }
                            
                            if let pin = userDict["pin"] as? String{
                                signup_data.pin = pin
                            }
                            
                            if let landmark = userDict["landmark"] as? String{
                                signup_data.landmark = landmark
                            }
                            
                            if let houseOrFlatNo = userDict["houseOrFlatNo"] as? String{
                                signup_data.houseOrFlatNo = houseOrFlatNo
                            }
                            
                        }
                        
                        self.save(userInfo: signup_data)
                        
                        
                    }
                }else{
                    self.macroObj.hideLoader(view: self.view)
                    if let message = responseJASON["message"].string{
                        _ = SweetAlert().showAlert(self.macroObj.appName, subTitle: message, style: AlertStyle.error)
                    }
                    
                }
                
            }, failure: { (error) in
                self.macroObj.hideLoader(view: self.view)
                print(error.localizedDescription)
                _ = SweetAlert().showAlert(self.macroObj.appName, subTitle: ConstantTexts.ErrorMessage, style: AlertStyle.error)
            })
            
        }else{
            self.macroObj.hideLoader(view: self.view)
            _ = SweetAlert().showAlert(macroObj.appName, subTitle: ConstantTexts.noInterNet, style: AlertStyle.error)
        }
    }
    
    
    
    func save(userInfo:SignupDataModel){
        do{
            try realm.write {
                if let user = realm.objects(SignupDataModel.self).first{
                    
                    
                    user.token_type = userInfo.token_type
                    user.expires_in = userInfo.expires_in
                    user.access_token = userInfo.access_token
                    user.refresh_token = userInfo.refresh_token
                    
                    user.id = userInfo.id
                    user.first_name = userInfo.first_name
                    user.last_name = userInfo.last_name
                    user.country_code = userInfo.country_code
                    user.phone = userInfo.phone
                    user.email_id = userInfo.email_id
                    user.phone = userInfo.phone
                    user.area = userInfo.area
                    user.houseOrFlatNo = userInfo.houseOrFlatNo
                    user.pin = userInfo.pin
                    user.landmark = userInfo.landmark
                    user.address_type = userInfo.address_type
                    user.facebook_id = userInfo.facebook_id
                    user.google_id = userInfo.google_id
                    user.address = userInfo.address
                    user.is_phone_verify = userInfo.is_phone_verify
                    user.signup_by = userInfo.signup_by
                    user.status = userInfo.status
                    user.created_at = userInfo.created_at
                    user.updated_at = userInfo.updated_at
                    
                }else{
                    realm.add(userInfo)
                }
                moveToHomeVC()
            }
        }catch{
            print("Error in saving data :- \(error.localizedDescription)")
        }
    }

    

}
