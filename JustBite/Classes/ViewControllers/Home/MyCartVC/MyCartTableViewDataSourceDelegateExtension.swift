//
//  MyCartTableViewDataSourceDelegateExtension.swift
//  JustBite
//
//  Created by Aman on 15/05/19.
//  Copyright © 2019 Mobulous. All rights reserved.
//

import Foundation
import UIKit
import DatePickerDialog

extension MyCartVC:UITableViewDelegate,SendDataToCart{
 
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
}

extension MyCartVC:UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0{
            return menuItemDataModelArray.count
        }else{
            if  menuItemDataModelArray.count == 0{
                return 0
            }else{
                if openType == -1{
                    if offeredService == "0"{
                         return 1
                    }
                    else if offeredService == "1"{
                        return 1
                    }
                   else if offeredService == "2"{
                        return 1
                    }
                    else if offeredService == "0,1"{
                        return 2
                    }
                    else if offeredService == "0,2"{
                        return 2
                    }
                    else if offeredService == "0,1,2"{
                        return 3
                    }
                    else if offeredService == "1,2"{
                        return 2
                    }
                   
                }else{
                    return 0
                }
            }
            
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0{
            guard let cell = tblView.dequeueReusableCell(withIdentifier: CartTableViewCellAndXib.className) as? CartTableViewCellAndXib else{
                fatalError(ConstantTexts.unexpectedIndexPath)
            }
            cell.btnPlusRef.tag = indexPath.row
            cell.btnPlusRef.addTarget(self, action: #selector(customizeTapped), for: .touchUpInside)
            
            cell.btnMinusRef.tag = indexPath.row
            cell.btnMinusRef.addTarget(self, action: #selector(minusTapped), for: .touchUpInside)
            cell.configure(item:menuItemDataModelArray[indexPath.row])
            
            return cell
        }else{
            guard let cell = tblView.dequeueReusableCell(withIdentifier: eatTypeTableViewCell.className) as? eatTypeTableViewCell else{
                fatalError(ConstantTexts.unexpectedIndexPath)
            }
            
            if indexPath.row == 0{
                self.eatOption = "0"
            }
           else if indexPath.row == 1{
                self.eatOption = "1"
            }
            else{
                self.eatOption = "2"
            }
            
            if offeredService == "0"{
                   cell.eatOptionbtn.setTitle(offered0[indexPath.row], for: .normal)
                if eatArray0[indexPath.row] == false{
                    cell.eatOptionbtn.setImage(#imageLiteral(resourceName: "unsalected_button"), for: .normal)
                }else{
                    cell.eatOptionbtn.setImage(#imageLiteral(resourceName: "radio_button"), for: .normal)
                }
            }
            else if offeredService == "1"{
                  cell.eatOptionbtn.setTitle(offered1[indexPath.row], for: .normal)
                if eatArray1[indexPath.row] == false{
                    cell.eatOptionbtn.setImage(#imageLiteral(resourceName: "unsalected_button"), for: .normal)
                }else{
                    cell.eatOptionbtn.setImage(#imageLiteral(resourceName: "radio_button"), for: .normal)
                }
            }
            else if offeredService == "2"{
                  cell.eatOptionbtn.setTitle(offered2[indexPath.row], for: .normal)
                if eatArray2[indexPath.row] == false{
                    cell.eatOptionbtn.setImage(#imageLiteral(resourceName: "unsalected_button"), for: .normal)
                }else{
                    cell.eatOptionbtn.setImage(#imageLiteral(resourceName: "radio_button"), for: .normal)
                }
            }
            else if offeredService == "0,1"{
                   cell.eatOptionbtn.setTitle(offered0_1[indexPath.row], for: .normal)
                if eatArray0_1[indexPath.row] == false{
                    cell.eatOptionbtn.setImage(#imageLiteral(resourceName: "unsalected_button"), for: .normal)
                }else{
                    cell.eatOptionbtn.setImage(#imageLiteral(resourceName: "radio_button"), for: .normal)
                }
            }
            else if offeredService == "0,2"{
                   cell.eatOptionbtn.setTitle(offered0_2[indexPath.row], for: .normal)
                if eatArray0_2[indexPath.row] == false{
                    cell.eatOptionbtn.setImage(#imageLiteral(resourceName: "unsalected_button"), for: .normal)
                }else{
                    cell.eatOptionbtn.setImage(#imageLiteral(resourceName: "radio_button"), for: .normal)
                }
            }
            else if offeredService == "0,1,2"{
                  cell.eatOptionbtn.setTitle(eatArray[indexPath.row], for: .normal)
                if eatArrayInt[indexPath.row] == false{
                    cell.eatOptionbtn.setImage(#imageLiteral(resourceName: "unsalected_button"), for: .normal)
                }else{
                    cell.eatOptionbtn.setImage(#imageLiteral(resourceName: "radio_button"), for: .normal)
                }
            }
            else if offeredService == "1,2"{
                   cell.eatOptionbtn.setTitle(offered1_2[indexPath.row], for: .normal)
                if eatArray1_2[indexPath.row] == false{
                    cell.eatOptionbtn.setImage(#imageLiteral(resourceName: "unsalected_button"), for: .normal)
                }else{
                    cell.eatOptionbtn.setImage(#imageLiteral(resourceName: "radio_button"), for: .normal)
                }
            }
            
            cell.eatOptionbtn.titleLabel?.font = AppFont.Regular.size(AppFontName.SourceSansPro, size: 17)
            cell.eatOptionbtn.setTitleColor(AppColor.textColor, for: .normal)
         
            cell.eatOptionbtn.tag = indexPath.row
            cell.eatOptionbtn.addTarget(self, action: #selector(eatOptionbtnTapped), for: .touchUpInside)
            
//
//            cell.btnMinusRef.tag = indexPath.row
//            cell.btnMinusRef.addTarget(self, action: #selector(minusTapped), for: .touchUpInside)
//            cell.configure(item:menuItemDataModelArray[indexPath.row])
            
            return cell
        }
        
      
    }
    
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        if section == 0{
            if  menuItemDataModelArray.count == 0{
                return UIView()
            }else{
                
                if openType == -1{
                    footer.btnLocRef.isHidden = true
                    footer.lblAddress.isHidden = true
                    footer.lblAddress.font = AppFont.Regular.size(AppFontName.SourceSansPro, size: 17)
                    footer.lblAddress.textColor = AppColor.textColor
                    footer.lblAddress.text = "Total amount to be paid"
                    
                    footer.couponCode.font = AppFont.Regular.size(AppFontName.SourceSansPro, size: 20)
                    footer.couponCode.textColor = AppColor.textColor
                    footer.couponCode.text = "Apply Coupon"
                    
                    footer.imgCoupon.image = #imageLiteral(resourceName: "c_arrow")
                    
                    footer.lblEatOption.font = AppFont.Semibold.size(AppFontName.SourceSansPro, size: 17)
                    footer.lblEatOption.textColor = AppColor.textColor
                    footer.lblEatOption.text = "Select Eat Option:"
                    
                    footer.eatTypeLbl.isHidden = true
                    footer.eatTypeLbl.font = AppFont.Regular.size(AppFontName.SourceSansPro, size: 17)
                    footer.eatTypeLbl.textColor = AppColor.textColor
                    footer.eatTypeLbl.text = ""
                    footer.btnApplyCouponRef.addTarget(self, action: #selector(btnCouponTappedTapped), for: .touchUpInside)
                }else{
                    
                     if self.selectionType == "Pick Up"{
                        footer.btnLocRef.isHidden = false
                        footer.lblAddress.isHidden = false
                        footer.lblAddress.font = AppFont.Regular.size(AppFontName.SourceSansPro, size: 14)
                        footer.lblAddress.textColor = AppColor.textColor
                        footer.lblAddress.text = "Golf City, Gardenia Gateway, Sector 75, Noida, Uttar Pradesh, India"
                        
                        footer.couponCode.font = AppFont.Regular.size(AppFontName.SourceSansPro, size: 20)
                        footer.couponCode.textColor = AppColor.textColor
                        footer.couponCode.text = "Apply Coupon"
                        
                        footer.imgCoupon.image = #imageLiteral(resourceName: "c_arrow")
                        
                        footer.lblEatOption.font = AppFont.Semibold.size(AppFontName.SourceSansPro, size: 17)
                        footer.lblEatOption.textColor = AppColor.textColor
                        footer.lblEatOption.text = "Eat Option:"
                        
                        footer.eatTypeLbl.isHidden = false
                        footer.eatTypeLbl.font = AppFont.Regular.size(AppFontName.SourceSansPro, size: 17)
                        footer.eatTypeLbl.textColor = AppColor.textColor
                        footer.eatTypeLbl.text = "Pick Up"
                        print("the price incoming  is-->",self.price)
                       // self.Pickfooter.itemPice.text = "USD \(String(format: "%.2f", price))"
                        
                        self.Pickfooter.dateBtn.tag = section
                        self.Pickfooter.dateBtn.addTarget(self, action: #selector(dateBtnTapped), for: .touchUpInside)
                        
                        self.Pickfooter.clockBtn.tag = section
                        self.Pickfooter.clockBtn.addTarget(self, action: #selector(timeBtnTapped), for: .touchUpInside)
                        
                        self.Pickfooter.itemPice.text = "USD"+self.price
                        let number: Float = Float(self.discount) ?? 0.0
                        let str1 = String(format: "%.2f", number) // 3.14
                       
                        
                         self.Pickfooter.discountLbl.text = "USD"+str1
                        self.Pickfooter.totalAmountLbl.text = "USD"+self.totalPrice
                    }else if self.selectionType == "Home Delivery"{
                        
                
                        footer.btnLocRef.isHidden = false
                        footer.lblAddress.isHidden = false
                        footer.lblAddress.font = AppFont.Regular.size(AppFontName.SourceSansPro, size: 14)
                        footer.lblAddress.textColor = AppColor.textColor
                        footer.lblAddress.text = "Golf City, Gardenia Gateway, Sector 75, Noida, Uttar Pradesh, India"
                        
                        footer.couponCode.font = AppFont.Regular.size(AppFontName.SourceSansPro, size: 20)
                        footer.couponCode.textColor = AppColor.textColor
                        footer.couponCode.text = "Apply Coupon"
                        
                        footer.imgCoupon.image = #imageLiteral(resourceName: "c_arrow")
                        
                        
                        
                        footer.lblEatOption.font = AppFont.Semibold.size(AppFontName.SourceSansPro, size: 17)
                        footer.lblEatOption.textColor = AppColor.textColor
                        footer.lblEatOption.text = " Eat Option:"
                        
                        footer.eatTypeLbl.isHidden = false
                        footer.eatTypeLbl.font = AppFont.Regular.size(AppFontName.SourceSansPro, size: 17)
                        footer.eatTypeLbl.textColor = AppColor.textColor
                        footer.eatTypeLbl.text = "Home Delivery"
                        
                        self.Homefooter.locationBtn.tag = section
                        self.Homefooter.locationBtn.addTarget(self, action: #selector(btnLocationTapped), for: .touchUpInside)
                        
                        self.Homefooter.signUpAddressBtn.tag = section
                        self.Homefooter.signUpAddressBtn.addTarget(self, action: #selector(btnHoomeTapped), for: .touchUpInside)
                        
                        self.Homefooter.itemprice.text = "USD"+self.price
                        let number: Float = Float(self.discount) ?? 0.0
                        let str1 = String(format: "%.2f", number) // 3.14
                        self.Homefooter.discountPrice.text = "USD"+str1
                        self.Homefooter.totalAmount.text = "USD"+self.totalPrice
                    }else {
                        footer.btnLocRef.isHidden = false
                        footer.lblAddress.isHidden = false
                        footer.lblAddress.font = AppFont.Regular.size(AppFontName.SourceSansPro, size: 14)
                        footer.lblAddress.textColor = AppColor.textColor
                        footer.lblAddress.text = "Golf City, Gardenia Gateway, Sector 75, Noida, Uttar Pradesh, India"
                        
                        footer.couponCode.font = AppFont.Regular.size(AppFontName.SourceSansPro, size: 20)
                        footer.couponCode.textColor = AppColor.textColor
                        footer.couponCode.text = "Apply Coupon"
                        
                        footer.imgCoupon.image = #imageLiteral(resourceName: "c_arrow")
                        
                        footer.lblEatOption.font = AppFont.Semibold.size(AppFontName.SourceSansPro, size: 17)
                        footer.lblEatOption.textColor = AppColor.textColor
                        footer.lblEatOption.text = " Eat Option:"
                        
                        footer.eatTypeLbl.isHidden = false
                        footer.eatTypeLbl.font = AppFont.Regular.size(AppFontName.SourceSansPro, size: 17)
                        footer.eatTypeLbl.textColor = AppColor.textColor
                        footer.eatTypeLbl.text = "Eat At Restaurant"
                        
                        self.Resturantfooter.dateBtn.tag = section
                        self.Resturantfooter.dateBtn.addTarget(self, action: #selector(dateBtnTapped), for: .touchUpInside)
                        
                        self.Resturantfooter.clockBtn.tag = section
                        self.Resturantfooter.clockBtn.addTarget(self, action: #selector(timeBtnTapped), for: .touchUpInside)
                        
                        self.Resturantfooter.itemPrice.text = "USD"+self.price
                        let number: Float = Float(self.discount) ?? 0.0
                        let str1 = String(format: "%.2f", number) // 3.14
                        self.Resturantfooter.discountLbl.text = "USD"+str1
                        self.Resturantfooter.totalPriceLbl.text = "USD"+self.totalPrice
                    }
                }
                
                
               
                return footer
            }
            
           
        }else{
            if openType == -1{
                return UIView()
            }else{
                if self.selectionType == "Home Delivery"{
                    return Homefooter
                }else if self.selectionType == "Pick Up"{
                    return Pickfooter
                }else  {
                    return Resturantfooter
                }
               
            }
            
            
         
        }
        
    }
    
      @objc func dateBtnTapped(sender:UIButton){
        datePickerTapped()
    }
    
      @objc func timeBtnTapped(sender:UIButton){
        timePickerTapped()
    }
    
    func datePickerTapped() {
        DatePickerDialog().show("DatePicker", doneButtonTitle: "Done", cancelButtonTitle: "Cancel", datePickerMode: .date) {
            (date) -> Void in
            if let dt = date {
                let formatter = DateFormatter()
                formatter.dateFormat = "MM/dd/yyyy"
                self.Pickfooter.dateTf.text = formatter.string(from: dt)
                self.Resturantfooter.dateTf.text = formatter.string(from: dt)
            }
        }
    }
    
    func timePickerTapped() {
        DatePickerDialog().show("timePicker", doneButtonTitle: "Done", cancelButtonTitle: "Cancel", datePickerMode: .time) {
            (time) -> Void in
            if let dt = time {
                let formatter = DateFormatter()
                formatter.dateFormat = "h:mm a"
                self.Pickfooter.timeTf.text = formatter.string(from: dt)
                self.Resturantfooter.timeTf.text = formatter.string(from: dt)
            }
        }
    }
    
    @objc func btnLocationTapped(sender:UIButton){
        let viewC = UIStoryboard(name: "Home", bundle: nil).instantiateViewController(withIdentifier: LocationPickerVC.className) as! LocationPickerVC
        viewC.isComing = "Cart"
        viewC.backCartObj = self
        self.navigationController?.pushViewController(viewC, animated: true)
    }
    
    func backToAddress(address: String,lat:String,long:String) {
        self.Homefooter.addressTV.text = address
       latitude = lat
       longitude = long
        print(address)
    }
    
    @objc func btnHoomeTapped(sender:UIButton){
       
        
        if let userInfo = realm.objects(SignupDataModel.self).first{
        let address = userInfo.address
        self.Homefooter.addressTV.text =  address
        }
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if section == 0{
            if  menuItemDataModelArray.count == 0{
                return 0
            }else{
                return 150
            }
        }else{
            if openType == -1{
                return 0
            }else if openType == 0{
                return 300
            }else if openType == 1{
                return 200
            }else{
                return 400
            }
        }
    }
    
}
