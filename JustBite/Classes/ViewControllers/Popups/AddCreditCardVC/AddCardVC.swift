//
//  AddCardVC.swift
//  JustBite
//
//  Created by Aman on 22/05/19.
//  Copyright © 2019 Mobulous. All rights reserved.
//

import UIKit
import TPKeyboardAvoiding
import MaterialComponents.MaterialTextFields
import RealmSwift

protocol backToPayment {
    func callApi()
}

protocol backToPaymentMode {
    func callApi()
}

class AddCardVC: BaseViewController {
    
    
    //MARK: - IBOutlets
    
    @IBOutlet weak var lblHeader: UILabel!
    @IBOutlet weak var tblLogin: TPKeyboardAvoidingTableView!
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var btnSubmit: UIButton!
    
    
    
    
    
    @IBOutlet weak var txtCardName: MDCTextField!
     var textFieldControllerFloatingCardName: MDCTextInputControllerUnderline?
    
    @IBOutlet weak var txtCardNumber: MDCTextField!
    var textFieldControllerFloatingCardNumber: MDCTextInputControllerUnderline?
    
    @IBOutlet weak var txtMonth: MDCTextField!
    var textFieldControllerFloatingMonth: MDCTextInputControllerUnderline?
    
    @IBOutlet weak var txtYear: MDCTextField!
    var textFieldControllerFloatingYear: MDCTextInputControllerUnderline?
    
    @IBOutlet weak var txtCVV: MDCTextField!
    var textFieldControllerFloatingCVV: MDCTextInputControllerUnderline?
    
    
    internal var loginModel: LoginModeling?
    internal var dataStore = [DataStoreStruct]()
    let macroObj = MacrosForAll.sharedInstanceMacro
    let alamoFireObj = AlamofireWrapper.sharedInstance
    let realm = try! Realm()
    let validation:Validation = Validation.validationManager() as! Validation
    var obj:backToPayment?
    var objMode:backToPaymentMode?
    var isComing = String()
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
        guard let statusBar = UIApplication.shared.value(forKeyPath: "statusBarWindow.statusBar") as? UIView else { return }
        statusBar.backgroundColor = UIColor.darkGray
        
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
        if sender.tag == 2{
        validationSetUp()
        }else{
            self.dismiss(animated: true, completion: nil)
        }
    
    }
    
    
}

