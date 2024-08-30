//
//  OfferListViewController.swift
//  JustBite
//
//  Created by cst on 13/02/20.
//  Copyright © 2020 Mobulous. All rights reserved.
//

import UIKit
import RealmSwift

class cartOfferListViewController: UIViewController {
    let realm = try! Realm()
    let macroObj = MacrosForAll.sharedInstanceMacro
    let alamoFireObj = AlamofireWrapper.sharedInstance
    @IBOutlet weak var offerTV: UITableView!
    var offerArray = [CartOfermodel]()
    override func viewDidLoad() {
        super.viewDidLoad()
       
        getCartListService()
        self.offerTV.register(nib: OfferTableViewCellAndXib.className)
        offerTV.delegate = self
        offerTV.dataSource = self
    }
    
    
    @IBAction func dismisBtn(_ sender: Any) {
        self.dismiss(animated: false, completion: nil)
    }
    
}

extension cartOfferListViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      
        return offerArray.count
          print(offerArray.count)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = offerTV.dequeueReusableCell(withIdentifier: OfferTableViewCellAndXib.className, for: indexPath) as? OfferTableViewCellAndXib else{
            fatalError(ConstantTexts.unexpectedIndexPath)
        }
        
        
        print(offerArray[indexPath.row].discount)
        print(offerArray[indexPath.row].valid_date)
        print( offerArray[indexPath.row].img)
        
        cell.lblTitle.attributedText = GlobalCustomMethods.shared.attributedStringOffer(title: "Your offers", subTitle: "Get \(offerArray[indexPath.row].discount)% off on all orders", subTitle2: "This offer is valid till \(offerArray[indexPath.row].valid_date)", delemit: "\n", sizeTitle: 17, sizeSubtitle2: 14, sizeSubtitle: 15, titleColor: AppColor.textColor, SubtitleColor: AppColor.subtitleColor, SubtitleColor2: AppColor.placeHolderColor)
        cell.noteLbl.text = offerArray[indexPath.row].note
        
        cell.imgThumbnail.sd_setImage(with: URL(string: offerArray[indexPath.row].img), placeholderImage: UIImage(named: "user_signup"))
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 155
    }
    
}


extension cartOfferListViewController{
    internal func getCartListService(){
        if InternetConnection.internetshared.isConnectedToNetwork(){
            macroObj.showLoader(view: self.view)
            
            var xLoc = "en"
            let realm = try! Realm()
            var id = String()
            if let userInfo = realm.objects(SignupDataModel.self).first{
                id = userInfo.id
                xLoc = userInfo.xLoc
            }else{
                print("do nothing")
            }
            
            
            let haeder = ["Accept":"application/json",
                          "X-localization":xLoc]
            
            let passDict = ["user_id":id] as [String:AnyObject]
            
            alamoFireObj.postRequestFormDataURL(MacrosForAll.APINAME.cartlist.rawValue, params: passDict, headers: haeder, success: { (resJson) in
                
                print(resJson)
                if let status = resJson["status"].stringValue as? String{
                    if status == "true"{
                        self.macroObj.hideLoader(view: self.view)
                        
                    
                        
                        if let extradetails = resJson["extra_details"].dictionaryObject as? NSDictionary{
                            
                            if let offere_details = extradetails.value(forKey: "offere_details") as?  NSArray{
                                print("the offer dertails are-->",offere_details)
                                
                                for item in 0..<offere_details.count{
                                    if let orderlistDict = offere_details[item] as? NSDictionary{
                                        var discountR = Int()
                                        var thumbnailR = String()
                                        var idR = String()
                                        var statusR = String()
                                        var valid_dateR = String()
                                        var imgR = String()
                                        var restorent_idR = String()
                                        var typeR = String()
                                         var noteR = String()
                                        if let discount = orderlistDict.value(forKey: "discount")  as? Int{
                                            discountR = discount
                                            print(discountR)
                                        }
                                        
                                        if let thumbnail = orderlistDict.value(forKey: "thumbnail")  as? String{
                                            thumbnailR = thumbnail
                                            print(thumbnailR)
                                        }
                                        
                                        if let id = orderlistDict.value(forKey: "id")  as? String{
                                            idR = id
                                            print(idR)
                                        }
                                        
                                        if let status = orderlistDict.value(forKey: "status")  as? String{
                                            statusR = status
                                            print(statusR)
                                        }
                                        if let valid_date = orderlistDict.value(forKey: "valid_date")  as? String{
                                            valid_dateR = valid_date
                                            print(valid_dateR)
                                        }
                                        if let img = orderlistDict.value(forKey: "img")  as? String{
                                            imgR = img
                                            print(statusR)
                                        }
                                        if let restorent_id = orderlistDict.value(forKey: "restorent_id")  as? String{
                                            restorent_idR = restorent_id
                                            print(restorent_idR)
                                        }
                                        if let type = orderlistDict.value(forKey: "type")  as? String{
                                            typeR = type
                                            print(typeR)
                                        }
                                        
                                        if let note = orderlistDict.value(forKey: "note")  as? String{
                                            noteR = note
                                            print(noteR)
                                        }
                                        
                                        let cartOfferItem = CartOfermodel(discount: discountR, thumbnail: thumbnailR, id: idR, status: statusR, valid_date: valid_dateR, img: imgR, restorent_id: restorent_idR, type: typeR, note: noteR)
                                        
                                        self.offerArray.append(cartOfferItem)
                                        print("the offer data model is-->",self.offerArray)
                                        print("order count is-->",self.offerArray.count)
                                        
                                    }
                                    
                                }
                                 self.offerTV.reloadData()
                            }
                            
                        }
                        
                    
                   
                        // marker.map = self.footer.mapView
                        //Commented by Sonika
                        //  self.footer.mapView.isMyLocationEnabled = true
                        
                    }else{
                        self.macroObj.hideLoader(view: self.view)
                        self.macroObj.hideLoaderEmpty(view: self.offerTV)
                        self.macroObj.hideWentWrong(view: self.offerTV)
                        self.macroObj.hideLoaderNet(view: self.offerTV)
                      
                        
                        if let message = resJson["message"].stringValue as? String{
                            _ = SweetAlert().showAlert(self.macroObj.appName, subTitle: message, style: AlertStyle.error)
                        }
                    }
                    
                    
                }
            }) { (error) in
                print(error)
                self.macroObj.hideLoader(view: self.view)
                self.macroObj.showWentWrong(view: self.offerTV)
                self.macroObj.hideLoaderEmpty(view: self.offerTV)
             
                
                self.macroObj.hideWentWrong(view: self.offerTV)
            }
            
        }else{
            macroObj.hideLoader(view: self.view)
            _ = SweetAlert().showAlert(macroObj.appName, subTitle: ConstantTexts.noInterNet, style: AlertStyle.error)
            macroObj.showLoaderNet(view: self.offerTV)
            macroObj.hideLoaderEmpty(view: self.offerTV)
            macroObj.hideWentWrong(view: self.offerTV)
        }
    }
}
