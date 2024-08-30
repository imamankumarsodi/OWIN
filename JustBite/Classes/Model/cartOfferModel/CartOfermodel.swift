import Foundation
class CartOfermodel{
    
    var discount = Int()
    var thumbnail = String()
    var id = String()
    var status = String()
    var valid_date = String()
    var img = String()
    var restorent_id = String()
    var type = String()
    var note = String()
    
    init(discount:Int,thumbnail:String,id:String,status:String,valid_date:String,img:String,restorent_id:String,type:String,note:String){
        self.discount = discount
        self.thumbnail = thumbnail
        self.id = id
        self.valid_date = valid_date
        self.img = img
        self.restorent_id = restorent_id
        self.type = type
        self.note = note
    }
}

