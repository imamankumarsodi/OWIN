//
//  EditAddressPopUPVC.swift
//  JustBite
//
//  Created by Aman on 22/05/19.
//  Copyright © 2019 Mobulous. All rights reserved.
//

import UIKit
import TPKeyboardAvoiding
import MaterialComponents.MaterialTextFields


protocol BackToCartAdd {
    func backToAddCart(area: String, landmark: String, pincode: String, address: String, lat: String, long: String)
}

class EditAddressPopUPVC:  BaseViewController,SendDataToAddress {
   
    
    
    
    //MARK: - IBOutlets
    
    @IBOutlet weak var lblHeader: UILabel!
    @IBOutlet weak var tblLogin: TPKeyboardAvoidingTableView!
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var btnSubmit: UIButton!
    
    
    @IBOutlet weak var txtArea: MDCTextField!
    
    @IBOutlet weak var txtHouse: MDCTextField!
    
    @IBOutlet weak var txtPin: MDCTextField!
    
    @IBOutlet weak var txtLM: MDCTextField!
    
    
    var textFieldControllerFloatingArea: MDCTextInputControllerUnderline?
    var textFieldControllerFloatingHouse: MDCTextInputControllerUnderline?
    var textFieldControllerFloatingPin: MDCTextInputControllerUnderline?
    var textFieldControllerFloatingLM: MDCTextInputControllerUnderline?
    internal var loginModel: LoginModeling?
    internal var dataStore = [DataStoreStruct]()
    var lat = String()
    var long = String()
    var BackToCartAddObj: BackToCartAdd?
    
    var vc = UIViewController()
    
    //MARK: - View Life Cycle Methods
    //TODO: View didLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        initialSetup()
        // Do any additional setup after loading the view.
    }
    
    //TODO: View Will Appear
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        preferredStatusBarStyle
        super.hideNavigationBar(false)
        
        let colorTop =  UIColor(red: 152.0/255.0, green: 24.0/255.0, blue: 37.0/255.0, alpha: 0.8).cgColor
        
        let colorMid = UIColor(red: 254.0/255.0, green: 116.0/255.0, blue: 47.0/255.0, alpha: 0.8).cgColor
        let colorMid1 = UIColor(red: 255.0/255.0, green: 201.0/255.0, blue: 75.0/255.0, alpha: 0.8).cgColor
        let colorBottom = UIColor(red: 119.0/255.0, green: 180.0/255.0, blue: 87.0/255.0, alpha: 0.8).cgColor
        
        gradientLayer.colors = [colorTop,colorMid,colorMid1,colorBottom]
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.4)
        gradientLayer.endPoint = CGPoint(x: 0.8, y: 0.4)
        
        
        gradientLayer.frame = self.GradinetView.bounds
        
        self.GradinetView.layer.insertSublayer(gradientLayer, at:0)
        
        super.addColorToNavigationBarAndSafeArea(color: gradientLayer, className: VarificationVC.className)
        super.setupNavigationBarTitle("", leftBarButtonsType: [.back], rightBarButtonsType: [])
        
        guard let statusBar = UIApplication.shared.value(forKeyPath: "statusBarWindow.statusBar") as? UIView else { return }
        statusBar.backgroundColor = UIColor.darkGray
        
    }
    
    //TODO: View will layout Subviews
    override func viewDidLayoutSubviews() {
        
        gradientLayer.frame = self.GradinetView.bounds
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        guard let statusBar = UIApplication.shared.value(forKeyPath: "statusBarWindow.statusBar") as? UIView else { return }
        statusBar.backgroundColor = UIColor.darkGray
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        guard let statusBar = UIApplication.shared.value(forKeyPath: "statusBarWindow.statusBar") as? UIView else { return }
        statusBar.backgroundColor = AppColor.themeColor
    }
    
    //MARK: - Actions,Gesture
    //TODO: Save Actions
    
    
    @IBAction func btnSaveTapped(_ sender: UIButton) {
        if sender.tag == 1{
            BackToCartAddObj?.backToAddCart(area: self.txtArea.text!, landmark: self.txtLM.text!, pincode: self.txtPin.text!, address: self.txtHouse.text!, lat: self.lat, long: self.long)
            
             self.navigationController?.popViewController(animated: false)
        }else{
             self.navigationController?.popViewController(animated: false)
        }
       
    }
   
    
    @IBAction func btnLocationTapped(_ sender: UIButton) {
        let viewC = UIStoryboard(name: "Home", bundle: nil).instantiateViewController(withIdentifier: LocationPickerVC.className) as! LocationPickerVC
        viewC.isComing = "EDT_ADDRESS"
        viewC.backEditAddressObj = self
        self.navigationController?.pushViewController(viewC, animated: true)
        //        self.dismiss(animated: true) {
        //            let viewC = UIStoryboard(name: "Home", bundle: nil).instantiateViewController(withIdentifier: LocationPickerVC.className) as! LocationPickerVC
        //            viewC.isComing = "EDT_ADDRESS"
        //            self.navigationController?.pushViewController(viewC, animated: true)
        //        }
        
        
    }
    

    
    func backToAddress(area: String, landmark: String, pincode: String, address: String, lat: String, long: String) {
        print("aman")
        self.txtArea.text = area
        self.txtHouse.text = address
        self.txtPin.text = pincode
        self.lat = lat
        self.long = long
        //self.txtLM.text = landmark

    }
}

