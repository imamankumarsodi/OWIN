//
//  MyOrderOnGoingHeaderView.swift
//  JustBite
//
//  Created by Aman on 16/05/19.
//  Copyright © 2019 Mobulous. All rights reserved.
//

import UIKit

class MyOrderOnGoingHeaderView: UIView {
    @IBOutlet weak var btnTap: UIButton!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblTime: UILabel!
    @IBOutlet weak var btnCancelRef: UIButton!
    
    @IBOutlet weak var calTime: UILabel!
    @IBOutlet weak var lblPendingStepper: UILabel!
    
    @IBOutlet weak var lblPendingStatus: UILabel!
    
    @IBOutlet weak var viewPToC: UIView!
    
    @IBOutlet weak var lblConfirmedStepper: UILabel!
    
    @IBOutlet weak var viewCToK: UIView!
    
    @IBOutlet weak var lblConfirmedStatus: UILabel!
    
    @IBOutlet weak var lblInTheKitchenStep: UILabel!
    
    @IBOutlet weak var lblInTheKitchenStatus: UILabel!
    
    @IBOutlet weak var viewIToO: UIView!
    
    @IBOutlet weak var lblOutForDeliverStepper: UILabel!
    
    @IBOutlet weak var lblOutForDeliveryStatus: UILabel!
    
    @IBOutlet weak var viewOToD: UIView!
    
    @IBOutlet weak var lblDeliveredStatus: UILabel!
    @IBOutlet weak var lblDeliveredStepper: UILabel!
    
    @IBOutlet weak var statusLbl: UIView!
    @IBOutlet weak var imgView: UIImageView!
    
    @IBOutlet weak var dateTimeLbl: UILabel!
    var onGoingDataModelItemCancelTime = OnGoingDataModel(address: String(), cancel_status: Int(), cancel_time: Int(), deliveryStatus: String(), delivery_peroson: String(), discount: Double(), expected_delivery_time: String(), note: String(), orderDate: String(), order_id: Int(), order_number: String(), order_place_time: String(), payment_type: String(), phone_number: String(), price: Double(), restaurant_image: String(), restaurant_name: String(), totalPrice: Double(), isSelected: Bool(), orderMenu: [orderMenuDataModel](), delivered_time: String(), restaurent_id: Int(), eat_option: Double(), vist_date: String(), vist_time: String(), pickup_date: String(), pickup_time: String(), no_of_people: Double(), latitude: String(), longitude: String())
    
    var timer:Timer?
    var count = 0
    
    /*
     // Only override draw() if you perform custom drawing.
     // An empty implementation adversely affects performance during animation.
     override func draw(_ rect: CGRect) {
     // Drawing code
     }
     */
    
    
    
    @objc func update() {
        if(count > 0) {
            count = count - 1
            print(count)
            onGoingDataModelItemCancelTime.cancel_time = count
            printSecondsToHoursMinutesSeconds (seconds:count)
            
            if count<10{
                // lblRecordingTime.text = "00:0\(count)"
            }else{
                // lblRecordingTime.text = "00:\(count)"
            }
        }
        else{
            
            stopTimer()
            
        }
    }
    
    
    func stopTimer(){
        timer?.invalidate()
        timer = nil
        btnCancelRef.isHidden = true
        lblTime.isHidden = true
    }
    
    
    func printSecondsToHoursMinutesSeconds (seconds:Int) -> () {
        let (h, m, s) = secondsToHoursMinutesSeconds (seconds: seconds)
        print ("\(h) Hours, \(m) Minutes, \(s) Seconds")
        if s>9{
            lblTime.text = "0\(m):\(s)"
        }else{
            lblTime.text = "0\(m):0\(s)"
        }
        
    }
    
    func secondsToHoursMinutesSeconds (seconds : Int) -> (Int, Int, Int) {
        return (seconds / 3600, (seconds % 3600) / 60, (seconds % 3600) % 60)
    }
    
}

