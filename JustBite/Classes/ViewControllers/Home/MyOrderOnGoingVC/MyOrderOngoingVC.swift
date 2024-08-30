//
//  MyOrderOngoingVC.swift
//  JustBite
//
//  Created by Aman on 16/05/19.
//  Copyright © 2019 Mobulous. All rights reserved.
//

import UIKit
import RealmSwift
import CoreLocation
class MyOrderOngoingVC: BaseViewController {
    
    //MARK: - IBOutlets
    @IBOutlet weak var tblViewHome: UITableView!
    @IBOutlet weak var viewBtn: UIView!
    @IBOutlet weak var btnOnGoingRef: UIButton!
    @IBOutlet weak var btnPreviousRef: UIButton!
    @IBOutlet weak var btnUpcoming: UIButton!
    
    var locationManager = CLLocationManager()
    var lat = String()
    var long = String()
    
    // let header:InnerTableViewHeader = Bundle.main.loadNibNamed(InnerTableViewHeader.className, owner: self, options: nil)!.first! as! InnerTableViewHeader
    
    
    let macroObj = MacrosForAll.sharedInstanceMacro
    let alamoFireObj = AlamofireWrapper.sharedInstance
    
    var onGoingModelArray = [OnGoingDataModel]()
    var upComingModelArray = [OnGoingDataModel]()
    var previousModelArray = [OnGoingDataModel]()
    var btnTag = 2
    
    var refreshControl: UIRefreshControl {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(self.handleRefresh(_:)), for: UIControl.Event.valueChanged)
        refreshControl.tintColor = AppColor.themeColor
        return refreshControl
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
        self.macroObj.hideLoaderEmpty(view: self.tblViewHome)
        self.macroObj.hideLoaderNet(view: self.tblViewHome)
        self.macroObj.hideWentWrong(view: self.tblViewHome)
        navigationSetUpView()
        
    }
    
    //TODO: View will layout Subviews
    override func viewDidLayoutSubviews() {
        
        gradientLayer.frame = self.GradinetView.bounds
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
       
        previousOrderService()
        
//        let realm = try! Realm()
//        if let userInfo = realm.objects(SignupDataModel.self).first{
//            if userInfo.id == ""{
//                _ = SweetAlert().showAlert(APP_NAME, subTitle: ConstantTexts.LoginRwq, style: AlertStyle.warning, buttonTitle:ConstantTexts.cancel, buttonColor: AppColor.themeColor , otherButtonTitle:  ConstantTexts.Ok,  otherButtonColor: AppColor.stepperColor) { (isOtherButton) -> Void in
//                    if isOtherButton == true {
//                        print("Cancel Button  Pressed", terminator: "")
//                        let homeVC = AppStoryboard.tabbarClass as! TabBarViewC
//                        homeVC.selectedIndex = 0
//                        
//                        
//                    }
//                    else
//                    {
//                        super.moveToNextViewCViaRoot(name:"Auth",withIdentifier: LoginVC.className)
//                    }
//                    
//                }
//            }else{
//                
//                if let status = UserDefaults.standard.value(forKey: "ORDER_STATUS") as? String{
//                    if status == "DELIVERED"{
//                        self.btnTag = 2
//                        self.macroObj.hideLoaderEmpty(view: self.tblViewHome)
//                        self.macroObj.hideLoaderNet(view: self.tblViewHome)
//                        self.macroObj.hideWentWrong(view: self.tblViewHome)
//                        btnPreviousRef.titleLabel?.font = AppFont.Semibold.size(AppFontName.SourceSansPro, size: 16)
//                        btnPreviousRef.setTitleColor(AppColor.whiteColor, for: .normal)
//                        btnPreviousRef.backgroundColor = AppColor.themeColor
//                        btnPreviousRef.setTitle("Previous", for: .normal)
//                        
//                        btnOnGoingRef.titleLabel?.font = AppFont.Semibold.size(AppFontName.SourceSansPro, size: 16)
//                        btnOnGoingRef.setTitleColor(AppColor.textColor, for: .normal)
//                        btnOnGoingRef.backgroundColor = AppColor.whiteColor
//                        btnOnGoingRef.setTitle("Ongoing", for: .normal)
//                        previousOrderService()
//                         self.tblViewHome.reloadData()
//                    }
//                    else if status == "Pending"{
//                        self.btnTag = 3
//                        self.macroObj.hideLoaderEmpty(view: self.tblViewHome)
//                        self.macroObj.hideLoaderNet(view: self.tblViewHome)
//                        self.macroObj.hideWentWrong(view: self.tblViewHome)
//                        self.macroObj.hideLoaderEmpty(view: self.tblViewHome)
//                        self.macroObj.hideLoaderNet(view: self.tblViewHome)
//                        self.macroObj.hideWentWrong(view: self.tblViewHome)
//                        
//                        btnUpcoming.titleLabel?.font = AppFont.Semibold.size(AppFontName.SourceSansPro, size: 16)
//                        btnUpcoming.setTitleColor(AppColor.whiteColor, for: .normal)
//                        btnUpcoming.backgroundColor = AppColor.stepperColor
//                        btnUpcoming.setTitle("Upcoming", for: .normal)
//                     
//                        
//                        
//                        btnPreviousRef.titleLabel?.font = AppFont.Semibold.size(AppFontName.SourceSansPro, size: 16)
//                        btnPreviousRef.setTitleColor(AppColor.whiteColor, for: .normal)
//                        btnPreviousRef.backgroundColor = AppColor.themeColor
//                        btnPreviousRef.setTitle("Previous", for: .normal)
//                        
//                        btnOnGoingRef.titleLabel?.font = AppFont.Semibold.size(AppFontName.SourceSansPro, size: 16)
//                        btnOnGoingRef.setTitleColor(AppColor.textColor, for: .normal)
//                        btnOnGoingRef.backgroundColor = AppColor.whiteColor
//                        btnOnGoingRef.setTitle("Ongoing", for: .normal)
//                       
//                         upGoingOrderService()
//                        self.tblViewHome.reloadData()
//                    }
//                    else{
//                        self.btnTag = 1
//                        self.macroObj.hideLoaderEmpty(view: self.tblViewHome)
//                        self.macroObj.hideLoaderNet(view: self.tblViewHome)
//                        self.macroObj.hideWentWrong(view: self.tblViewHome)
//                        btnOnGoingRef.titleLabel?.font = AppFont.Semibold.size(AppFontName.SourceSansPro, size: 16)
//                        btnOnGoingRef.setTitleColor(AppColor.whiteColor, for: .normal)
//                        btnOnGoingRef.backgroundColor = AppColor.themeColor
//                        btnOnGoingRef.setTitle("Ongoing", for: .normal)
//                        
//                        btnPreviousRef.titleLabel?.font = AppFont.Semibold.size(AppFontName.SourceSansPro, size: 16)
//                        btnPreviousRef.setTitleColor(AppColor.textColor, for: .normal)
//                        btnPreviousRef.backgroundColor = AppColor.whiteColor
//                        btnPreviousRef.setTitle("Previous", for: .normal)
//                        self.onGoingOrderService()
//                         self.tblViewHome.reloadData()
//                    }
//                }
//                
//               
//            }
//        }else{
//            _ = SweetAlert().showAlert(APP_NAME, subTitle: ConstantTexts.LoginRwq, style: AlertStyle.warning, buttonTitle:ConstantTexts.cancel, buttonColor: AppColor.themeColor , otherButtonTitle:  ConstantTexts.Ok,  otherButtonColor: AppColor.stepperColor) { (isOtherButton) -> Void in
//                if isOtherButton == true {
//                    print("Cancel Button  Pressed", terminator: "")
//                    let homeVC = AppStoryboard.tabbarClass as! TabBarViewC
//                    homeVC.selectedIndex = 0
//                }
//                else
//                {
//                    super.moveToNextViewCViaRoot(name:"Auth",withIdentifier: LoginVC.className)
//                }
//                
//            }
//            print("do nothing")
//        }
        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
      //  ScreeNNameClass.shareScreenInstance.screenName = String()
    }
    
    @IBAction func btnChoiceTapped(_ sender: UIButton) {
        
        self.btnTag = sender.tag
       // self.selectedSection = -1
        
        if self.btnTag == 1{
            self.macroObj.hideLoaderEmpty(view: self.tblViewHome)
            self.macroObj.hideLoaderNet(view: self.tblViewHome)
            self.macroObj.hideWentWrong(view: self.tblViewHome)
            btnOnGoingRef.titleLabel?.font = AppFont.Semibold.size(AppFontName.SourceSansPro, size: 16)
            btnOnGoingRef.setTitleColor(AppColor.whiteColor, for: .normal)
            btnOnGoingRef.backgroundColor = AppColor.stepperColor
            btnOnGoingRef.setTitle("Ongoing", for: .normal)
            
            btnPreviousRef.titleLabel?.font = AppFont.Semibold.size(AppFontName.SourceSansPro, size: 16)
            btnPreviousRef.setTitleColor(AppColor.placeHolderColor, for: .normal)
            btnPreviousRef.backgroundColor = AppColor.whiteColor
            btnPreviousRef.setTitle("Previous", for: .normal)
            
            
            btnUpcoming.titleLabel?.font = AppFont.Semibold.size(AppFontName.SourceSansPro, size: 16)
            btnUpcoming.setTitleColor(AppColor.placeHolderColor, for: .normal)
            btnUpcoming.backgroundColor = AppColor.whiteColor
            btnUpcoming.setTitle("Upcoming", for: .normal)
            self.onGoingOrderService()
        }
        else if self.btnTag == 2{
            self.macroObj.hideLoaderEmpty(view: self.tblViewHome)
            self.macroObj.hideLoaderNet(view: self.tblViewHome)
            self.macroObj.hideWentWrong(view: self.tblViewHome)
            btnPreviousRef.titleLabel?.font = AppFont.Semibold.size(AppFontName.SourceSansPro, size: 16)
            btnPreviousRef.setTitleColor(AppColor.whiteColor, for: .normal)
            btnPreviousRef.backgroundColor = AppColor.stepperColor
            btnPreviousRef.setTitle("Previous", for: .normal)
            
            btnOnGoingRef.titleLabel?.font = AppFont.Semibold.size(AppFontName.SourceSansPro, size: 16)
            btnOnGoingRef.setTitleColor(AppColor.placeHolderColor, for: .normal)
            btnOnGoingRef.backgroundColor = AppColor.whiteColor
            btnOnGoingRef.setTitle("Ongoing", for: .normal)
            
            btnUpcoming.titleLabel?.font = AppFont.Semibold.size(AppFontName.SourceSansPro, size: 16)
            btnUpcoming.setTitleColor(AppColor.placeHolderColor, for: .normal)
            btnUpcoming.backgroundColor = AppColor.whiteColor
            btnUpcoming.setTitle("Upcoming", for: .normal)
            previousOrderService()
        }
        else {
            self.macroObj.hideLoaderEmpty(view: self.tblViewHome)
            self.macroObj.hideLoaderNet(view: self.tblViewHome)
            self.macroObj.hideWentWrong(view: self.tblViewHome)
            btnUpcoming.titleLabel?.font = AppFont.Semibold.size(AppFontName.SourceSansPro, size: 16)
            btnUpcoming.setTitleColor(AppColor.whiteColor, for: .normal)
            btnUpcoming.backgroundColor = AppColor.stepperColor
            btnUpcoming.setTitle("Upcoming", for: .normal)
            
            
            btnOnGoingRef.titleLabel?.font = AppFont.Semibold.size(AppFontName.SourceSansPro, size: 16)
            btnOnGoingRef.setTitleColor(AppColor.placeHolderColor, for: .normal)
            btnOnGoingRef.backgroundColor = AppColor.whiteColor
            btnOnGoingRef.setTitle("Ongoing", for: .normal)
           
            
            btnPreviousRef.titleLabel?.font = AppFont.Semibold.size(AppFontName.SourceSansPro, size: 16)
            btnPreviousRef.setTitleColor(AppColor.placeHolderColor, for: .normal)
            btnPreviousRef.backgroundColor = AppColor.whiteColor
            btnPreviousRef.setTitle("Previous", for: .normal)
            upGoingOrderService()
        }
        
        
        self.tblViewHome.reloadData()
        
    }
    
    
    
    @objc func tapSectionBtn(sender:UIButton){
        if btnTag == 1{
            if onGoingModelArray[sender.tag].isSelected == true{
                onGoingModelArray[sender.tag].isSelected = false
            }else{
                onGoingModelArray[sender.tag].isSelected = true
            }
        }
        else if btnTag == 2{
            if previousModelArray[sender.tag].isSelected == true{
                previousModelArray[sender.tag].isSelected = false
            }else{
                previousModelArray[sender.tag].isSelected = true
            }
        }
        else{
            if upComingModelArray[sender.tag].isSelected == true{
                upComingModelArray[sender.tag].isSelected = false
            }else{
                upComingModelArray[sender.tag].isSelected = true
            }
        }
        
        self.tblViewHome.reloadData()

        
    }
    
    @objc func btnReorderRef(sender:UIButton){
       reOrderService(order_id:self.previousModelArray[sender.tag].order_number)
    }
    
    @objc func btnCancelTapped(sender:UIButton){
        
        _ = SweetAlert().showAlert(APP_NAME, subTitle: ConstantTexts.CancelOrder, style: AlertStyle.warning, buttonTitle:ConstantTexts.cancel, buttonColor: AppColor.themeColor , otherButtonTitle:  ConstantTexts.Ok,  otherButtonColor: AppColor.stepperColor) { (isOtherButton) -> Void in
            if isOtherButton == true {
                print("Cancel Button  Pressed", terminator: "")
            }
            else
            {
                self.cancelOrderService(order_id: self.onGoingModelArray[sender.tag].order_number,index:sender.tag)
            }
            
        }
        
        
        
    }
    
    
    @objc func tapShareReviews(sender:UIButton){
        
        let viewC = UIStoryboard(name: "Remaining", bundle: nil).instantiateViewController(withIdentifier: ShareReviewVC.className) as! ShareReviewVC
        
        viewC.id = String(self.previousModelArray[sender.tag].restaurent_id)
        viewC.order_id = String(self.previousModelArray[sender.tag].order_id)
        
        self.navigationController?.pushViewController(viewC, animated: true)
       
    }
    
    @objc func handleRefresh(_ refreshControl: UIRefreshControl) {
        //filterStatus = false
        macroObj.hideLoaderEmpty(view: self.tblViewHome)
        macroObj.hideLoaderNet(view: self.tblViewHome)
        macroObj.hideWentWrong(view: self.tblViewHome)
        
        if btnTag == 1{
            onGoingOrderService()
        }
        else if btnTag == 2{
            previousOrderService()
        }
        else{
            upGoingOrderService()
        }
        
        refreshControl.endRefreshing()
    }
    
    
    @objc func reloadHomeApi(_ notification: Notification){
        self.btnTag = 1
        self.macroObj.hideLoaderEmpty(view: self.tblViewHome)
        self.macroObj.hideLoaderNet(view: self.tblViewHome)
        self.macroObj.hideWentWrong(view: self.tblViewHome)
        btnOnGoingRef.titleLabel?.font = AppFont.Semibold.size(AppFontName.SourceSansPro, size: 16)
        btnOnGoingRef.setTitleColor(AppColor.whiteColor, for: .normal)
        btnOnGoingRef.backgroundColor = AppColor.themeColor
        btnOnGoingRef.setTitle("Ongoing", for: .normal)
        
        btnPreviousRef.titleLabel?.font = AppFont.Semibold.size(AppFontName.SourceSansPro, size: 16)
        btnPreviousRef.setTitleColor(AppColor.textColor, for: .normal)
        btnPreviousRef.backgroundColor = AppColor.whiteColor
        btnPreviousRef.setTitle("Previous", for: .normal)
        onGoingOrderService()
    }
    
    
    @objc func reloadPastApi(_ notification: Notification){
        self.btnTag = 2
        self.macroObj.hideLoaderEmpty(view: self.tblViewHome)
        self.macroObj.hideLoaderNet(view: self.tblViewHome)
        self.macroObj.hideWentWrong(view: self.tblViewHome)
        btnPreviousRef.titleLabel?.font = AppFont.Semibold.size(AppFontName.SourceSansPro, size: 16)
        btnPreviousRef.setTitleColor(AppColor.whiteColor, for: .normal)
        btnPreviousRef.backgroundColor = AppColor.themeColor
        btnPreviousRef.setTitle("Previous", for: .normal)
        
        btnOnGoingRef.titleLabel?.font = AppFont.Semibold.size(AppFontName.SourceSansPro, size: 16)
        btnOnGoingRef.setTitleColor(AppColor.textColor, for: .normal)
        btnOnGoingRef.backgroundColor = AppColor.whiteColor
        btnOnGoingRef.setTitle("Ongoing", for: .normal)
        previousOrderService()
    }
    
}
