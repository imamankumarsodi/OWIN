//
//  MenuListDataModels.swift
//  JustBite
//
//  Created by Aman on 20/06/19.
//  Copyright © 2019 Mobulous. All rights reserved.
//

import Foundation

class CustomizeDataModel{
    var name = String()
    var id = Int()
    var price = Int()
    var isSelected = Bool()
    init(name:String,id:Int,price:Int,isSelected:Bool){
        self.name = name
        self.id = id
        self.price = price
        self.isSelected = isSelected
        
    }
}

class menuItemDataModel{
    var name = String()
    var id = Int()
    var price = Int()
    var img = String()
    var description = String()
    var item_type = Int()
    var quantity = Int()
    var totalQuantity = Int()
    var index = Int()
    var menu_type = Int()
    var type = Int()
    var addon = String()
    var discount = Int()
    var customizeDataModelArray = [CustomizesDataModel]()
    
    init (name:String,id:Int,price:Int,img:String,description:String,item_type:Int,index:Int,quantity:Int,totalQuantity:Int,menu_type:Int,type:Int,discount:Int,customizeDataModelArray:[CustomizesDataModel],addon:String){
        
        self.name = name
        self.id = id
        self.price = price
        self.img = img
        self.description = description
        self.item_type = item_type
        self.index = index
        self.quantity = quantity
        self.totalQuantity = totalQuantity
        self.menu_type = menu_type
        self.type = type
        self.discount = discount
        self.customizeDataModelArray = customizeDataModelArray
        self.addon = addon
        
    }
}



//MODEL FOR CUSTOMIZES

class CustomizesDataModel{
    var itemHeading = String()
    var type = Int()
    var variation = Int()
    var addons = [AddOnDataModel]()
    
    init(itemHeading:String,type:Int,variation:Int,addons:[AddOnDataModel]){
        self.itemHeading = itemHeading
        self.type = type
        self.variation = variation
        self.addons = addons
    }
    
    
    
}

class AddOnDataModel{
    var name = String()
    var id = Int()
    var price = Int()
    var isSelected = Bool()
    init(name:String,id:Int,price:Int,isSelected:Bool){
        self.name = name
        self.id = id
        self.price = price
        self.isSelected = isSelected
        
    }
}

