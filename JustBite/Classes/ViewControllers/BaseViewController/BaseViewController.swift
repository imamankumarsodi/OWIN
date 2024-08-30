//  BaseViewController.swift
//
//  Created by Sandeep Vishwakarma on 4/16/18.
//  Copyright © 2018 Sandeep. All rights reserved.
//

import Foundation
import UIKit
import RealmSwift

enum UINavigationBarButtonType: Int {
    case back
    case cross
    case done
    case add
    case location
    case show
    case unFavourite
    case favourite
    case icCancel
    case menu
    case cart
    case cartBack
    
    
    var iconImage: UIImage? {
        switch self {
        case .back:  return UIImage(named: "back_button")
        case .cross: return UIImage(named: "icBackW")
        case .done: return UIImage(named: "icDone")
        case .add: return UIImage(named: "")
        case .location: return UIImage(named: "icAddLocation")
        case .show: return UIImage(named: "icShowSave")
        case .unFavourite: return UIImage(named: "icUnselectFav")
        case .favourite: return UIImage(named: "icSelectFav")
        case .icCancel: return UIImage(named: "icCancel")
        case .menu: return UIImage(named: "menu_bar")
        case .cart: return UIImage(named: "cart")
        case .cartBack: return UIImage(named: "back_button")
            
        }
    }
}

protocol BaseViewControllerDelegate {
    func navigationBarButtonDidTapped(_ buttonType: UINavigationBarButtonType)
}

class BaseViewController: UIViewController {
    
    var baseDelegate: BaseViewControllerDelegate?
    private let navButtonWidth = 40.0
    private let edgeInset = CGFloat(10.0)
    private var subControllerName = String()
    internal var GradinetView = UIView()
    internal var  statusbarView = UIView()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.baseDelegate = nil
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    func keyBoardView() -> UIView {
        
        let doneToolbar: UIView = UIView(frame: CGRect(x: 0, y: 0, width: MAIN_SCREEN_WIDTH, height: 40))
        
        let button = UIButton(frame: CGRect(x: 30, y: 0, width: MAIN_SCREEN_WIDTH - 60, height: 30))
        button.setTitle("CONTINUE", for: .normal)
        button.addTarget(self, action: #selector(actionContinue), for: .touchUpInside)
        button.setTitleColor(UIColor(red: 217.0/255.0, green: 80.0/255.0, blue: 99.0/255.0, alpha: 1.0), for: .normal)
        button.backgroundColor = .white
        button.layer.cornerRadius = 10
        
        doneToolbar.addSubview(button)
        
        return doneToolbar
    }
    
    @objc func actionContinue() {
        print("No one can stop me.")
    }
    
    func backViewController() -> UIViewController {
        let numberOfViewControllers: Int = self.navigationController!.viewControllers.count
        if numberOfViewControllers >= 2 {
            return self.navigationController!.viewControllers[numberOfViewControllers - 2]
        }
        return self.navigationController!.viewControllers[numberOfViewControllers-1]
    }
    
    func setupNavigationBarTitle(_ title: String, leftBarButtonsType: [UINavigationBarButtonType], rightBarButtonsType: [UINavigationBarButtonType], titleViewFrame: CGRect = CGRect(x: 0, y: 0, width: 200, height: 44)) {
        
        self.navigationItem.titleView = headerView()
        
        if !title.isEmpty {
            
            self.navigationItem.titleView = createLabel(text: title)
        }
        
        var rightBarButtonItems = [UIBarButtonItem]()
        for rightButtonType in rightBarButtonsType {
            let rightButtonItem = getBarButtonItem(for: rightButtonType, isLeftBarButtonItem: false)
            rightBarButtonItems.append(rightButtonItem)
        }
        if rightBarButtonItems.count > 0 {
            self.navigationItem.rightBarButtonItems = rightBarButtonItems
        }
        var leftBarButtonItems = [UIBarButtonItem]()
        for leftButtonType in leftBarButtonsType {
            let leftButtonItem = getBarButtonItem(for: leftButtonType, isLeftBarButtonItem: true)
            leftBarButtonItems.append(leftButtonItem)
        }
        if leftBarButtonItems.count > 0 {
            self.navigationItem.leftBarButtonItems = leftBarButtonItems
        }
    }
    
    //TODO: Create header view
    
    internal func headerView() -> UIView{
        
        var mainView = CGRect()
        
        if UIDevice.current.screenType == .iPhones_6_6s_7_8{
            mainView = CGRect(origin: CGPoint(x: 0,y :0), size: CGSize(width: 500, height: 65))
        }else if UIDevice.current.screenType == .iPhones_6Plus_6sPlus_7Plus_8Plus{
            mainView = CGRect(origin: CGPoint(x: 0,y :0), size: CGSize(width: 500, height: 65))
        }else if UIDevice.current.screenType == .iPhones_X_XS{
            mainView = CGRect(origin: CGPoint(x: 0,y :0), size: CGSize(width: 500, height: 90))
        }
        else if UIDevice.current.screenType == .iPhone_XR_11{
            mainView = CGRect(origin: CGPoint(x: 0,y :0), size: CGSize(width: 500, height: 90))
        }
        else if UIDevice.current.screenType == .iPhone_XSMax_ProMax{
            mainView = CGRect(origin: CGPoint(x: 0,y :0), size: CGSize(width: 500, height: 90))
        }
        else if UIDevice.current.screenType == .iPhone_11Pro{
            mainView = CGRect(origin: CGPoint(x: 0,y :0), size: CGSize(width: 500, height: 90))
        }
        else if UIDevice.current.screenType == .iPhones_4_4S{
            mainView = CGRect(origin: CGPoint(x: 0,y :0), size: CGSize(width: 500, height: 45))
        }
        else if UIDevice.current.screenType == .iPhones_5_5s_5c_SE{
            mainView = CGRect(origin: CGPoint(x: 0,y :0), size: CGSize(width: 500, height: 50))
        }
        let frame = mainView
        GradinetView = UIView.init(frame: frame)
        GradinetView.backgroundColor = UIColor.black
        
        
        return GradinetView
    }
    
    func getBarButtonItem(for type: UINavigationBarButtonType, isLeftBarButtonItem: Bool) -> UIBarButtonItem {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: Int(navButtonWidth), height: NAVIGATION_BAR_DEFAULT_HEIGHT))
        button.setTitleColor(.black, for: UIControl.State())
        button.titleLabel?.font = UIFont.init(name: "Kefa Regular", size: 10)
        button.titleLabel?.textAlignment = .right
        button.tag = type.rawValue
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: isLeftBarButtonItem ? -edgeInset : edgeInset, bottom: 0, right: isLeftBarButtonItem ? edgeInset : -edgeInset)
        if let iconImage = type.iconImage {
            button.setImage(iconImage, for: UIControl.State())
        } //else if let title = type.title {
        //   button.setTitle(title, for: UIControlState())
        //   button.frame.size.width = 40.0
        // }
        button.addTarget(self, action: #selector(BaseViewController.navigationButtonTapped(_:)), for: .touchUpInside)
        return UIBarButtonItem(customView: button)
    }
    
    func createLabel(text: String) -> UILabel {
        
        let rect = CGRect(origin: CGPoint(x: 0,y :0), size: CGSize(width: 200, height: 44))
        let frame = rect
        let lbl = UILabel.init(frame: frame)
        lbl.text = text
        lbl.numberOfLines = 0
        lbl.textAlignment = NSTextAlignment.center
        lbl.font = AppFont.Semibold.size(AppFontName.SourceSansPro, size: 18.0)
        lbl.textColor = UIColor.white
        
        return lbl
    }
    
    
    func addColorToNavigationBarAndSafeArea(color:CAGradientLayer,className:String){
        subControllerName = className
        ScreeNNameClass.shareScreenInstance.screenName = subControllerName
        if className == "HomeVC" || className == "SearchVC" || className == "MyOrderOngoingVC" || className == "ProfileVC"{
            self.tabBarController?.tabBar.isHidden = false
        }else{
            self.tabBarController?.tabBar.isHidden = true
        }
        
        //self.navigationController?.navigationBar.backgroundColor = color
        self.navigationController?.navigationBar.layer.insertSublayer(color, at: 0)
        //        guard let statusBar = UIApplication.shared.value(forKeyPath: "statusBarWindow.statusBar") as? UIView else { return }
        //        statusBar.layer.insertSublayer(color, at: 0)
        
        if #available(iOS 9.0, *) {
            let app = UIApplication.shared
            let statusBarHeight: CGFloat = app.statusBarFrame.size.height
            
            //            let statusbarView = UIView()
            //  statusbarView.backgroundColor = color
            statusbarView.layer.insertSublayer(color, at: 0)
            view.addSubview(statusbarView)
            
            statusbarView.translatesAutoresizingMaskIntoConstraints = false
            statusbarView.heightAnchor
                .constraint(equalToConstant: statusBarHeight).isActive = true
            statusbarView.widthAnchor
                .constraint(equalTo: view.widthAnchor, multiplier: 1.0).isActive = true
            statusbarView.topAnchor
                .constraint(equalTo: view.topAnchor).isActive = true
            statusbarView.centerXAnchor
                .constraint(equalTo: view.centerXAnchor).isActive = true
        } else {
            guard let statusBar = UIApplication.shared.value(forKeyPath: "statusBarWindow.statusBar") as? UIView else { return }
            // statusBar.backgroundColor = color
            statusBar.layer.insertSublayer(color, at: 0)
        }
        
        
    }
    
    func transparentNavigation(){
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
    }
    
    @objc func navigationButtonTapped(_ sender: AnyObject) {
        guard let buttonType = UINavigationBarButtonType(rawValue: sender.tag) else { return }
        switch buttonType {
        case .back: backButtonTapped()
        case .cross: crossButtonTapped()
        case .done: doneButtonTapped()
        case .add:addButtonTapped()
        case .location:locationButtonTapped()
        case .show: showButtonTapped()
        case .unFavourite: unFavouriteTapped()
        case .favourite: favouriteTapped()
        case .icCancel: cancelTapped()
        case .menu: menuTapped()
        case .cart: cartTapped()
        case .cartBack:
            let viewC = UIStoryboard(name: "Home", bundle: nil).instantiateViewController(withIdentifier: MyCartVC.className) as! MyCartVC
            self.navigationController?.pushViewController(viewC, animated: true)
        }
        //self.baseDelegate?.navigationBarButtonDidTapped(buttonType)
    }
    
    func backButtonTapped() {
        if subControllerName == "MyFavroiteVC"||subControllerName == "OfferVC"||subControllerName == "PaymentsVC"||subControllerName == "SettingsVC"||subControllerName == "HelpAboutUsFaQT_CVC"||subControllerName == "ContactUsVC"||subControllerName == "JustBiteCreditVC"{
            kAppDelegate.openDrawer()
            kAppDelegate.drawerController?.setDrawerState(.closed, animated: true)
        }else{
            if self.navigationController!.viewControllers.count > 1 {
                self.navigationController?.popViewController(animated: true)
            } else {
                self.dismiss(animated: true, completion: nil)
            }
        }
        
    }
    
    func crossButtonTapped() {
        self.backButtonTapped()
    }
    
    func menuTapped() {
        kAppDelegate.openDrawer()
    }
    
    func cartTapped() {
        self.moveToNextViewC(name: "Home", withIdentifier: MyCartVC.className)
    }
    
    
    /* func cartTapped() {
     
     let realm = try! Realm()
     if let userInfo = realm.objects(SignupDataModel.self).first{
     if userInfo.id == ""{
     _ = SweetAlert().showAlert(APP_NAME, subTitle: ConstantTexts.LoginRwq, style: AlertStyle.warning, buttonTitle:ConstantTexts.cancel, buttonColor: AppColor.themeColor , otherButtonTitle:  ConstantTexts.Ok,  otherButtonColor: AppColor.stepperColor) { (isOtherButton) -> Void in
     if isOtherButton == true {
     print("Cancel Button  Pressed", terminator: "")
     //                        self.moveToNextViewCViaRoot(name:"Auth",withIdentifier: LoginVC.className)
     }
     else
     {
     self.moveToNextViewCViaRoot(name:"Auth",withIdentifier: LoginVC.className)
     }
     
     }
     }else{
     self.moveToNextViewC(name: "Home", withIdentifier: MyCartVC.className)
     }
     }else{
     _ = SweetAlert().showAlert(APP_NAME, subTitle: ConstantTexts.LoginRwq, style: AlertStyle.warning, buttonTitle:ConstantTexts.cancel, buttonColor: AppColor.themeColor , otherButtonTitle:  ConstantTexts.Ok,  otherButtonColor: AppColor.stepperColor) { (isOtherButton) -> Void in
     if isOtherButton == true {
     print("Cancel Button  Pressed", terminator: "")
     //                    self.moveToNextViewCViaRoot(name:"Auth",withIdentifier: LoginVC.className)
     }
     else
     {
     self.moveToNextViewCViaRoot(name:"Auth",withIdentifier: LoginVC.className)
     }
     
     }
     print("do nothing")
     }
     
     
     
     
     }*/
    func doneButtonTapped() {
        
    }
    
    func addButtonTapped() {
        
    }
    
    func locationButtonTapped() {
        
    }
    
    func showButtonTapped() {
        
    }
    
    func unFavouriteTapped() {
        
    }
    
    func favouriteTapped() {
        
    }
    
    func cancelTapped() {
        self.backButtonTapped()
    }
    
    @available(iOS, deprecated: 9.0)
    func hideStatusBar(_ hide: Bool) {
        UIApplication.shared.setStatusBarHidden(hide, with: .none)
        guard let statusBar = UIApplication.shared.value(forKeyPath: "statusBarWindow.statusBar") as? UIView else { return }
        statusBar.isHidden = hide
    }
    
    func hideNavigationBar(_ hide: Bool) {
        self.navigationController!.isNavigationBarHidden = hide
    }
    
    func goBackToIndex(_ backIndex: Int) {
        //self.goBackToIndex(backIndex, animated: true)
        
        kAppDelegate.openDrawer()
    }
    
    func goBackToIndex(_ backIndex: Int, animated animate: Bool) {
        if (self.navigationController!.viewControllers.count - backIndex) > 0 {
            let controller: BaseViewController = (self.navigationController!.viewControllers[(self.navigationController!.viewControllers.count - 1 - backIndex)] as! BaseViewController)
            self.navigationController!.popToViewController(controller, animated: animate)
        }
    }
    
    //Get indexpath for tableview
    func getIndexPathFor(sender : AnyObject, tblView : UITableView) -> NSIndexPath? {
        let rect : CGRect = sender.convert(sender.bounds, to: tblView)
        if let indexPath  = tblView.indexPathForRow(at: rect.origin) {
            return indexPath as NSIndexPath?;
        }
        return nil
    }
    
    func addDoneButtonOnKeyboard( textfield : UITextField) {
        let rect = CGRect(origin: CGPoint(x: 0,y :0), size: CGSize(width: MAIN_SCREEN_WIDTH, height: 50))
        let doneToolbar: UIToolbar = UIToolbar(frame: rect)
        doneToolbar.barStyle = UIBarStyle.default
        let flexSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let done: UIBarButtonItem = UIBarButtonItem(title:"Done", style: UIBarButtonItem.Style.done, target: self, action: #selector(tapDone(sender:)))
        doneToolbar.items = [done , flexSpace]
        doneToolbar.sizeToFit()
        textfield.inputAccessoryView = doneToolbar
    }
    
    @objc func tapDone(sender : UIButton) {
        view.endEditing(true)
    }
    
    
    //TODO: Move to next ViewController
    
    func moveToNextViewC(name:String,withIdentifier:String){
        let viewC = UIStoryboard(name: name, bundle: nil).instantiateViewController(withIdentifier: withIdentifier)
        self.navigationController?.pushViewController(viewC, animated: true)
    }
    
    
    
    
    
    
    
    //TODO: Move to home root view controller
    func moveToHomeVC(){
        
        let viewController = AppStoryboard.tabbarClass as! TabBarViewC
        let navigationController = UINavigationController(rootViewController: viewController)
        viewController.selectedIndex = 0
        navigationController.navigationBar.isHidden = true
        APPLICATION.keyWindow?.rootViewController = navigationController
    }
    
    
    //TODO: Move to next via root view controller
    func moveToNextViewCViaRoot(name:String,withIdentifier:String){
        let mainStoryboard: UIStoryboard = UIStoryboard(name: name, bundle: nil)
        let viewController = mainStoryboard.instantiateViewController(withIdentifier: withIdentifier)
        let navigationController = UINavigationController(rootViewController: viewController)
        navigationController.navigationBar.isHidden = true
        APPLICATION.keyWindow?.rootViewController = navigationController
    }
    
    //TODO: present to next ViewController
    
    func presentToNextViewC(name:String,withIdentifier:String){
        let viewC = UIStoryboard(name: name, bundle: nil).instantiateViewController(withIdentifier: withIdentifier)
        self.navigationController?.present(viewC, animated: true, completion: nil)
    }
    
    
    
    
    //    @objc func countrycodeList(_ sender : UIButton) {
    //        let cont = UIStoryboard(name: "Auth", bundle: nil).instantiateViewController(withIdentifier: PinCodeVC.className ) as! PinCodeVC
    //        cont.controller = self
    //        cont.modalPresentationStyle = .custom
    //        self.present(cont, animated: true, completion: nil)
    //    }
    //
    //    func saveResponse( response: SAuthModel){
    //        USER_DEFAULTS.set(response.authToken, forKey:ConstantTexts.authToken.localizedString)
    //        USER_DEFAULTS.set(response.result?.email, forKey:ConstantTexts.email.localizedString)
    //        USER_DEFAULTS.set(response.result?._id, forKey:ConstantTexts.userID.localizedString)
    //        USER_DEFAULTS.set(response.result?.mobile, forKey:ConstantTexts.mobile.localizedString)
    //        USER_DEFAULTS.set(response.result?.countryCode, forKey:ConstantTexts.countryCode.localizedString)
    //        USER_DEFAULTS.set(response.result?.imageURL, forKey:ConstantTexts.profileImage.localizedString)
    //        USER_DEFAULTS.set(response.result?.name, forKey: ConstantTexts.userName.localizedString)
    //        USER_DEFAULTS.set(response.result?.googleId, forKey:ConstantTexts.googleId.localizedString)
    //        USER_DEFAULTS.set(response.result?.faceBookId, forKey: ConstantTexts.faceBookId.localizedString)
    //    }
    //
    //    func saveAddressResponse(response:AddressResponseModel ) {
    //        USER_DEFAULTS.set(response.result, forKey:ConstantTexts.result.localizedString)
    //    }
    //
    //    func attributedStringColor(str: String, color: UIColor) -> String {
    //        let stringValue = str
    //        let changeColorString = [NSAttributedString.Key.foregroundColor: color]
    //        let finalString = NSMutableAttributedString(string: stringValue, attributes: changeColorString)
    //        let strng = finalString.string
    //        return strng
    //    }
    
    
    
    
    
    
}

//MARK: - Screen sizes
extension UIDevice {
    var iPhoneX: Bool {
        UIScreen.main.nativeBounds.height == 2436
        return true
    }
    var iPhone: Bool {
        UIDevice.current.userInterfaceIdiom == .phone
        return true
    }
    
    enum ScreenType: String {
        case iPhones_4_4S = "iPhone 4 or iPhone 4S"
        case iPhones_5_5s_5c_SE = "iPhone 5, iPhone 5s, iPhone 5c or iPhone SE"
        case iPhones_6_6s_7_8 = "iPhone 6, iPhone 6S, iPhone 7 or iPhone 8"
        case iPhones_6Plus_6sPlus_7Plus_8Plus = "iPhone 6 Plus, iPhone 6S Plus, iPhone 7 Plus or iPhone 8 Plus"
        case iPhones_X_XS = "iPhone X or iPhone XS"
        case iPhone_XR_11 = "iPhone XR or iPhone 11"
        case iPhone_XSMax_ProMax = "iPhone XS Max or iPhone Pro Max"
        case iPhone_11Pro = "iPhone 11 Pro"
        case unknown
    }
    var screenType: ScreenType {
        switch UIScreen.main.nativeBounds.height {
        case 1136:
            return .iPhones_5_5s_5c_SE
        case 1334:
            return .iPhones_6_6s_7_8
        case 1792:
            return .iPhone_XR_11
        case 1920, 2208:
            return .iPhones_6Plus_6sPlus_7Plus_8Plus
        case 2426:
            return .iPhone_11Pro
        case 2436:
            return .iPhones_X_XS
        case 2688:
            return .iPhone_XSMax_ProMax
        default:
            return .unknown
        }
    }
    
}

