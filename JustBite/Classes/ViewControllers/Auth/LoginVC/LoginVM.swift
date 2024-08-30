//
//  LoginVM.swift
//  JustBite
//
//  Created by Aman on 05/05/19.
//  Copyright © 2019 Mobulous. All rights reserved.
//

import Foundation
import UIKit

// MARK: - Login Protocol

protocol LoginModeling {
    
    func prepareDataSource() -> [DataStoreStruct]
    
    func viewModelFields(dataStore:[DataStoreStruct],userModel:UserModel,validHandler:@escaping (_ model : UserModel,_ msg : String, _ success : Bool)->Void)
    
    
}


// MARK: - Class LoginVM

class LoginVM:LoginModeling{
    
    func prepareDataSource() -> [DataStoreStruct] {
        var dataSource = [DataStoreStruct]()
        
        dataSource.append(DataStoreStruct(title: ConstantTexts.emailPhonePlaceHoler, placeholder: ConstantTexts.emailPhonePlaceHoler, value: String(), type: SignUpType.User))
        
        dataSource.append(DataStoreStruct(title: ConstantTexts.passwordPlaceHolder, placeholder: ConstantTexts.passwordPlaceHolder, value: String(), type: SignUpType.Password))
        
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
