//
//  EditProfileVM.swift
//  JustBite
//
//  Created by Aman on 16/05/19.
//  Copyright © 2019 Mobulous. All rights reserved.
//

import Foundation
import UIKit

// MARK: - Login Protocol
protocol editProfileModeling {
    
    func prepareDataSource() -> ([DataStoreStruct],[DataStoreStruct])
    
    func viewModelFields(dataStore:([DataStoreStruct],[DataStoreStruct]),userModel:UserModel,validHandler:@escaping (_ model : UserModel,_ msg : String, _ success : Bool)->Void)
    
    
}


// MARK: - Class LoginVM

class EditProfileVM:editProfileModeling{
    
    func prepareDataSource() -> ([DataStoreStruct],[DataStoreStruct]) {
        var dataSource1 = [DataStoreStruct]()
        var dataSource2 = [DataStoreStruct]()
        
         dataSource1.append(DataStoreStruct(title: ConstantTexts.userName, placeholder: ConstantTexts.userName, value: String(), type: SignUpType.User))
        
        dataSource1.append(DataStoreStruct(title: ConstantTexts.email, placeholder: ConstantTexts.emailPhonePlaceHoler, value: String(), type: SignUpType.Email))
        
        dataSource1.append(DataStoreStruct(title: ConstantTexts.mobileNumberPlaceHolder, placeholder: ConstantTexts.mobileNumberPlaceHolder, value: String(), type: SignUpType.MobileNumber))
        
        dataSource2.append(DataStoreStruct(title: ConstantTexts.area, placeholder: ConstantTexts.area, value: String(), type: SignUpType.Landmark))
        
        dataSource2.append(DataStoreStruct(title: ConstantTexts.houseFlat, placeholder: ConstantTexts.houseFlat, value: String(), type: SignUpType.Landmark))
        
        dataSource2.append(DataStoreStruct(title: ConstantTexts.pinCode, placeholder: ConstantTexts.pinCode, value: String(), type: SignUpType.PinCode))
        
        dataSource2.append(DataStoreStruct(title: ConstantTexts.landmark, placeholder: ConstantTexts.landmark, value: String(), type: SignUpType.Landmark))
        
           dataSource2.append(DataStoreStruct(title: ConstantTexts.building, placeholder: ConstantTexts.building, value: String(), type: SignUpType.Landmark))
        
           dataSource2.append(DataStoreStruct(title: ConstantTexts.floor, placeholder: ConstantTexts.floor, value: String(), type: SignUpType.Landmark))
        
           dataSource2.append(DataStoreStruct(title: ConstantTexts.appartmentNo, placeholder: ConstantTexts.appartmentNo, value: String(), type: SignUpType.Landmark))
        
        
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
