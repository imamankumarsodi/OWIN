//
//  HomeListingModel.swift
//  JustBite
//
//  Created by Aman on 17/06/19.
//  Copyright © 2019 Mobulous. All rights reserved.
//

import Foundation
class HomeListingModel{
    var HomeListingArr = [RestaurentDataModelForHome]()
    
    init(HomeListingArr:[RestaurentDataModelForHome]){
        self.HomeListingArr = HomeListingArr
    }
}
