//
//  Notification_Model.swift
//  JustBite
//
//  Created by cst on 02/03/20.
//  Copyright © 2020 Mobulous. All rights reserved.
//

import Foundation
class Notification_Model{
     var title = String()
     var description = String()
     var type = String()
     var order_id = String()
     var res_id = String()
    
    
        init(title:String,description:String,type:String,order_id:String,res_id:String){
            
            self.title = title
            self.description = description
            self.type = type
            self.order_id = order_id
            self.res_id = res_id
            
    }
    
}
