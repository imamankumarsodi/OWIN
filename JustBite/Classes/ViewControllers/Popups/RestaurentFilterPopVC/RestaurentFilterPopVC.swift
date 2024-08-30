//
//  RestaurentFilterPopVC.swift
//  JustBite
//
//  Created by Aman on 15/05/19.
//  Copyright © 2019 Mobulous. All rights reserved.
//

import UIKit

protocol VCFinalDelegate {
    func finishPassing(status: String,price:String)
}

class RestaurentFilterPopVC:  BaseViewController {
    
    
    //MARK: - IBOutlets
    @IBOutlet weak var viewMain: UIView!
    @IBOutlet weak var lblHeader: UILabel!
    @IBOutlet weak var viewLine: UIView!
    @IBOutlet weak var lblPriceTitle: UILabel!
    @IBOutlet weak var lblPriceValue: UILabel!
    @IBOutlet weak var sliderRef: UISlider!
    @IBOutlet weak var btnVegRef: UIButton!
    @IBOutlet weak var btnNonVegRef: UIButton!
    @IBOutlet weak var btnCancelRef: UIButton!
    @IBOutlet weak var btnDoneRef: UIButton!
    @IBOutlet weak var viewHeader: UIView!
    var delegate: VCFinalDelegate?
    var currentValue = Int()
    var status = String()
    var price = String()
    let macroObj = MacrosForAll.sharedInstanceMacro
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
            if status != "" || price != ""{
            print(price)
                if price == "0.0"{
                    price = ""
                }
            self.delegate?.finishPassing(status: status, price: price)
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
        self.lblPriceValue.text = "AED \(currentValue).0"
    }
    
    @IBAction func btnVegTapped(_ sender: Any) {
        status = "0"
        btnVegRef.setImage(#imageLiteral(resourceName: "radio_button"), for: .normal)
        btnNonVegRef.setImage(#imageLiteral(resourceName: "un_salected_rb"), for: .normal)
    }
    
    @IBAction func btnNonVegTapped(_ sender: Any) {
        status = "1"
        btnVegRef.setImage(#imageLiteral(resourceName: "un_salected_rb"), for: .normal)
        btnNonVegRef.setImage(#imageLiteral(resourceName: "radio_button"), for: .normal)
    }
}
