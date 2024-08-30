//
//  ProfileVM.swift
//  JustBite
//
//  Created by Aman on 16/05/19.
//  Copyright © 2019 Mobulous. All rights reserved.
//

import Foundation
import UIKit
import RealmSwift

// MARK: - Login Protocol

protocol ProfileModeling {
    
    func prepareDataSource(userInfo:SignupDataModel) -> ([DataStoreStruct],[DataStoreStruct])
    
    func viewModelFields(dataStore:([DataStoreStruct],[DataStoreStruct]),userModel:UserModel,validHandler:@escaping (_ model : UserModel,_ msg : String, _ success : Bool)->Void)
    
    
}


// MARK: - Class LoginVM

class ProfileVM:ProfileModeling{

    
    func prepareDataSource(userInfo:SignupDataModel) -> ([DataStoreStruct], [DataStoreStruct]) {
        
        let realm = try! Realm()
        var dataSource1 = [DataStoreStruct]()
        var dataSource2 = [DataStoreStruct]()
        
        if let userInfoo = realm.objects(SignupDataModel.self).first{
            
            
            dataSource1.append(DataStoreStruct(title: ConstantTexts.forgetEmailPlaceHoler, placeholder: ConstantTexts.forgetEmailPlaceHoler, value: userInfoo.email_id, type: SignUpType.Email))
            
            dataSource1.append(DataStoreStruct(title: ConstantTexts.mobileNumberPlaceHolder, placeholder: ConstantTexts.mobileNumberPlaceHolder, value: "\(userInfoo.country_code)\(userInfoo.phone)", type: SignUpType.MobileNumber))
            
            dataSource2.append(DataStoreStruct(title: ConstantTexts.location, placeholder: ConstantTexts.location, value: userInfoo.address, type: SignUpType.Landmark))
            
            
            if userInfoo.address_type == "0"{
                dataSource2.append(DataStoreStruct(title: ConstantTexts.houseFlat, placeholder: ConstantTexts.houseFlat, value: ConstantTexts.homeAddress, type: SignUpType.Landmark))
            }else{
                 dataSource2.append(DataStoreStruct(title: ConstantTexts.houseFlat, placeholder: ConstantTexts.houseFlat, value: ConstantTexts.officeAddress, type: SignUpType.Landmark))
            }
            
           
            
            dataSource2.append(DataStoreStruct(title: ConstantTexts.pinCode, placeholder: ConstantTexts.pinCode, value: userInfoo.street, type: SignUpType.PinCode))
            
            dataSource2.append(DataStoreStruct(title: ConstantTexts.landmark, placeholder: ConstantTexts.landmark, value: userInfoo.landmark, type: SignUpType.Landmark))
            
            dataSource2.append(DataStoreStruct(title: ConstantTexts.appartmentNo, placeholder: ConstantTexts.appartmentNo, value: userInfoo.apartment, type: SignUpType.Landmark))
            
            dataSource2.append(DataStoreStruct(title: ConstantTexts.floor, placeholder: ConstantTexts.floor, value: userInfoo.floor, type: SignUpType.Landmark))
            
            dataSource2.append(DataStoreStruct(title: ConstantTexts.building, placeholder: ConstantTexts.building, value: userInfoo.building, type: SignUpType.Landmark))
            
            
            
        }
        
        print(dataSource1)
        print(dataSource2)
        
        return (dataSource1,dataSource2)
        
    }
    
    func viewModelFields(dataStore: ([DataStoreStruct],[DataStoreStruct]), userModel: UserModel, validHandler: @escaping (UserModel, String, Bool) -> Void) {
        
        for dataStoreItem in dataStore.0{
            
            switch dataStoreItem.type{
                
                
            case .Email?:
                if dataStoreItem.value.trimmingCharacters(in: .whitespaces) == ""{
                    validHandler(userModel, ConstantTexts.enterEmail, false)
                    return
                }else if HHelper.isValidEmail(dataStoreItem.value) == false{
                    validHandler(userModel, ConstantTexts.enterVaidEmail, false)
                    return
                }
                userModel.email = dataStoreItem.value.trimmingCharacters(in: .whitespaces)
                
                
            case .Password?:
                if dataStoreItem.value.trimmingCharacters(in: .whitespaces) == ""{
                    validHandler(userModel,ConstantTexts.password,false)
                    return
                }else if dataStoreItem.value.count < 6{
                    validHandler(userModel, ConstantTexts.validPassword, false)
                    return
                }
                userModel.password = dataStoreItem.value.trimmingCharacters(in: .whitespaces)
                
                
            case .none:
                break
                
            case .some(_):
                break
                
                
            }
        }
        
        
        for dataStoreItem in dataStore.1{
            
            switch dataStoreItem.type{
                
                
            case .Landmark?:
                if dataStoreItem.value.trimmingCharacters(in: .whitespaces) == ""{
                    validHandler(userModel, ConstantTexts.landmark, false)
                    return
                }else if HHelper.isValidEmail(dataStoreItem.value) == false{
                    validHandler(userModel, ConstantTexts.address, false)
                    return
                }
                userModel.name = dataStoreItem.value.trimmingCharacters(in: .whitespaces)
                
                
                
            case .none:
                break
                
            case .some(_):
                break
                
                
            }
        }
        
        
        validHandler(userModel, String(), true)
    }
    
}
