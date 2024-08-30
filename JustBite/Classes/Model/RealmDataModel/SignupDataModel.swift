//
//  SignupDataModel.swift
//  JustBite
//
//  Created by Aman on 16/06/19.
//  Copyright © 2019 Mobulous. All rights reserved.
//

import Foundation
import SwiftyJSON
import RealmSwift
class SignupDataModel:Object{
    @objc dynamic var token_type = String()
    @objc dynamic var expires_in = String()
    @objc dynamic var access_token = String()
    @objc dynamic var refresh_token = String()
    
    @objc dynamic var id = String()
    @objc dynamic var email_id = String()
    @objc dynamic var first_name = String()
    @objc dynamic var last_name = String()
    
    @objc dynamic var phone = String()
    @objc dynamic var facebook_id = String()
    @objc dynamic var google_id = String()
    @objc dynamic var address = String()
    @objc dynamic var address_type = String()
    @objc dynamic var is_phone_verify = String()
    @objc dynamic var signup_by = String()
    @objc dynamic var status = String()
    @objc dynamic var created_at = String()
    @objc dynamic var updated_at = String()
    
    @objc dynamic var country_code = String()
    @objc dynamic var area = String()
    @objc dynamic var pin = String()
    @objc dynamic var landmark = String()
    @objc dynamic var houseOrFlatNo = String()
    @objc dynamic var street = String()
    @objc dynamic var building = String()
    @objc dynamic var floor = String()
    @objc dynamic var apartment = String()
 
    @objc dynamic var xLoc = "en"
    @objc dynamic var wallet = Int()
}




