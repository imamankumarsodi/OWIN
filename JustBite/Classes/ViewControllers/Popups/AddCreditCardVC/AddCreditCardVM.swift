//
//  AddCreditCardVM.swift
//  JustBite
//
//  Created by Aman on 22/05/19.
//  Copyright © 2019 Mobulous. All rights reserved.
//

import Foundation
import UIKit
class AddCardVM:LoginModeling{
    
    func prepareDataSource() -> [DataStoreStruct] {
        var dataSource = [DataStoreStruct]()
        
        dataSource.append(DataStoreStruct(title: ConstantTexts.nameOnCard, placeholder: ConstantTexts.nameOnCard, value: String(), type: SignUpType.Name))
        
        dataSource.append(DataStoreStruct(title: ConstantTexts.cardNumber, placeholder: ConstantTexts.cardNumber, value: String(), type: SignUpType.MobileNumber))
        
        dataSource.append(DataStoreStruct(title: ConstantTexts.yearEx, placeholder: ConstantTexts.yearEx, value: String(), type: SignUpType.MobileNumber))
        
        dataSource.append(DataStoreStruct(title: ConstantTexts.cvvNumber, placeholder: ConstantTexts.cvvNumber, value: String(), type: SignUpType.MobileNumber))
        
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
