//
//  OrderItem.swift
//  JustBite
//
//  Created by Deepti Sharma on 01/08/19.
//  Copyright © 2019 Mobulous. All rights reserved.
//

import Foundation
import RealmSwift

class OrderItem: Object {
    @objc dynamic var restName = Int()
    @objc dynamic var resAddress = String()
    @objc dynamic var columnId = Int()
    @objc dynamic var name = String()
    @objc dynamic var addOns = String()
    @objc dynamic var id = Int()
    @objc dynamic var img = String()
    @objc dynamic var price = Int()
    @objc dynamic var totalPrice = Int()
    @objc dynamic var RestaurentId = String()
    @objc dynamic var RestaurentName = String()
    @objc dynamic var RestaurentAddress = String()
    @objc dynamic var RestaurentDiscount = Int()
    @objc dynamic var RestaurentLat = String()
    @objc dynamic var RestaurentLong = String()
    @objc dynamic var itemType = Int()
    @objc dynamic var totolQuantity = Int()
    @objc dynamic var quantity = Int()
    @objc dynamic var menuCount = Int()
    @objc dynamic var type = String()
  //  @objc dynamic var customizes = List<Int>()
    @objc dynamic var catName = String()
    
}
