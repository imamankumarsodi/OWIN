//
//  UserModel.swift
//  JustBite
//
//  Created by Aman on 05/05/19.
//  Copyright © 2019 Mobulous. All rights reserved.
//

import Foundation
import ObjectMapper

class UserModel: Mappable {
    
    var name, email, password, countryCode , mobile,facebookId,googleId,identity,oldPassword,newPassword,imageURL :String?
    var otp:Int?
    required init?(map: Map) {
        
    }
    
    init(){
        
    }
    
    func mapping(map: Map) {
        name            <-     map["name"]
        email           <-     map["email"]
        countryCode     <-     map["countryCode"]
        mobile          <-     map["mobile"]
        password        <-     map["password"]
        facebookId      <-     map["faceBookId"]
        googleId        <-     map["googleId"]
        identity        <-     map["identity"]
        otp             <-     map["otp"]
        oldPassword     <-     map["oldPassword"]
        newPassword     <-     map["newPassword"]
        imageURL        <-     map["imageURL"]
        
    }
}
