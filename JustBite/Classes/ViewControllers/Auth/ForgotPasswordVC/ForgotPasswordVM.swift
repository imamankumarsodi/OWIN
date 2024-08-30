//
//  ForgotPasswordVM.swift
//  JustBite
//
//  Created by Aman on 06/05/19.
//  Copyright © 2019 Mobulous. All rights reserved.
//

import Foundation
import UIKit

class ForgotPasswordModeling:LoginModeling{
    func prepareDataSource() -> [DataStoreStruct] {
       var dataStore = [DataStoreStruct]()
        dataStore.append(DataStoreStruct(title: ConstantTexts.forgetEmailPlaceHoler, placeholder: ConstantTexts.forgetEmailPlaceHoler, value: String(), type: SignUpType.Email))
    return dataStore
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
            case .none:
                break
            case .some(_):
                break
            }
        }
    }
    
    
}
