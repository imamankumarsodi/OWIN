//
//  EditAddresssVM.swift
//  JustBite
//
//  Created by Aman on 22/05/19.
//  Copyright © 2019 Mobulous. All rights reserved.
//

import Foundation
import UIKit
class EditAddressVM:LoginModeling{
    
    
    internal func navigationSetup(){
       
    }
    
    
    func prepareDataSource() -> [DataStoreStruct] {
        var dataSource = [DataStoreStruct]()
        
        dataSource.append(DataStoreStruct(title: ConstantTexts.area, placeholder: ConstantTexts.area, value: String(), type: SignUpType.Landmark))
        
        dataSource.append(DataStoreStruct(title: ConstantTexts.address, placeholder: ConstantTexts.address, value: String(), type: SignUpType.Landmark))
        
        dataSource.append(DataStoreStruct(title: ConstantTexts.pinCode, placeholder: ConstantTexts.pinCode, value: String(), type: SignUpType.Landmark))
        
        dataSource.append(DataStoreStruct(title: ConstantTexts.landmark, placeholder: ConstantTexts.landmark, value: String(), type: SignUpType.Landmark))
        
        return dataSource
    }
    
    func viewModelFields(dataStore: [DataStoreStruct], userModel: UserModel, validHandler: @escaping (UserModel, String, Bool) -> Void) {
        print("Likho")
//        for dataStoreItem in dataStore{
//
//            switch dataStoreItem.type{
//
//
//            case .Landmark?:
//                if dataStoreItem.value.trimmingCharacters(in: .whitespaces) == ""{
//                    validHandler(userModel, ConstantTexts.enterEmail, false)
//                    return
//                }else if HHelper.isValidEmail(dataStoreItem.value) == false{
//                    validHandler(userModel, ConstantTexts.address, false)
//                    return
//                }
//                userModel. = dataStoreItem.value.trimmingCharacters(in: .whitespaces)
//
//
//            case .Password?:
//                if dataStoreItem.value.trimmingCharacters(in: .whitespaces) == ""{
//                    validHandler(userModel,ConstantTexts.password,false)
//                    return
//                }else if dataStoreItem.value.count < 6{
//                    validHandler(userModel, ConstantTexts.validPassword, false)
//                    return
//                }
//                userModel.password = dataStoreItem.value.trimmingCharacters(in: .whitespaces)
//
//
//            case .none:
//                break
//
//            case .some(_):
//                break
//
//
//            }
//        }
//
//        validHandler(userModel, String(), true)
    }
    
    
}
