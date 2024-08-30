//
//  VarificationVC.swift
//  JustBite
//
//  Created by Aman on 07/05/19.
//  Copyright © 2019 Mobulous. All rights reserved.
//

import UIKit
import RealmSwift

class VarificationVC: BaseViewController {

    
    //MARK: - IBOutlets
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var otpView: VPMOTPView!
    @IBOutlet weak var btnSubmit: UIButton!
    @IBOutlet weak var lblFooter: UILabel!
    
    //MARK: - Variables
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    var enteredOtp: String = ""
    var phoneNumber = String()
    var countryCode = String()
    var varificationCode = String()
    let macroObj = MacrosForAll.sharedInstanceMacro
    let alamoFireObj = AlamofireWrapper.sharedInstance
    var dataDict = [String:AnyObject]()
    let realm = try! Realm()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        initialSetup()
    }
    
    //TODO: View Will appear
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
         navigationSetup()
        
    }
    
    //TODO: View will layout Subviews
    override func viewDidLayoutSubviews() {
        
        gradientLayer.frame = self.GradinetView.bounds
    }
    
    @IBAction func btnSubmitTapped(_ sender: UIButton) {
        
        if enteredOtp == String(){
            _ = SweetAlert().showAlert(macroObj.appName, subTitle: ConstantTexts.enterNewOTP, style: AlertStyle.error)
        }else{
            varifyPhone(otpString:enteredOtp)
        }
        
       
    }
    
    
    @objc func tapFunction(sender:UITapGestureRecognizer) {
        print("tap working")
        resendOTP()
    }
    
}
