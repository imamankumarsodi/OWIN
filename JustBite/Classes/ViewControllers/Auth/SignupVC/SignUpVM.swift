//
//  SignUpVM.swift
//  JustBite
//
//  Created by Aman on 17/05/19.
//  Copyright © 2019 Mobulous. All rights reserved.
//

import Foundation
import UIKit

// MARK: - Login Protocol



// MARK: - Class LoginVM

class SignUpVM:LoginModeling{
    
    func prepareDataSource() -> [DataStoreStruct] {
        var dataSource = [DataStoreStruct]()
        
        dataSource.append(DataStoreStruct(title: ConstantTexts.userName, placeholder: ConstantTexts.userName, value: String(), type: SignUpType.User))
        
        dataSource.append(DataStoreStruct(title: ConstantTexts.email, placeholder: ConstantTexts.emailPhonePlaceHoler, value: String(), type: SignUpType.Email))
        
        dataSource.append(DataStoreStruct(title: ConstantTexts.mobileNumberPlaceHolder, placeholder: ConstantTexts.mobileNumberPlaceHolder, value: String(), type: SignUpType.MobileNumber))
        
        dataSource.append(DataStoreStruct(title: ConstantTexts.address, placeholder: ConstantTexts.address, value: String(), type: SignUpType.Landmark))
        
        dataSource.append(DataStoreStruct(title: ConstantTexts.passwordPlaceHolder, placeholder: ConstantTexts.passwordPlaceHolder, value: String(), type: SignUpType.Password))
        
        dataSource.append(DataStoreStruct(title: ConstantTexts.confirmPassword, placeholder: ConstantTexts.confirmPasswordPlaceHolder, value: String(), type: SignUpType.Password))
        
        return dataSource
    }
    
    func viewModelFields(dataStore: [DataStoreStruct], userModel: UserModel, validHandler: @escaping (UserModel, String, Bool) -> Void) {
        
        for dataStoreItem in dataStore{
            
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
        
        validHandler(userModel, String(), true)
    }
    
}
