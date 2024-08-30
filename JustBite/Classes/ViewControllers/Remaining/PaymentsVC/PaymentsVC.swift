//
//  PaymentsVC.swift
//  JustBite
//
//  Created by Aman on 16/05/19.
//  Copyright © 2019 Mobulous. All rights reserved.
//

import UIKit
import RealmSwift

class PaymentsVC:BaseViewController,backToPayment {
   
    
    //MARK: - IBOutlets
    @IBOutlet weak var lblJustBiteCredit: UILabel!
    
    @IBOutlet weak var lblMyPayment: UILabel!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var btnAddCreditCard: UIButton!
    
    @IBOutlet weak var lblTitle: UILabel!
    
    @IBOutlet weak var btnConfirmRef: UIButton!
    //MARK: - Variables
    let macroObj = MacrosForAll.sharedInstanceMacro
    let alamoFireObj = AlamofireWrapper.sharedInstance
    let realm = try! Realm()
    var CardModelArray = [CardModel]()
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    
    //MARK: - View life cycle methods
    //TODO: View did load
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        initialSetup()
    }
    
    
    //TODO: View Will appear
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        navigationSetUpView()
       
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        navigationSetUpView()
    }
    
    //TODO: View will layout Subviews
    override func viewDidLayoutSubviews() {
        
        gradientLayer.frame = self.GradinetView.bounds
    }
    
    
    @IBAction func btnCreditCardTapped(_ sender: UIButton) {
        let viewC = UIStoryboard(name: "PopUps", bundle: nil).instantiateViewController(withIdentifier: AddCardVC.className) as! AddCardVC
        viewC.obj = self
        self.navigationController?.present(viewC, animated: true, completion: nil)
        
        
    }
    
    @objc func btnDeleteTap(_sender: UIButton) {
        _ = SweetAlert().showAlert(APP_NAME, subTitle: ConstantTexts.deleteReq, style: AlertStyle.warning, buttonTitle:ConstantTexts.cancel, buttonColor: AppColor.themeColor , otherButtonTitle:  ConstantTexts.Ok,  otherButtonColor: AppColor.stepperColor) { (isOtherButton) -> Void in
            if isOtherButton == true {
                print("Cancel Button  Pressed", terminator: "")
            }
            else
            {
                 self.deleteCardService(cardId:self.CardModelArray[_sender.tag].id,index:_sender.tag)
            }
            
        }
       
    }
    func callApi() {
        macroObj.hideLoaderEmpty(view: collectionView)
        getCardList()
    }
    
}
