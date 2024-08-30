//
//  RestaurentDataModelForHome.swift
//  JustBite
//
//  Created by Aman on 17/06/19.
//  Copyright © 2019 Mobulous. All rights reserved.
//

import Foundation
class RestaurentDataModelForHome{
    
    
    //FOR OFFERS
    var min_order_value = Int()
    var note = String()
    var discount = Int()
    var type = Int()
    var offer_id = Int()
    var valid_date = String()
    var thumbnail = String()
    var res_name = String()
    var res_address = String()
    var delivery_time = String()
    
    var latitude = String()
    var longitude = String()
    
    var rating : String
    var address : String
    var description : String
    var id : String
    var img : String
    var is_favorite : String
    var name : String
    var review : String
    var cuisines = [String]()
    var cuisineString : String
    
    var latitudeCur = String()
    var longitudeCur = String()
    
    
    
    init(rating:String,address:String,description:String,id:String,img:String,is_favorite:String,name:String,review:String,cuisines:[String],cuisineString:String,min_order_value:Int,note:String,discount:Int,type:Int,offer_id:Int,valid_date:String,thumbnail:String,res_name:String,res_address:String,delivery_time:String,longitude:String,latitude:String,latitudeCur:String,longitudeCur:String){
        self.rating = rating
        self.address = address
        self.description = description
        self.id = id
        self.img = img
        self.is_favorite = is_favorite
        self.name = name
        self.review = review
        self.cuisines = cuisines
        self.cuisineString = cuisineString
        
        
        self.min_order_value = min_order_value
        self.note = note
        self.discount = discount
        self.type = type
        self.offer_id = offer_id
        self.valid_date = valid_date
        self.thumbnail = thumbnail
        self.res_name = res_name
        self.res_address = res_address
        self.delivery_time = delivery_time
        
         self.latitude = latitude
         self.longitude = longitude
        
        self.latitudeCur = latitudeCur
        self.longitudeCur = longitudeCur
    }
}

class CategoryDataModel{
    var type = String()
    var id = String()
    var menuCount = String()
    var name = String()
    var isSelected = Bool()
    var index = Int()
    init(type:String,id:String,menuCount:String,name:String,isSelected:Bool,index:Int){
        self.type = type
        self.id = id
        self.menuCount = menuCount
        self.name = name
        self.isSelected = isSelected
        self.index = index
    }
}



class OffersDataModel{
    var min_order_value = Int()
    var note = String()
    var restorent_id = Int()
    var discount = Int()
    var type = Int()
    var id = Int()
    var valid_date = String()
    var thumbnail = String()
    var res_name = String()
    var res_address = String()
    var delivery_time = String()
    
    init(min_order_value:Int,note:String,restorent_id:Int,discount:Int,type:Int,id:Int,valid_date:String,thumbnail:String,res_name:String,res_address:String,delivery_time:String){
        
        self.min_order_value = min_order_value
        self.note = note
        self.restorent_id = restorent_id
        self.discount = discount
        self.type = type
        self.id = id
        self.valid_date = valid_date
        self.thumbnail = thumbnail
        self.res_name = res_name
        self.res_address = res_address
        self.delivery_time = delivery_time
    }
    
}
