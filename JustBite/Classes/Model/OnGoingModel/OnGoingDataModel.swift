//
//  OnGoingDataModel.swift
//  JustBite
//
//  Created by Aman on 02/07/19.
//  Copyright © 2019 Mobulous. All rights reserved.
//

import Foundation
class OnGoingDataModel{
    var address = String()
    var cancel_status = Int()
    var cancel_time = Int()
    var deliveryStatus = String()
    var delivery_peroson = String()
    var discount = Double()
    var expected_delivery_time = String()
    var note = String()
    var orderDate = String()
    var order_id = Int()
    var order_number = String()
    var order_place_time = String()
    var payment_type = String()
    var phone_number = String()
    var price = Double()
    var restaurant_image = String()
    var restaurant_name = String()
    var totalPrice = Double()
    var isSelected = Bool()
    var orderMenu = [orderMenuDataModel]()
    var delivered_time = String()
    var restaurent_id = Int()
    var eat_option = Double()
    var vist_date = String()
    var vist_time = String()
    var pickup_date = String()
    var pickup_time = String()
    var no_of_people = Double()
    var latitude = String()
    var longitude = String()
    init(address:String,cancel_status:Int,cancel_time:Int,deliveryStatus:String,delivery_peroson:String,discount:Double,expected_delivery_time:String,note:String,orderDate:String,order_id:Int,order_number:String,order_place_time:String,payment_type:String,phone_number:String,price:Double,restaurant_image: String,restaurant_name:String,totalPrice:Double,isSelected:Bool,orderMenu:[orderMenuDataModel],delivered_time:String,restaurent_id:Int,eat_option:Double,vist_date:String,vist_time:String,pickup_date:String,pickup_time:String,no_of_people:Double,latitude:String,longitude:String){
        self.address = address
        self.cancel_status = cancel_status
        self.cancel_time = cancel_time
        self.deliveryStatus = deliveryStatus
        self.delivery_peroson = delivery_peroson
        self.discount = discount
        self.expected_delivery_time = expected_delivery_time
        self.orderDate = orderDate
        self.order_id = order_id
        self.order_number = order_number
        self.order_place_time = order_place_time
        self.payment_type = payment_type
        self.phone_number = phone_number
        self.price = price
        self.restaurant_image = restaurant_image
        self.payment_type = payment_type
        self.restaurant_name = restaurant_name
        self.totalPrice = totalPrice
        self.isSelected = isSelected
        self.orderMenu = orderMenu
        self.delivered_time = delivered_time
        self.restaurent_id = restaurent_id
        self.eat_option = eat_option
        self.vist_date = vist_date
        self.vist_time = vist_time
        self.pickup_date = pickup_date
        self.pickup_time = pickup_time
        self.no_of_people = no_of_people
        self.latitude = latitude
        self.longitude = longitude
    }
}


class upComingDataModel{
    var address = String()
    var cancel_status = Int()
    var cancel_time = Int()
    var deliveryStatus = String()
    var delivery_peroson = String()
    var discount = Double()
    var expected_delivery_time = String()
    var note = String()
    var orderDate = String()
    var order_id = Int()
    var order_number = String()
    var order_place_time = String()
    var payment_type = String()
    var phone_number = String()
    var price = Double()
    var restaurant_image = String()
    var restaurant_name = String()
    var totalPrice = Double()
    var isSelected = Bool()
    var orderMenu = [orderMenuDataModel]()
    var delivered_time = String()
    var restaurent_id = Int()
    init(address:String,cancel_status:Int,cancel_time:Int,deliveryStatus:String,delivery_peroson:String,discount:Double,expected_delivery_time:String,note:String,orderDate:String,order_id:Int,order_number:String,order_place_time:String,payment_type:String,phone_number:String,price:Double,restaurant_image: String,restaurant_name:String,totalPrice:Double,isSelected:Bool,orderMenu:[orderMenuDataModel],delivered_time:String,restaurent_id:Int){
        self.address = address
        self.cancel_status = cancel_status
        self.cancel_time = cancel_time
        self.deliveryStatus = deliveryStatus
        self.delivery_peroson = delivery_peroson
        self.discount = discount
        self.expected_delivery_time = expected_delivery_time
        self.orderDate = orderDate
        self.order_id = order_id
        self.order_number = order_number
        self.order_place_time = order_place_time
        self.payment_type = payment_type
        self.phone_number = phone_number
        self.price = price
        self.restaurant_image = restaurant_image
        self.payment_type = payment_type
        self.restaurant_name = restaurant_name
        self.totalPrice = totalPrice
        self.isSelected = isSelected
        self.orderMenu = orderMenu
        self.delivered_time = delivered_time
        self.restaurent_id = restaurent_id
    }
}


class orderMenuDataModel{
    var image = String()
    var item_type = Int()
    var name = String()
    var price = Double()
    var quantity = Int()
    
    init(image:String,item_type:Int,name:String,price:Double,quantity:Int){
        self.image = image
        self.item_type = item_type
        self.name = name
        self.price = price
        self.quantity = quantity
    }
    
}
class CardModel {
    var id = Int()
    var card_cvv = String()
    var card_number = String()
    var user_id = Int()
    var card_name = String()
    var card_exp_month = String()
    var card_exp_year = String()
    
    
    init(id:Int,card_cvv:String,card_number:String,user_id:Int,card_name:String,card_exp_month:String,card_exp_year:String) {
        self.id = id
        self.card_cvv = card_cvv
        self.card_name = card_name
        self.user_id = user_id
        self.card_number = card_number
        self.card_exp_month = card_exp_month
        self.card_exp_year = card_exp_year
    }
}

