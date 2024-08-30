//
//  RestaurentReviewModel.swift
//  JustBite
//
//  Created by Aman on 23/06/19.
//  Copyright © 2019 Mobulous. All rights reserved.
//

import Foundation
class RestaurentReviewModel{
    var user_name = String()
    var rating = Double()
    var review = String()
    init(user_name:String,rating:Double,review:String){
        self.user_name = user_name
        self.rating = rating
        self.review = review
    }
    
}
