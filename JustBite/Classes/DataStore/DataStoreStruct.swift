//
//  DataStoreStruct.swift
//  JustBite
//
//  Created by Aman on 05/05/19.
//  Copyright © 2019 Mobulous. All rights reserved.
//

import Foundation
import UIKit

// MARK: - Login Struct
struct DataStoreStruct{
    
    var title:String!
    var placeholder:String!
    var value:String!
    var type: SignUpType!
    
    init(title:String,placeholder:String,value:String,type:SignUpType){
        self.title = title
        self.placeholder = placeholder
        self.value = value
        self.type = type
    }
    
    mutating func updateValue(inValue:String){
        self.value = inValue
    }
}


//MARK: - Left Menu Struct

struct LeftMenuStruct{
    
    var title:String!
    var image:UIImage!
    var isHidden:Bool!
    var price:String!
    
    init(title:String,image:UIImage,isHidden:Bool,price:
        String){
        self.title = title
        self.image = image
        self.isHidden = isHidden
        self.price = price
    }
   
}


//MARK: - Left Menu Struct

struct ContactUsStruct{
    
    var title:String!
    var image:UIImage!
    
    
    init(title:String,image:UIImage){
        self.title = title
        self.image = image
    }
    
}

