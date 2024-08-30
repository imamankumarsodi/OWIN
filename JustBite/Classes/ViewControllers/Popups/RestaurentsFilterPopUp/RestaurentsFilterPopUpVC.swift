//
//  RestaurentsFilterPopUpVC.swift
//  JustBite
//
//  Created by Aman on 12/05/19.
//  Copyright © 2019 Mobulous. All rights reserved.
//

import UIKit
import DropDown

protocol VCFinalDelegateBackToSearch {
    func finishPassing(vegstatus: String,nonvgstatus:String,price:String,rate:String,cuisineId:String)
}

class RestaurentsFilterPopUpVC:  BaseViewController {
    
    
    //MARK: - IBOutlets
    @IBOutlet weak var viewMain: UIView!
    @IBOutlet weak var lblHeader: UILabel!
    @IBOutlet weak var viewLine: UIView!
    @IBOutlet weak var lblPriceTitle: UILabel!
    @IBOutlet weak var lblPriceValue: UILabel!
    @IBOutlet weak var sliderRef: UISlider!
    @IBOutlet weak var btnVegRef: UIButton!
    @IBOutlet weak var btnNonVegRef: UIButton!
    @IBOutlet weak var lblRating: UILabel!
    @IBOutlet weak var btnCusineRef: UIButton!
    @IBOutlet weak var btnCancelRef: UIButton!
    @IBOutlet weak var btnDoneRef: UIButton!
    @IBOutlet weak var viewHeader: UIView!
    
    @IBOutlet weak var btnRateRef1: UIButton!
    @IBOutlet weak var btnRateRef2: UIButton!
    @IBOutlet weak var btnRateRef3: UIButton!
    @IBOutlet weak var btnRateRef4: UIButton!
    @IBOutlet weak var btnRateRef5: UIButton!
    
    let macroObj = MacrosForAll.sharedInstanceMacro
    var delegate: VCFinalDelegateBackToSearch?
    let dropDown = DropDown()
    var cuisinesNameArray = [String]()
    var cuisinesIdArray = [Int]()
    var currentValue = Int()
    var vegstatus = String()
    var nonvgstatus = String()
    var price = String()
    var index = Int()
    var rate = String()
    var cuisineId = String()
    let alamoFireObj = AlamofireWrapper.sharedInstance
    //MARK: - View Life Cycle Methods
    //TODO: View didLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        initialStup()
        // Do any additional setup after loading the view.
    }
    
    //TODO: View Will Appear
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
   
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        super.hideStatusBar(true)
    }
    
    //MARK: - Actions,Gesture
    //TODO: Save Actions
    
    @IBAction func btnSaveTapped(_ sender: UIButton) {
        if sender.tag == 3{
            if vegstatus != "" || nonvgstatus != "" || price != "" || rate != "" || cuisineId != ""{
                print(price)
                if price == "0.0"{
                    price = ""
                }
                self.delegate?.finishPassing(vegstatus: vegstatus, nonvgstatus: nonvgstatus, price: price, rate: rate, cuisineId: cuisineId)
                dismiss(animated: true, completion: nil)
            }else{
                _ = SweetAlert().showAlert(self.macroObj.appName, subTitle: ConstantTexts.filterMessage, style: AlertStyle.error)
            }
        }else{
            dismiss(animated: true, completion: nil)
        }
        
        
    }
    
    
    @IBAction func sliderRefDrag(_ sender: UISlider) {
        currentValue  = Int(sender.value)
        price = String(sender.value)
        print(price)
        self.lblPriceValue.text = "AED \(currentValue).0"
    }
    
    @IBAction func btnVegTapped(_ sender: Any) {
        
       
        vegstatus = "1"
        nonvgstatus = ""
        btnVegRef.setImage(#imageLiteral(resourceName: "radio_button"), for: .normal)
        btnNonVegRef.setImage(#imageLiteral(resourceName: "un_salected_rb"), for: .normal)
    }
    
    @IBAction func btnNonVegTapped(_ sender: Any) {
        vegstatus = ""
        nonvgstatus = "1"
        btnVegRef.setImage(#imageLiteral(resourceName: "un_salected_rb"), for: .normal)
        btnNonVegRef.setImage(#imageLiteral(resourceName: "radio_button"), for: .normal)
    }
    
    @IBAction func btnShiftTapped(_ sender: UIButton) {
        dropDown.show()
        
    }
    
    @IBAction func btnRateTapped(_ sender: UIButton) {
        rate = String(sender.tag)
        if sender.tag == 1{
            
            btnRateRef1.setImage(#imageLiteral(resourceName: "radio_button"), for: .normal)
            btnRateRef2.setImage(#imageLiteral(resourceName: "un_salected_rb"), for: .normal)
            btnRateRef3.setImage(#imageLiteral(resourceName: "un_salected_rb"), for: .normal)
            btnRateRef4.setImage(#imageLiteral(resourceName: "un_salected_rb"), for: .normal)
            btnRateRef5.setImage(#imageLiteral(resourceName: "un_salected_rb"), for: .normal)
            
            
        }else if sender.tag == 2{
            
            
            
            btnRateRef2.setImage(#imageLiteral(resourceName: "radio_button"), for: .normal)
            btnRateRef1.setImage(#imageLiteral(resourceName: "un_salected_rb"), for: .normal)
            btnRateRef3.setImage(#imageLiteral(resourceName: "un_salected_rb"), for: .normal)
            btnRateRef4.setImage(#imageLiteral(resourceName: "un_salected_rb"), for: .normal)
            btnRateRef5.setImage(#imageLiteral(resourceName: "un_salected_rb"), for: .normal)
            
            
        }else if sender.tag == 3{
            
            btnRateRef3.setImage(#imageLiteral(resourceName: "radio_button"), for: .normal)
            btnRateRef1.setImage(#imageLiteral(resourceName: "un_salected_rb"), for: .normal)
            btnRateRef2.setImage(#imageLiteral(resourceName: "un_salected_rb"), for: .normal)
            btnRateRef4.setImage(#imageLiteral(resourceName: "un_salected_rb"), for: .normal)
            btnRateRef5.setImage(#imageLiteral(resourceName: "un_salected_rb"), for: .normal)
            
            
        }else if sender.tag == 4{
            btnRateRef4.setImage(#imageLiteral(resourceName: "radio_button"), for: .normal)
            btnRateRef1.setImage(#imageLiteral(resourceName: "un_salected_rb"), for: .normal)
            btnRateRef2.setImage(#imageLiteral(resourceName: "un_salected_rb"), for: .normal)
            btnRateRef3.setImage(#imageLiteral(resourceName: "un_salected_rb"), for: .normal)
            btnRateRef5.setImage(#imageLiteral(resourceName: "un_salected_rb"), for: .normal)
        }else{
            btnRateRef5.setImage(#imageLiteral(resourceName: "radio_button"), for: .normal)
            btnRateRef1.setImage(#imageLiteral(resourceName: "un_salected_rb"), for: .normal)
            btnRateRef2.setImage(#imageLiteral(resourceName: "un_salected_rb"), for: .normal)
            btnRateRef3.setImage(#imageLiteral(resourceName: "un_salected_rb"), for: .normal)
            btnRateRef4.setImage(#imageLiteral(resourceName: "un_salected_rb"), for: .normal)
        }
    }
    
    
    
}
