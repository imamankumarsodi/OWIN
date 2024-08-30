//
//  OfferListDataModel.swift
//  JustBite
//
//  Created by Aman on 23/06/19.
//  Copyright © 2019 Mobulous. All rights reserved.
//

import Foundation
class OfferListDataModel {
    var res_name = String()
    var id = Int()
    var restorent_id = Int()
    var type = Int()
    var thumbnail = String()
    var valid_date  = String()
    var discount = Int()
    var note = String()
    init(id: Int,restorent_id:Int,type:Int,thumbnail:String,valid_date:String,discount:Int,note:String,res_name:String){
        self.id = id
        self.restorent_id = restorent_id
        self.type = type
        self.thumbnail = thumbnail
        self.res_name = res_name
        self.valid_date = valid_date
        self.discount = discount
        self.note = note
    }
}


class TopupList {
    var description:String!
    var id: Int!
    var price:Int!
    var isSelected = Bool()
    init(description:String,id:Int,price:Int,isSelected:Bool) {
        self.description = description
        self.id = id
        self.price = price
        self.isSelected = isSelected
    }
    
}
    
    
    class TopupHistoryList {
        var description:String!
        var id = Int()
        var price = Int()
         var created_at = String()
        var type = String()
        init(description:String,id:Int,price:Int,created_at:String,type:String) {
            self.description = description
            self.id = id
            self.price = price
            self.created_at = created_at
            self.type = type
            
        }
}
