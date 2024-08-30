//
//  HomeMainTableViewCell.swift
//  JustBite
//
//  Created by Aman on 12/05/19.
//  Copyright © 2019 Mobulous. All rights reserved.
//

import UIKit
import RealmSwift

class HomeMainTableViewCell: SBaseTableViewCell,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    
    //MARK: - IBOutlets
    
    @IBOutlet weak var lblViewAll: UILabel!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var btnRestRef: UIButton!
    var superVC = UIViewController()
    var restaurentDataModelForHomeItem = [RestaurentDataModelForHome]()
    let macroObj = MacrosForAll.sharedInstanceMacro
    let alamoFireObj = AlamofireWrapper.sharedInstance
    var index = Int()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        lblTitle.font = AppFont.Regular.size(AppFontName.SourceSansPro, size: 17)
        lblTitle.textColor = AppColor.textColor
        lblTitle.text = "Available Offers"
        
        lblViewAll.font = AppFont.Semibold.size(AppFontName.SourceSansPro, size: 17)
        lblViewAll.textColor = AppColor.themeColor
        lblViewAll.text = "View More"
        
        registerNib()
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.reloadData()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.reloadData()
        // Configure the view for the selected state
        //   collectionView.reloadData()
    }
    
    
    
    //TODO: Register Nib method
    fileprivate func registerNib(){
        self.collectionView.registerMultiple(nibs: [HomeCollectionViewCellAvailableOffer.className,HomeCollectionViewCellDetail.className])
    }
    
 

    
    @objc func btnFavTapped(sender: UIButton){
        print(sender.tag)
        
        
        
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
                        
                        let mainStoryboard: UIStoryboard = UIStoryboard(name: "Auth", bundle: nil)
                        let viewController = mainStoryboard.instantiateViewController(withIdentifier: LoginVC.className)
                        let navigationController = UINavigationController(rootViewController: viewController)
                        navigationController.navigationBar.isHidden = true
                        APPLICATION.keyWindow?.rootViewController = navigationController

                    }
                    
                }
            }else{
                
                let realm = try! Realm()
                if let userInfo = realm.objects(SignupDataModel.self).first{
                    //api call kara do
                    var token_type = userInfo.token_type
                    var access_token = userInfo.access_token
                    var id = String()
                    var isFav = String()
                    if let restId = restaurentDataModelForHomeItem[sender.tag].id as? String{
                        id = restId
                    }
                    
                    if let isFavo = restaurentDataModelForHomeItem[sender.tag].is_favorite as? String{
                        isFav = isFavo
                    }
                    
                    guard let indexpath = IndexPath(row: sender.tag, section: 0) as? IndexPath else{
                        print("No indexpath")
                        return
                    }
                    
                    guard let collCell = collectionView.cellForItem(at: indexpath) as? HomeCollectionViewCellDetail else{
                        print("No collCell")
                        return
                    }
                    
                    addFavService(token_type: token_type, access_token: access_token, view: collCell.heartView, id: id, isFav: isFav, index: sender.tag, cell: collCell)
                    
                }else{
                    
                    print("Pop up dikhao bahar bhagao")
                    
                }
                
            }
        }else{
            _ = SweetAlert().showAlert(APP_NAME, subTitle: ConstantTexts.LoginRwq, style: AlertStyle.warning, buttonTitle:ConstantTexts.cancel, buttonColor: AppColor.themeColor , otherButtonTitle:  ConstantTexts.Ok,  otherButtonColor: AppColor.stepperColor) { (isOtherButton) -> Void in
                if isOtherButton == true {
                    print("Cancel Button  Pressed", terminator: "")
                    //                    self.moveToNextViewCViaRoot(name:"Auth",withIdentifier: LoginVC.className)
                }
                else
                {
                    let mainStoryboard: UIStoryboard = UIStoryboard(name: "Auth", bundle: nil)
                    let viewController = mainStoryboard.instantiateViewController(withIdentifier: LoginVC.className)
                    let navigationController = UINavigationController(rootViewController: viewController)
                    navigationController.navigationBar.isHidden = true
                    APPLICATION.keyWindow?.rootViewController = navigationController
                }
                
            }
            print("do nothing")
        }
        
        

        
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return restaurentDataModelForHomeItem.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
                if index == 0{
        
                    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeCollectionViewCellAvailableOffer.className, for: indexPath) as? HomeCollectionViewCellAvailableOffer else {
                        fatalError(ConstantTexts.unexpectedIndexPath)
                    }
        
        
                    if restaurentDataModelForHomeItem.count > 0{
                        cell.configureCellWith(info: restaurentDataModelForHomeItem[indexPath.row])
                    }else{
                        collectionView.dataSource = self
                        collectionView.delegate = self
                        collectionView.reloadData()
                        collectionView.isHidden = true
                        macroObj.showLoaderEmpty(view: cell)
        
                    }
        
                    return cell
        
        
        
                }else{
        
                    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeCollectionViewCellDetail.className, for: indexPath) as? HomeCollectionViewCellDetail else {
                        fatalError(ConstantTexts.unexpectedIndexPath)
                    }
        
        
                    if restaurentDataModelForHomeItem.count > 0{
                       
                        cell.btnFavRef.tag = indexPath.row
                        cell.btnFavRef.addTarget(self, action: #selector(btnFavTapped), for: .touchUpInside)
                        cell.configureCellWith(info: restaurentDataModelForHomeItem[indexPath.row])
                    }else{
                        collectionView.dataSource = self
                        collectionView.delegate = self
                        collectionView.reloadData()
                        collectionView.isHidden = true
                        macroObj.showLoaderEmpty(view: cell)
        
                    }
                    
                    
                    return cell
                }
        
    }
    
    //TODO: CollectionView flow layout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if index != 0{
            return CGSize(width: 310, height:280)
        }else{
            return CGSize(width: 280, height:160)
        }
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = AppStoryboard.home.instantiateViewController(withIdentifier: RestaurentDetailsVC.className) as! RestaurentDetailsVC
        
        vc.comingLat = restaurentDataModelForHomeItem[indexPath.row].latitude
        vc.comingLong = restaurentDataModelForHomeItem[indexPath.row].longitude
        vc.currentLat = restaurentDataModelForHomeItem[indexPath.row].latitudeCur
        vc.currentLong = restaurentDataModelForHomeItem[indexPath.row].longitudeCur
        vc.id = restaurentDataModelForHomeItem[indexPath.row].id
        superVC.navigationController?.pushViewController(vc, animated: true)
        
        
    }
    
    
    
}


extension HomeMainTableViewCell{
    fileprivate func addFavService(token_type:String,access_token:String,view:UIView,id:String,isFav:String,index:Int,cell:HomeCollectionViewCellDetail){
        if InternetConnection.internetshared.isConnectedToNetwork(){
            
            let passDict = ["restaurant_id":id,
                            "is_favourite":isFav] as [String : AnyObject]
            
            let header = ["Authorization":"\(token_type) \(access_token)",
                "Accept":"application/json"]
            
            if isFav == "0"{
                macroObj.showLoaderHeart(view: view)
            }else{
                //toote dil ka chala do
                macroObj.showLoaderBrokenHeart(view: view)
            }
            alamoFireObj.postRequestURL(MacrosForAll.APINAME.savefavourite.rawValue, params: passDict as [String : AnyObject], headers: header, success: { (responseJASON) in
                self.macroObj.hideLoader(view: view)
                print(responseJASON)
                if responseJASON["status"].string == "true"{
                    
                    if isFav == "0"{
                        cell.btnFavRef.setImage(#imageLiteral(resourceName: "heart_like_"), for: .normal)
                        
                        self.macroObj.hideLoaderHeart(view: view)
                        self.restaurentDataModelForHomeItem[index].is_favorite = "1"
                    }else{
                        cell.btnFavRef.setImage(#imageLiteral(resourceName: "fav"), for: .normal)
                        
                        self.macroObj.hideLoaderBrokenHeart(view: view)
                        self.restaurentDataModelForHomeItem[index].is_favorite = "0"
                    }
                    
                    
                    
                }else{
                    if isFav == "0"{
                        self.macroObj.hideLoaderHeart(view: view)
                    }else{
                        self.macroObj.hideLoaderBrokenHeart(view: view)
                    }
                    
                    if let message = responseJASON["message"].string{
                        _ = SweetAlert().showAlert(self.macroObj.appName, subTitle: message, style: AlertStyle.error)
                    }
                    
                }
                
            }, failure: { (error) in
                if isFav == "0"{
                    self.macroObj.hideLoaderHeart(view: view)
                }else{
                    self.macroObj.hideLoaderBrokenHeart(view: view)
                }
                print(error.localizedDescription)
                _ = SweetAlert().showAlert(self.macroObj.appName, subTitle: ConstantTexts.ErrorMessage, style: AlertStyle.error)
            })
            
        }else{
            if isFav == "0"{
                self.macroObj.hideLoaderHeart(view: view)
            }else{
                self.macroObj.hideLoaderBrokenHeart(view: view)
            }
            _ = SweetAlert().showAlert(macroObj.appName, subTitle: ConstantTexts.noInterNet, style: AlertStyle.error)
        }
    }
}
