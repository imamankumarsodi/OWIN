

import Foundation
import UIKit


extension MyOrderOngoingVC:UITableViewDelegate{
    
}


extension MyOrderOngoingVC:UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        if btnTag == 1{
            return onGoingModelArray.count
        }else if btnTag == 2{
            return previousModelArray.count
        }else{
            return upComingModelArray.count
        }
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if btnTag == 1{
            if onGoingModelArray[section].isSelected {
                print(onGoingModelArray[section].orderMenu.count)
                
                return onGoingModelArray[section].orderMenu.count
            }else {
                return 0
            }
        }else if btnTag == 2{
            if previousModelArray[section].isSelected {
                return previousModelArray[section].orderMenu.count
            }else {
                return 0
            }
        }
            
        else{
            if upComingModelArray[section].isSelected {
                return upComingModelArray[section].orderMenu.count
            }else {
                return 0
            }
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tblViewHome.dequeueReusableCell(withIdentifier: InnerTableViewCell.className, for: indexPath) as? InnerTableViewCell else{
            fatalError(ConstantTexts.unexpectedIndexPath)
        }
        
        
        if btnTag == 1{
            
            cell.lblDetails.attributedText = GlobalCustomMethods.shared.attributedString(title: onGoingModelArray[indexPath.section].orderMenu[indexPath.row].name, subTitle: "USD \(onGoingModelArray[indexPath.section].orderMenu[indexPath.row].price)", delemit: "\n", sizeTitle: 15, sizeSubtitle: 16, titleColor: AppColor.subtitleColor, SubtitleColor: AppColor.textColor)
            
            cell.btnCustomizeRef.titleLabel?.font = AppFont.Regular.size(AppFontName.SourceSansPro, size: 13)
            cell.btnCustomizeRef.setTitleColor(AppColor.subtitleColor, for: .normal)
            cell.btnCustomizeRef.backgroundColor = AppColor.whiteColor
            cell.btnCustomizeRef.setTitle("\(onGoingModelArray[indexPath.section].orderMenu[indexPath.row].quantity) X USD \(onGoingModelArray[indexPath.section].orderMenu[indexPath.row].price)", for: .normal)
            
            if onGoingModelArray[indexPath.section].orderMenu[indexPath.row].item_type == 1{
                cell.imgSymbol.image = #imageLiteral(resourceName: "nonveg_symbol")
            }else{
                cell.imgSymbol.image = #imageLiteral(resourceName: "veg_symbol")
            }
            
            cell.imgView.sd_setImage(with: URL(string: onGoingModelArray[indexPath.section].orderMenu[indexPath.row].image), placeholderImage: UIImage(named: "user_signup"))
            
        }else  if btnTag == 2{
            
            cell.lblDetails.attributedText = GlobalCustomMethods.shared.attributedString(title: previousModelArray[indexPath.section].orderMenu[indexPath.row].name, subTitle: "USD \(previousModelArray[indexPath.section].orderMenu[indexPath.row].price)", delemit: "\n", sizeTitle: 15, sizeSubtitle: 16, titleColor: AppColor.subtitleColor, SubtitleColor: AppColor.textColor)
            
            cell.btnCustomizeRef.titleLabel?.font = AppFont.Regular.size(AppFontName.SourceSansPro, size: 13)
            cell.btnCustomizeRef.setTitleColor(AppColor.subtitleColor, for: .normal)
            cell.btnCustomizeRef.backgroundColor = AppColor.whiteColor
            cell.btnCustomizeRef.setTitle("\(previousModelArray[indexPath.section].orderMenu[indexPath.row].quantity) X USD \(previousModelArray[indexPath.section].orderMenu[indexPath.row].price)", for: .normal)
            
            if previousModelArray[indexPath.section].orderMenu[indexPath.row].item_type == 1{
                cell.imgSymbol.image = #imageLiteral(resourceName: "nonveg_symbol")
            }else{
                cell.imgSymbol.image = #imageLiteral(resourceName: "veg_symbol")
            }
            
            cell.imgView.sd_setImage(with: URL(string: previousModelArray[indexPath.section].orderMenu[indexPath.row].image), placeholderImage: UIImage(named: "user_signup"))
            
        }
            
        else{
            
            cell.lblDetails.attributedText = GlobalCustomMethods.shared.attributedString(title: upComingModelArray[indexPath.section].orderMenu[indexPath.row].name, subTitle: "USD \(upComingModelArray[indexPath.section].orderMenu[indexPath.row].price)", delemit: "\n", sizeTitle: 15, sizeSubtitle: 16, titleColor: AppColor.subtitleColor, SubtitleColor: AppColor.textColor)
            
            cell.btnCustomizeRef.titleLabel?.font = AppFont.Regular.size(AppFontName.SourceSansPro, size: 13)
            cell.btnCustomizeRef.setTitleColor(AppColor.subtitleColor, for: .normal)
            cell.btnCustomizeRef.backgroundColor = AppColor.whiteColor
            cell.btnCustomizeRef.setTitle("\(upComingModelArray[indexPath.section].orderMenu[indexPath.row].quantity) X USD \(upComingModelArray[indexPath.section].orderMenu[indexPath.row].price)", for: .normal)
            
            if upComingModelArray[indexPath.section].orderMenu[indexPath.row].item_type == 1{
                cell.imgSymbol.image = #imageLiteral(resourceName: "nonveg_symbol")
            }else{
                cell.imgSymbol.image = #imageLiteral(resourceName: "veg_symbol")
            }
            
            cell.imgView.sd_setImage(with: URL(string: upComingModelArray[indexPath.section].orderMenu[indexPath.row].image), placeholderImage: UIImage(named: "user_signup"))
            
        }
        return cell
        
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        
        
        if self.btnTag == 1{
            
            
            let header:MyOrderOnGoingHeaderView = Bundle.main.loadNibNamed(MyOrderOnGoingHeaderView.className, owner: self, options: nil)!.first! as! MyOrderOnGoingHeaderView
            
            header.onGoingDataModelItemCancelTime = onGoingModelArray[section]
        //    header.calTime.isHidden = true
            header.dateTimeLbl.text = onGoingModelArray[section].orderDate
            //   header.lblTitle.attributedText = GlobalCustomMethods.shared.attributedStringOffer(title: onGoingModelArray[section].restaurant_name, subTitle: "Order Id : \(onGoingModelArray[section].order_number)", subTitle2: "\(onGoingModelArray[section].expected_delivery_time)", delemit: "\n", sizeTitle: 16, sizeSubtitle2: 15, sizeSubtitle: 14, titleColor: AppColor.textColor, SubtitleColor: AppColor.subtitleColor, SubtitleColor2: AppColor.placeHolderColor)
            
            header.lblTitle.attributedText = GlobalCustomMethods.shared.attributedStringOffer(title: onGoingModelArray[section].restaurant_name, subTitle: "Order Id : \(onGoingModelArray[section].order_number)", subTitle2: "", delemit: "\n", sizeTitle: 16, sizeSubtitle2: 15, sizeSubtitle: 14, titleColor: AppColor.textColor, SubtitleColor: AppColor.subtitleColor, SubtitleColor2: AppColor.placeHolderColor)
            
            
           /* header.lblTime.font = AppFont.Regular.size(AppFontName.SourceSansPro, size: 12)
            header.lblTime.textColor = AppColor.subtitleColor
            header.lblTime.text = "Rate Order"
            
            header.btnCancelRef.titleLabel?.font = AppFont.Semibold.size(AppFontName.SourceSansPro, size: 16)
            header.btnCancelRef.setTitleColor(AppColor.whiteColor, for: .normal)
            header.btnCancelRef.backgroundColor = AppColor.themeColor
            header.btnCancelRef.setTitle("Cancel", for: .normal)
            GlobalCustomMethods.shared.provideCustomCornarRadius(btnRef: header.btnCancelRef, radius: 5)*/
            
            header.imgView.sd_setImage(with: URL(string: onGoingModelArray[section].restaurant_image), placeholderImage: UIImage(named: "user_signup"))
            
            
            
            //            timerCount = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(self.update), userInfo: nil, repeats: true)
            
            if onGoingModelArray[section].deliveryStatus == "Pending"{
                
                header.lblPendingStepper.font = AppFont.Regular.size(AppFontName.SourceSansPro, size: 10)
                header.lblPendingStepper.textColor = AppColor.whiteColor
                header.lblPendingStepper.backgroundColor = AppColor.stepperColor
                GlobalCustomMethods.shared.provideCornarRadius(btnRef: header.lblPendingStepper)
                header.lblPendingStepper.text = "1"
                
                header.lblConfirmedStepper.font = AppFont.Regular.size(AppFontName.SourceSansPro, size: 10)
                header.lblConfirmedStepper.textColor = AppColor.whiteColor
                header.lblConfirmedStepper.backgroundColor = AppColor.placeHolderColor
                GlobalCustomMethods.shared.provideCornarRadius(btnRef: header.lblConfirmedStepper)
                header.lblConfirmedStepper.text = "2"
                
                header.lblInTheKitchenStep.font = AppFont.Regular.size(AppFontName.SourceSansPro, size: 10)
                header.lblInTheKitchenStep.textColor = AppColor.whiteColor
                header.lblInTheKitchenStep.backgroundColor = AppColor.placeHolderColor
                GlobalCustomMethods.shared.provideCornarRadius(btnRef: header.lblInTheKitchenStep)
                header.lblInTheKitchenStep.text = "3"
                
                header.lblOutForDeliverStepper.font = AppFont.Regular.size(AppFontName.SourceSansPro, size: 10)
                header.lblOutForDeliverStepper.textColor = AppColor.whiteColor
                header.lblOutForDeliverStepper.backgroundColor = AppColor.placeHolderColor
                GlobalCustomMethods.shared.provideCornarRadius(btnRef: header.lblOutForDeliverStepper)
                header.lblOutForDeliverStepper.text = "4"
                
                header.lblDeliveredStepper.font = AppFont.Regular.size(AppFontName.SourceSansPro, size: 10)
                header.lblDeliveredStepper.textColor = AppColor.whiteColor
                header.lblDeliveredStepper.backgroundColor = AppColor.placeHolderColor
                GlobalCustomMethods.shared.provideCornarRadius(btnRef: header.lblDeliveredStepper)
                header.lblDeliveredStepper.text = "5"
                
                
                header.lblPendingStatus.font = AppFont.Regular.size(AppFontName.SourceSansPro, size: 10)
                header.lblPendingStatus.textColor = AppColor.stepperColor
                header.lblPendingStatus.text = "Pending"
                
                header.lblConfirmedStatus.font = AppFont.Regular.size(AppFontName.SourceSansPro, size: 10)
                header.lblConfirmedStatus.textColor = AppColor.subtitleColor
                header.lblConfirmedStatus.text = "Confirmed"
                
                header.lblInTheKitchenStatus.font = AppFont.Regular.size(AppFontName.SourceSansPro, size: 10)
                header.lblInTheKitchenStatus.textColor = AppColor.subtitleColor
                header.lblInTheKitchenStatus.text = "In the Kitchen"
                
                header.lblOutForDeliveryStatus.font = AppFont.Regular.size(AppFontName.SourceSansPro, size: 10)
                header.lblOutForDeliveryStatus.textColor = AppColor.subtitleColor
                header.lblOutForDeliveryStatus.text = "Out For Delivery"
                
                header.lblDeliveredStatus.font = AppFont.Regular.size(AppFontName.SourceSansPro, size: 10)
                header.lblDeliveredStatus.textColor = AppColor.subtitleColor
                header.lblDeliveredStatus.text = "Delivered"
                
                
                header.viewPToC.backgroundColor = AppColor.subtitleColor
                header.viewCToK.backgroundColor = AppColor.subtitleColor
                header.viewIToO.backgroundColor = AppColor.subtitleColor
                header.viewOToD.backgroundColor = AppColor.subtitleColor
                
                
                
                
                
                
            }else if onGoingModelArray[section].deliveryStatus == "Confirmed"{
                
                header.lblPendingStepper.font = AppFont.Regular.size(AppFontName.SourceSansPro, size: 10)
                header.lblPendingStepper.textColor = AppColor.whiteColor
                header.lblPendingStepper.backgroundColor = AppColor.stepperColor
                GlobalCustomMethods.shared.provideCornarRadius(btnRef: header.lblPendingStepper)
                header.lblPendingStepper.text = "1"
                
                header.lblConfirmedStepper.font = AppFont.Regular.size(AppFontName.SourceSansPro, size: 10)
                header.lblConfirmedStepper.textColor = AppColor.whiteColor
                header.lblConfirmedStepper.backgroundColor = AppColor.stepperColor
                GlobalCustomMethods.shared.provideCornarRadius(btnRef: header.lblConfirmedStepper)
                header.lblConfirmedStepper.text = "2"
                
                header.lblInTheKitchenStep.font = AppFont.Regular.size(AppFontName.SourceSansPro, size: 10)
                header.lblInTheKitchenStep.textColor = AppColor.whiteColor
                header.lblInTheKitchenStep.backgroundColor = AppColor.placeHolderColor
                GlobalCustomMethods.shared.provideCornarRadius(btnRef: header.lblInTheKitchenStep)
                header.lblInTheKitchenStep.text = "3"
                
                header.lblOutForDeliverStepper.font = AppFont.Regular.size(AppFontName.SourceSansPro, size: 10)
                header.lblOutForDeliverStepper.textColor = AppColor.whiteColor
                header.lblOutForDeliverStepper.backgroundColor = AppColor.placeHolderColor
                GlobalCustomMethods.shared.provideCornarRadius(btnRef: header.lblOutForDeliverStepper)
                header.lblOutForDeliverStepper.text = "4"
                
                header.lblDeliveredStepper.font = AppFont.Regular.size(AppFontName.SourceSansPro, size: 10)
                header.lblDeliveredStepper.textColor = AppColor.whiteColor
                header.lblDeliveredStepper.backgroundColor = AppColor.placeHolderColor
                GlobalCustomMethods.shared.provideCornarRadius(btnRef: header.lblDeliveredStepper)
                header.lblDeliveredStepper.text = "5"
                
                
                header.lblPendingStatus.font = AppFont.Regular.size(AppFontName.SourceSansPro, size: 10)
                header.lblPendingStatus.textColor = AppColor.stepperColor
                header.lblPendingStatus.text = "Pending"
                
                header.lblConfirmedStatus.font = AppFont.Regular.size(AppFontName.SourceSansPro, size: 10)
                header.lblConfirmedStatus.textColor = AppColor.stepperColor
                header.lblConfirmedStatus.text = "Confirmed"
                
                header.lblInTheKitchenStatus.font = AppFont.Regular.size(AppFontName.SourceSansPro, size: 10)
                header.lblInTheKitchenStatus.textColor = AppColor.subtitleColor
                header.lblInTheKitchenStatus.text = "In the Kitchen"
                
                header.lblOutForDeliveryStatus.font = AppFont.Regular.size(AppFontName.SourceSansPro, size: 10)
                header.lblOutForDeliveryStatus.textColor = AppColor.subtitleColor
                header.lblOutForDeliveryStatus.text = "Out For Delivery"
                
                header.lblDeliveredStatus.font = AppFont.Regular.size(AppFontName.SourceSansPro, size: 10)
                header.lblDeliveredStatus.textColor = AppColor.subtitleColor
                header.lblDeliveredStatus.text = "Delivered"
                
                
                header.viewPToC.backgroundColor = AppColor.stepperColor
                header.viewCToK.backgroundColor = AppColor.subtitleColor
                header.viewIToO.backgroundColor = AppColor.subtitleColor
                header.viewOToD.backgroundColor = AppColor.subtitleColor
                
            }else if onGoingModelArray[section].deliveryStatus == "In the Kitchen"{
                
                header.lblPendingStepper.font = AppFont.Regular.size(AppFontName.SourceSansPro, size: 10)
                header.lblPendingStepper.textColor = AppColor.whiteColor
                header.lblPendingStepper.backgroundColor = AppColor.stepperColor
                GlobalCustomMethods.shared.provideCornarRadius(btnRef: header.lblPendingStepper)
                header.lblPendingStepper.text = "1"
                
                header.lblConfirmedStepper.font = AppFont.Regular.size(AppFontName.SourceSansPro, size: 10)
                header.lblConfirmedStepper.textColor = AppColor.whiteColor
                header.lblConfirmedStepper.backgroundColor = AppColor.stepperColor
                GlobalCustomMethods.shared.provideCornarRadius(btnRef: header.lblConfirmedStepper)
                header.lblConfirmedStepper.text = "2"
                
                header.lblInTheKitchenStep.font = AppFont.Regular.size(AppFontName.SourceSansPro, size: 10)
                header.lblInTheKitchenStep.textColor = AppColor.whiteColor
                header.lblInTheKitchenStep.backgroundColor = AppColor.stepperColor
                GlobalCustomMethods.shared.provideCornarRadius(btnRef: header.lblInTheKitchenStep)
                header.lblInTheKitchenStep.text = "3"
                
                header.lblOutForDeliverStepper.font = AppFont.Regular.size(AppFontName.SourceSansPro, size: 10)
                header.lblOutForDeliverStepper.textColor = AppColor.whiteColor
                header.lblOutForDeliverStepper.backgroundColor = AppColor.placeHolderColor
                GlobalCustomMethods.shared.provideCornarRadius(btnRef: header.lblOutForDeliverStepper)
                header.lblOutForDeliverStepper.text = "4"
                
                header.lblDeliveredStepper.font = AppFont.Regular.size(AppFontName.SourceSansPro, size: 10)
                header.lblDeliveredStepper.textColor = AppColor.whiteColor
                header.lblDeliveredStepper.backgroundColor = AppColor.placeHolderColor
                GlobalCustomMethods.shared.provideCornarRadius(btnRef: header.lblDeliveredStepper)
                header.lblDeliveredStepper.text = "5"
                
                
                header.lblPendingStatus.font = AppFont.Regular.size(AppFontName.SourceSansPro, size: 10)
                header.lblPendingStatus.textColor = AppColor.stepperColor
                header.lblPendingStatus.text = "Pending"
                
                header.lblConfirmedStatus.font = AppFont.Regular.size(AppFontName.SourceSansPro, size: 10)
                header.lblConfirmedStatus.textColor = AppColor.stepperColor
                header.lblConfirmedStatus.text = "Confirmed"
                
                header.lblInTheKitchenStatus.font = AppFont.Regular.size(AppFontName.SourceSansPro, size: 10)
                header.lblInTheKitchenStatus.textColor = AppColor.stepperColor
                header.lblInTheKitchenStatus.text = "In the Kitchen"
                
                header.lblOutForDeliveryStatus.font = AppFont.Regular.size(AppFontName.SourceSansPro, size: 10)
                header.lblOutForDeliveryStatus.textColor = AppColor.subtitleColor
                header.lblOutForDeliveryStatus.text = "Out For Delivery"
                
                header.lblDeliveredStatus.font = AppFont.Regular.size(AppFontName.SourceSansPro, size: 10)
                header.lblDeliveredStatus.textColor = AppColor.subtitleColor
                header.lblDeliveredStatus.text = "Delivered"
                
                
                header.viewPToC.backgroundColor = AppColor.stepperColor
                header.viewCToK.backgroundColor = AppColor.stepperColor
                header.viewIToO.backgroundColor = AppColor.subtitleColor
                header.viewOToD.backgroundColor = AppColor.subtitleColor
                
            }else if onGoingModelArray[section].deliveryStatus == "Out for Delivery"{
                
                header.lblPendingStepper.font = AppFont.Regular.size(AppFontName.SourceSansPro, size: 10)
                header.lblPendingStepper.textColor = AppColor.whiteColor
                header.lblPendingStepper.backgroundColor = AppColor.stepperColor
                GlobalCustomMethods.shared.provideCornarRadius(btnRef: header.lblPendingStepper)
                header.lblPendingStepper.text = "1"
                
                header.lblConfirmedStepper.font = AppFont.Regular.size(AppFontName.SourceSansPro, size: 10)
                header.lblConfirmedStepper.textColor = AppColor.whiteColor
                header.lblConfirmedStepper.backgroundColor = AppColor.stepperColor
                GlobalCustomMethods.shared.provideCornarRadius(btnRef: header.lblConfirmedStepper)
                header.lblConfirmedStepper.text = "2"
                
                header.lblInTheKitchenStep.font = AppFont.Regular.size(AppFontName.SourceSansPro, size: 10)
                header.lblInTheKitchenStep.textColor = AppColor.whiteColor
                header.lblInTheKitchenStep.backgroundColor = AppColor.stepperColor
                GlobalCustomMethods.shared.provideCornarRadius(btnRef: header.lblInTheKitchenStep)
                header.lblInTheKitchenStep.text = "3"
                
                header.lblOutForDeliverStepper.font = AppFont.Regular.size(AppFontName.SourceSansPro, size: 10)
                header.lblOutForDeliverStepper.textColor = AppColor.whiteColor
                header.lblOutForDeliverStepper.backgroundColor = AppColor.stepperColor
                GlobalCustomMethods.shared.provideCornarRadius(btnRef: header.lblOutForDeliverStepper)
                header.lblOutForDeliverStepper.text = "4"
                
                header.lblDeliveredStepper.font = AppFont.Regular.size(AppFontName.SourceSansPro, size: 10)
                header.lblDeliveredStepper.textColor = AppColor.whiteColor
                header.lblDeliveredStepper.backgroundColor = AppColor.placeHolderColor
                GlobalCustomMethods.shared.provideCornarRadius(btnRef: header.lblDeliveredStepper)
                header.lblDeliveredStepper.text = "5"
                
                
                header.lblPendingStatus.font = AppFont.Regular.size(AppFontName.SourceSansPro, size: 10)
                header.lblPendingStatus.textColor = AppColor.stepperColor
                header.lblPendingStatus.text = "Pending"
                
                header.lblConfirmedStatus.font = AppFont.Regular.size(AppFontName.SourceSansPro, size: 10)
                header.lblConfirmedStatus.textColor = AppColor.stepperColor
                header.lblConfirmedStatus.text = "Confirmed"
                
                header.lblInTheKitchenStatus.font = AppFont.Regular.size(AppFontName.SourceSansPro, size: 10)
                header.lblInTheKitchenStatus.textColor = AppColor.stepperColor
                header.lblInTheKitchenStatus.text = "In the Kitchen"
                
                header.lblOutForDeliveryStatus.font = AppFont.Regular.size(AppFontName.SourceSansPro, size: 10)
                header.lblOutForDeliveryStatus.textColor = AppColor.stepperColor
                header.lblOutForDeliveryStatus.text = "Out For Delivery"
                
                header.lblDeliveredStatus.font = AppFont.Regular.size(AppFontName.SourceSansPro, size: 10)
                header.lblDeliveredStatus.textColor = AppColor.subtitleColor
                header.lblDeliveredStatus.text = "Delivered"
                
                
                header.viewPToC.backgroundColor = AppColor.stepperColor
                header.viewCToK.backgroundColor = AppColor.stepperColor
                header.viewIToO.backgroundColor = AppColor.stepperColor
                header.viewOToD.backgroundColor = AppColor.subtitleColor
                
            }else{
                
                header.lblPendingStepper.font = AppFont.Regular.size(AppFontName.SourceSansPro, size: 10)
                header.lblPendingStepper.textColor = AppColor.whiteColor
                header.lblPendingStepper.backgroundColor = AppColor.stepperColor
                GlobalCustomMethods.shared.provideCornarRadius(btnRef: header.lblPendingStepper)
                header.lblPendingStepper.text = "1"
                
                header.lblConfirmedStepper.font = AppFont.Regular.size(AppFontName.SourceSansPro, size: 10)
                header.lblConfirmedStepper.textColor = AppColor.whiteColor
                header.lblConfirmedStepper.backgroundColor = AppColor.stepperColor
                GlobalCustomMethods.shared.provideCornarRadius(btnRef: header.lblConfirmedStepper)
                header.lblConfirmedStepper.text = "2"
                
                header.lblInTheKitchenStep.font = AppFont.Regular.size(AppFontName.SourceSansPro, size: 10)
                header.lblInTheKitchenStep.textColor = AppColor.whiteColor
                header.lblInTheKitchenStep.backgroundColor = AppColor.stepperColor
                GlobalCustomMethods.shared.provideCornarRadius(btnRef: header.lblInTheKitchenStep)
                header.lblInTheKitchenStep.text = "3"
                
                header.lblOutForDeliverStepper.font = AppFont.Regular.size(AppFontName.SourceSansPro, size: 10)
                header.lblOutForDeliverStepper.textColor = AppColor.whiteColor
                header.lblOutForDeliverStepper.backgroundColor = AppColor.stepperColor
                GlobalCustomMethods.shared.provideCornarRadius(btnRef: header.lblOutForDeliverStepper)
                header.lblOutForDeliverStepper.text = "4"
                
                header.lblDeliveredStepper.font = AppFont.Regular.size(AppFontName.SourceSansPro, size: 10)
                header.lblDeliveredStepper.textColor = AppColor.whiteColor
                header.lblDeliveredStepper.backgroundColor = AppColor.stepperColor
                GlobalCustomMethods.shared.provideCornarRadius(btnRef: header.lblDeliveredStepper)
                header.lblDeliveredStepper.text = "5"
                
                
                header.lblPendingStatus.font = AppFont.Regular.size(AppFontName.SourceSansPro, size: 10)
                header.lblPendingStatus.textColor = AppColor.stepperColor
                header.lblPendingStatus.text = "Pending"
                
                header.lblConfirmedStatus.font = AppFont.Regular.size(AppFontName.SourceSansPro, size: 10)
                header.lblConfirmedStatus.textColor = AppColor.stepperColor
                header.lblConfirmedStatus.text = "Confirmed"
                
                header.lblInTheKitchenStatus.font = AppFont.Regular.size(AppFontName.SourceSansPro, size: 10)
                header.lblInTheKitchenStatus.textColor = AppColor.stepperColor
                header.lblInTheKitchenStatus.text = "In the Kitchen"
                
                header.lblOutForDeliveryStatus.font = AppFont.Regular.size(AppFontName.SourceSansPro, size: 10)
                header.lblOutForDeliveryStatus.textColor = AppColor.stepperColor
                header.lblOutForDeliveryStatus.text = "Out For Delivery"
                
                header.lblDeliveredStatus.font = AppFont.Regular.size(AppFontName.SourceSansPro, size: 10)
                header.lblDeliveredStatus.textColor = AppColor.stepperColor
                header.lblDeliveredStatus.text = "Delivered"
                
                
                header.viewPToC.backgroundColor = AppColor.stepperColor
                header.viewCToK.backgroundColor = AppColor.stepperColor
                header.viewIToO.backgroundColor = AppColor.stepperColor
                header.viewOToD.backgroundColor = AppColor.stepperColor
                
            }
            
            
            if onGoingModelArray[section].isSelected == true{
                header.btnTap.setImage(#imageLiteral(resourceName: "drop_down_ic-1"), for: .normal)
            }else{
                header.btnTap.setImage(#imageLiteral(resourceName: "drop_down_icon"), for: .normal)
            }
            
            
           
            
            if onGoingModelArray[section].cancel_status == 0{
                header.btnCancelRef.isHidden = true
                header.lblTime.isHidden = true
            }else{
                
                header.btnCancelRef.isHidden = true
                header.lblTime.isHidden = true
                header.btnCancelRef.tag = section
                header.btnCancelRef.addTarget(self, action: #selector(self.btnCancelTapped(sender:)), for: UIControl.Event.touchUpInside)
                
                
            }
            
            
            header.btnTap.tag = section
            header.btnTap.addTarget(self, action: #selector(self.tapSectionBtn(sender:)), for: UIControl.Event.touchUpInside)
            
            header.clipsToBounds = true
            GlobalCustomMethods.shared.provideCustomCornarRadius(btnRef: header, radius: 10)
            
            
            //Code by sonika
          /*  header.calTime.font = AppFont.Regular.size(AppFontName.SourceSansPro, size: 12)
            header.calTime.textColor = AppColor.themeColor
            header.calTime.text = "4.03"
            header.calTime.isHidden = false
            header.lblTime.isHidden = true
            header.btnCancelRef.isHidden = false
            header.btnCancelRef.titleLabel?.font = AppFont.Semibold.size(AppFontName.SourceSansPro, size: 16)
            header.btnCancelRef.setTitleColor(AppColor.whiteColor, for: .normal)
            header.btnCancelRef.backgroundColor = AppColor.themeColor
            header.btnCancelRef.setTitle("Cancel", for: .normal)*/
            
            return header
            
        }else if self.btnTag == 2{
            let header:PreviousOrderHeader = Bundle.main.loadNibNamed(PreviousOrderHeader.className, owner: self, options: nil)!.first! as! PreviousOrderHeader
              header.dateTimeLbl.text = previousModelArray[section].orderDate
            header.lblTitle.attributedText = GlobalCustomMethods.shared.attributedStringOffer(title: "\(previousModelArray[section].restaurant_name)", subTitle: "Order Id : \(previousModelArray[section].order_number)", subTitle2: "Delivered", delemit: "\n", sizeTitle: 16, sizeSubtitle2: 15, sizeSubtitle: 14, titleColor: AppColor.textColor, SubtitleColor: AppColor.subtitleColor, SubtitleColor2: AppColor.stepperColor)
            
            
            header.btnCancelRef.titleLabel?.font = AppFont.Semibold.size(AppFontName.SourceSansPro, size: 14)
            header.btnCancelRef.setTitleColor(AppColor.textColor, for: .normal)
            header.btnCancelRef.setTitle("  Rate Order", for: .normal)
            
            
            
            header.btnReorderRef.titleLabel?.font = AppFont.Semibold.size(AppFontName.SourceSansPro, size: 16)
            header.btnReorderRef.backgroundColor = AppColor.themeColor
            header.btnReorderRef.setTitleColor(AppColor.whiteColor, for: .normal)
            header.btnReorderRef.setTitle("  Reorder", for: .normal)
            
            
            if previousModelArray[section].isSelected == true{
                header.btnTap.setImage(#imageLiteral(resourceName: "drop_down_ic-1"), for: .normal)
            }else{
                header.btnTap.setImage(#imageLiteral(resourceName: "drop_down_icon"), for: .normal)
            }
            
            
            header.btnReorderRef.tag = section
            header.btnReorderRef.addTarget(self, action: #selector(self.btnReorderRef(sender:)), for: UIControl.Event.touchUpInside)
            
            header.btnTap.tag = section
            header.btnTap.addTarget(self, action: #selector(self.tapSectionBtn(sender:)), for: UIControl.Event.touchUpInside)
            
            header.btnCancelRef.tag = section
            header.btnCancelRef.addTarget(self, action: #selector(self.tapShareReviews(sender:)), for: UIControl.Event.touchUpInside)
            
            header.imgView.sd_setImage(with: URL(string: previousModelArray[section].restaurant_image), placeholderImage: UIImage(named: "user_signup"))
            
            header.clipsToBounds = true
            GlobalCustomMethods.shared.provideCustomCornarRadius(btnRef: header, radius: 10)
            return header
        }
        else{
            let header:MyOrderOnGoingHeaderView = Bundle.main.loadNibNamed(MyOrderOnGoingHeaderView.className, owner: self, options: nil)!.first! as! MyOrderOnGoingHeaderView
            header.lblTitle.attributedText = GlobalCustomMethods.shared.attributedStringOffer(title: upComingModelArray[section].restaurant_name, subTitle: "Order Id : \(upComingModelArray[section].order_number)", subTitle2: "", delemit: "\n", sizeTitle: 16, sizeSubtitle2: 15, sizeSubtitle: 14, titleColor: AppColor.textColor, SubtitleColor: AppColor.subtitleColor, SubtitleColor2: AppColor.placeHolderColor)
            
            header.dateTimeLbl.text = upComingModelArray[section].orderDate
//            header.calTime.font = AppFont.Regular.size(AppFontName.SourceSansPro, size: 12)
//            header.calTime.textColor = AppColor.themeColor
//            header.calTime.text = "4.03"
//            header.calTime.isHidden = false
            header.lblTime.isHidden = true
            header.btnCancelRef.isHidden = false
            header.btnCancelRef.titleLabel?.font = AppFont.Semibold.size(AppFontName.SourceSansPro, size: 16)
            header.btnCancelRef.setTitleColor(AppColor.whiteColor, for: .normal)
            header.btnCancelRef.backgroundColor = AppColor.themeColor
            header.btnCancelRef.setTitle("Cancel", for: .normal)
            GlobalCustomMethods.shared.provideCustomCornarRadius(btnRef: header.btnCancelRef, radius: 5)
            header.imgView.sd_setImage(with: URL(string: upComingModelArray[section].restaurant_image), placeholderImage: UIImage(named: "user_signup"))
            
            header.btnTap.tag = section
            header.btnTap.addTarget(self, action: #selector(self.tapSectionBtn(sender:)), for: UIControl.Event.touchUpInside)
            
            if upComingModelArray[section].isSelected == true{
                header.btnTap.setImage(#imageLiteral(resourceName: "drop_down_ic-1"), for: .normal)
            }else{
                header.btnTap.setImage(#imageLiteral(resourceName: "drop_down_icon"), for: .normal)
            }
            
            header.stopTimer()
            header.count = upComingModelArray[section].cancel_time
            header.timer = Timer.scheduledTimer(timeInterval: 1.0, target: header, selector: #selector(header.update), userInfo: nil, repeats: true)
            
            if upComingModelArray[section].cancel_status == 0{
                header.btnCancelRef.isHidden = true
                header.lblTime.isHidden = true
            }else{
                
                header.btnCancelRef.isHidden = false
                header.lblTime.isHidden = false
                header.btnCancelRef.tag = section
                header.btnCancelRef.addTarget(self, action: #selector(self.btnCancelTapped(sender:)), for: UIControl.Event.touchUpInside)
                
                
            }
            
            //code by sonika
            
            
        /*    header.lblPendingStepper.font = AppFont.Regular.size(AppFontName.SourceSansPro, size: 10)
            header.lblPendingStepper.textColor = AppColor.whiteColor
            header.lblPendingStepper.backgroundColor = AppColor.stepperColor
            GlobalCustomMethods.shared.provideCornarRadius(btnRef: header.lblPendingStepper)
            header.lblPendingStepper.text = "1"
            header.lblPendingStepper.isHidden = true
            
            header.lblConfirmedStepper.font = AppFont.Regular.size(AppFontName.SourceSansPro, size: 10)
            header.lblConfirmedStepper.textColor = AppColor.whiteColor
            header.lblConfirmedStepper.backgroundColor = AppColor.stepperColor
            GlobalCustomMethods.shared.provideCornarRadius(btnRef: header.lblConfirmedStepper)
            header.lblConfirmedStepper.text = "2"
            header.lblConfirmedStepper.isHidden = true
            
            header.lblInTheKitchenStep.font = AppFont.Regular.size(AppFontName.SourceSansPro, size: 10)
            header.lblInTheKitchenStep.textColor = AppColor.whiteColor
            header.lblInTheKitchenStep.backgroundColor = AppColor.stepperColor
            GlobalCustomMethods.shared.provideCornarRadius(btnRef: header.lblInTheKitchenStep)
            header.lblInTheKitchenStep.text = "3"
            header.lblInTheKitchenStep.isHidden = true
            
            header.lblOutForDeliverStepper.font = AppFont.Regular.size(AppFontName.SourceSansPro, size: 10)
            header.lblOutForDeliverStepper.textColor = AppColor.whiteColor
            header.lblOutForDeliverStepper.backgroundColor = AppColor.stepperColor
            GlobalCustomMethods.shared.provideCornarRadius(btnRef: header.lblOutForDeliverStepper)
            header.lblOutForDeliverStepper.text = "4"
            header.lblOutForDeliverStepper.isHidden = true
            
            header.lblDeliveredStepper.font = AppFont.Regular.size(AppFontName.SourceSansPro, size: 10)
            header.lblDeliveredStepper.textColor = AppColor.whiteColor
            header.lblDeliveredStepper.backgroundColor = AppColor.stepperColor
            GlobalCustomMethods.shared.provideCornarRadius(btnRef: header.lblDeliveredStepper)
            header.lblDeliveredStepper.text = "5"
            header.lblDeliveredStepper.isHidden = true
            
            
            header.lblPendingStatus.font = AppFont.Regular.size(AppFontName.SourceSansPro, size: 10)
            header.lblPendingStatus.textColor = AppColor.stepperColor
            header.lblPendingStatus.text = "Pending"
            header.lblPendingStatus.isHidden = true
            
            header.lblConfirmedStatus.font = AppFont.Regular.size(AppFontName.SourceSansPro, size: 10)
            header.lblConfirmedStatus.textColor = AppColor.stepperColor
            header.lblConfirmedStatus.text = "Confirmed"
            header.lblConfirmedStatus.isHidden = true
            
            header.lblInTheKitchenStatus.font = AppFont.Regular.size(AppFontName.SourceSansPro, size: 10)
            header.lblInTheKitchenStatus.textColor = AppColor.stepperColor
            header.lblInTheKitchenStatus.text = "In the Kitchen"
            header.lblInTheKitchenStatus.isHidden = true
            
            
            header.lblOutForDeliveryStatus.font = AppFont.Regular.size(AppFontName.SourceSansPro, size: 10)
            header.lblOutForDeliveryStatus.textColor = AppColor.stepperColor
            header.lblOutForDeliveryStatus.text = "Out For Delivery"
            header.lblOutForDeliveryStatus.isHidden = true
            
            header.lblDeliveredStatus.font = AppFont.Regular.size(AppFontName.SourceSansPro, size: 10)
            header.lblDeliveredStatus.textColor = AppColor.stepperColor
            header.lblDeliveredStatus.text = "Delivered"
            header.lblDeliveredStatus.isHidden = true
            
            
            header.viewPToC.backgroundColor = AppColor.stepperColor
            header.viewCToK.backgroundColor = AppColor.stepperColor
            header.viewIToO.backgroundColor = AppColor.stepperColor
            header.viewOToD.backgroundColor = AppColor.stepperColor
            
            header.viewPToC.isHidden = true
            header.viewCToK.isHidden = true
            
            header.viewIToO.isHidden = true
            header.viewOToD.isHidden = true */
            
            header.statusLbl.isHidden = true
            
            return header
        }
    }
    
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        
        if btnTag == 1{
            if onGoingModelArray[section].isSelected == true
            {
                let footer:InnerTableViewFooter = Bundle.main.loadNibNamed(InnerTableViewFooter.className, owner: self, options: nil)!.last! as! InnerTableViewFooter
                var eatType = ""
                
                if onGoingModelArray[section].eat_option == 0{
                   eatType = "Pick Up"
                }
                else if onGoingModelArray[section].eat_option == 1{
                    eatType = "Home Delivery"
                }
                else{
                    eatType = "Eat At Restaurant"
                }
                
                footer.lblTotolPrice.attributedText = GlobalCustomMethods.shared.attributedString(title: "Total Price :", subTitle: "USD \(onGoingModelArray[section].totalPrice)", delemit: " ", sizeTitle: 17, sizeSubtitle: 17, titleColor: AppColor.subtitleColor, SubtitleColor: AppColor.textColor)
                
                footer.lblAddress.font = AppFont.Regular.size(AppFontName.SourceSansPro, size: 14)
                footer.lblAddress.textColor = AppColor.textColor
                footer.lblAddress.text = onGoingModelArray[section].address
                
                footer.lblPaymentMode.attributedText = GlobalCustomMethods.shared.attributedStringOnGing(title: "Payment mode :", subTitle: onGoingModelArray[section].payment_type, delemit: " ", sizeTitle: 14, sizeSubtitle: 14, titleColor: AppColor.textColor, SubtitleColor: AppColor.subtitleColor)
                
                footer.eatTypeLbl.attributedText = GlobalCustomMethods.shared.attributedStringOnGing(title: "Eat Type : \(eatType)", subTitle: "", delemit: " ", sizeTitle: 14, sizeSubtitle: 14, titleColor: AppColor.textColor, SubtitleColor: AppColor.subtitleColor)
                //  footer.lblResName.attributedText = GlobalCustomMethods.shared.attributedStringOnGing(title: onGoingModelArray[section].restaurant_name, subTitle: "", delemit: " ", sizeTitle: 14, sizeSubtitle: 14, titleColor: AppColor.textColor, SubtitleColor: AppColor.subtitleColor)
                
                footer.lblResName.attributedText = GlobalCustomMethods.shared.attributedStringOnGing(title: "Delivery Address", subTitle: "", delemit: " ", sizeTitle: 14, sizeSubtitle: 14, titleColor: AppColor.textColor, SubtitleColor: AppColor.subtitleColor)
                
                
                if onGoingModelArray[section].expected_delivery_time == "" && onGoingModelArray[section].phone_number == "" && onGoingModelArray[section].delivery_peroson == ""{
                    
                    footer.lblDetails.isHidden = true
                    footer.lblDeliveryPerson.isHidden = true
                    
                }else{
                    footer.lblDetails.isHidden = false
                    footer.lblDeliveryPerson.isHidden = false
                    //                    footer.lblDetails.attributedText = GlobalCustomMethods.shared.attributedStringOnGing(title: "\(onGoingModelArray[section].restaurant_name)\n", subTitle: "Expected Delivery Time\n\(onGoingModelArray[section].expected_delivery_time)\n\nPhone Number\n\(onGoingModelArray[section].phone_number)", delemit: "\n", sizeTitle: 14, sizeSubtitle: 14, titleColor: AppColor.textColor, SubtitleColor: AppColor.subtitleColor)
                    
                    footer.lblDetails.attributedText = GlobalCustomMethods.shared.attributedStringOnGing1(title: "", subTitle: "Expected Delivery Time\n\(onGoingModelArray[section].expected_delivery_time)\n\nPhone Number\n\(onGoingModelArray[section].phone_number)", delemit: "\n", sizeTitle: 14, sizeSubtitle: 14, titleColor: AppColor.textColor, SubtitleColor: AppColor.subtitleColor)
                    
                    
                    
                    footer.lblDeliveryPerson.attributedText = GlobalCustomMethods.shared.attributedStringOnGing2(title: "Delivery Person", subTitle: "\(onGoingModelArray[section].delivery_peroson)", delemit: "\n", sizeTitle: 14, sizeSubtitle: 14, titleColor: AppColor.subtitleColor, SubtitleColor: AppColor.subtitleColor)
                }
                
                footer.delTimeLbl.text = "Deleivery Time:"
                footer.locationBtn.tag  = section
                footer.locationBtn.addTarget(self, action: #selector(locationTapped), for: .touchUpInside)
                footer.status1Lbl.isHidden = true
                footer.statusLbl.isHidden = true
                footer.pickdataLbl.isHidden = true
                footer.pickUpTmeLbl.isHidden = true
                return footer
            }else {
                return UIView(frame: CGRect.zero)
            }
        }else if btnTag == 2{
            if previousModelArray[section].isSelected == true
            {
                let footer:InnerTableViewFooter = Bundle.main.loadNibNamed(InnerTableViewFooter.className, owner: self, options: nil)!.last! as! InnerTableViewFooter
                
                var eatType = ""
                
                if previousModelArray[section].eat_option == 0{
                    eatType = "Pick Up"
                }
                else if previousModelArray[section].eat_option == 1{
                    eatType = "Home Delivery"
                }
                else{
                    eatType = "Eat At Restaurant"
                }
                
                 footer.eatTypeLbl.attributedText = GlobalCustomMethods.shared.attributedStringOnGing(title: "Eat Type : \(eatType)", subTitle: "", delemit: " ", sizeTitle: 14, sizeSubtitle: 14, titleColor: AppColor.textColor, SubtitleColor: AppColor.subtitleColor)
                
                footer.lblTotolPrice.attributedText = GlobalCustomMethods.shared.attributedString(title: "Total Price :", subTitle: "USD \(previousModelArray[section].price)", delemit: " ", sizeTitle: 17, sizeSubtitle: 17, titleColor: AppColor.subtitleColor, SubtitleColor: AppColor.textColor)
                
                footer.lblAddress.font = AppFont.Regular.size(AppFontName.SourceSansPro, size: 14)
                footer.lblAddress.textColor = AppColor.textColor
                footer.lblAddress.text = previousModelArray[section].address
                
                footer.lblPaymentMode.attributedText = GlobalCustomMethods.shared.attributedStringOnGing(title: "Payment mode :", subTitle: previousModelArray[section].payment_type, delemit: " ", sizeTitle: 14, sizeSubtitle: 14, titleColor: AppColor.textColor, SubtitleColor: AppColor.subtitleColor)
                
                footer.lblDetails.attributedText = GlobalCustomMethods.shared.attributedStringOnGing(title: "Delivered Time", subTitle: "\(previousModelArray[section].order_place_time)", delemit: "\n", sizeTitle: 14, sizeSubtitle: 14, titleColor: AppColor.textColor, SubtitleColor: AppColor.subtitleColor)
                
                footer.lblResName.attributedText = GlobalCustomMethods.shared.attributedStringOnGing(title: previousModelArray[section].restaurant_name, subTitle: "", delemit: " ", sizeTitle: 14, sizeSubtitle: 14, titleColor: AppColor.textColor, SubtitleColor: AppColor.subtitleColor)
                
                footer.lblDeliveryPerson.isHidden = true
                
                footer.locationBtn.tag  = section
                footer.locationBtn.addTarget(self, action: #selector(locationTapped), for: .touchUpInside)
                return footer
            }else {
                return UIView(frame: CGRect.zero)
            }
        }
            
        else{
            if upComingModelArray[section].isSelected == true
            {
                let footer:InnerTableViewFooter = Bundle.main.loadNibNamed(InnerTableViewFooter.className, owner: self, options: nil)!.last! as! InnerTableViewFooter
                var eatType = ""
                
                if upComingModelArray[section].eat_option == 0{
                    eatType = "Pick Up"
                    
                    footer.lblDetails.text = "Status"
                    footer.delTimeLbl.text = "Pick Up Date:"
                    footer.pickUpTmeLbl.text = "Pick Up Time:"
                    footer.pickdataLbl.text = upComingModelArray[section].pickup_time
                   
                    footer.status1Lbl.text = upComingModelArray[section].deliveryStatus as? String ?? ""
                    footer.extraLbl.text = upComingModelArray[section].pickup_date
                    footer.status1Lbl.isHidden = false
                    footer.statusLbl.isHidden = false
                    
                }
                else if upComingModelArray[section].eat_option == 1{
                    eatType = "Home Delivery"
                    
                    footer.lblDetails.text = "Status"
                    footer.delTimeLbl.text = "Pick Up Date:"
                    footer.status1Lbl.text = upComingModelArray[section].deliveryStatus as? String ?? ""
                     footer.pickdataLbl.text = upComingModelArray[section].pickup_time
                    
                      footer.pickUpTmeLbl.text = "Pick Up Time:"
                    footer.extraLbl.text = upComingModelArray[section].pickup_date
                    footer.status1Lbl.isHidden = false
                    footer.statusLbl.isHidden = false
                }
                else{
                    eatType = "Eat At Restaurant"
                    
                    footer.lblDetails.text = "Status"
                    footer.delTimeLbl.text = "Eat Date:"
                    footer.pickUpTmeLbl.text = "Eat Time:"
                     footer.pickdataLbl.text = upComingModelArray[section].vist_time
                    
                    footer.status1Lbl.text = upComingModelArray[section].deliveryStatus as? String ?? ""
                    footer.extraLbl.text = upComingModelArray[section].vist_date
                    footer.status1Lbl.isHidden = false
                    footer.statusLbl.isHidden = false
                }
                
                footer.lblTotolPrice.attributedText = GlobalCustomMethods.shared.attributedString(title: "Total Price :", subTitle: "USD \(upComingModelArray[section].totalPrice)", delemit: " ", sizeTitle: 17, sizeSubtitle: 17, titleColor: AppColor.subtitleColor, SubtitleColor: AppColor.textColor)
                
                footer.lblAddress.font = AppFont.Regular.size(AppFontName.SourceSansPro, size: 14)
                footer.lblAddress.textColor = AppColor.textColor
                footer.lblAddress.text = upComingModelArray[section].address
                
                footer.lblPaymentMode.attributedText = GlobalCustomMethods.shared.attributedStringOnGing(title: "Payment mode :", subTitle: upComingModelArray[section].payment_type, delemit: " ", sizeTitle: 14, sizeSubtitle: 14, titleColor: AppColor.textColor, SubtitleColor: AppColor.subtitleColor)
                
                footer.eatTypeLbl.attributedText = GlobalCustomMethods.shared.attributedStringOnGing(title: "Eat Type : \(eatType)", subTitle: "", delemit: " ", sizeTitle: 14, sizeSubtitle: 14, titleColor: AppColor.textColor, SubtitleColor: AppColor.subtitleColor)
                //  footer.lblResName.attributedText = GlobalCustomMethods.shared.attributedStringOnGing(title: onGoingModelArray[section].restaurant_name, subTitle: "", delemit: " ", sizeTitle: 14, sizeSubtitle: 14, titleColor: AppColor.textColor, SubtitleColor: AppColor.subtitleColor)
                
                footer.lblResName.attributedText = GlobalCustomMethods.shared.attributedStringOnGing(title: "Delivery Address", subTitle: "", delemit: " ", sizeTitle: 14, sizeSubtitle: 14, titleColor: AppColor.textColor, SubtitleColor: AppColor.subtitleColor)
                
                
                if upComingModelArray[section].expected_delivery_time == "" && upComingModelArray[section].phone_number == "" && upComingModelArray[section].delivery_peroson == ""{
                    
                    footer.lblDetails.isHidden = true
                    footer.lblDeliveryPerson.isHidden = true
                    
                }else{
                    footer.lblDetails.isHidden = false
                    footer.lblDeliveryPerson.isHidden = false
                    //                    footer.lblDetails.attributedText = GlobalCustomMethods.shared.attributedStringOnGing(title: "\(onGoingModelArray[section].restaurant_name)\n", subTitle: "Expected Delivery Time\n\(onGoingModelArray[section].expected_delivery_time)\n\nPhone Number\n\(onGoingModelArray[section].phone_number)", delemit: "\n", sizeTitle: 14, sizeSubtitle: 14, titleColor: AppColor.textColor, SubtitleColor: AppColor.subtitleColor)
                    
                    footer.lblDetails.attributedText = GlobalCustomMethods.shared.attributedStringOnGing1(title: "", subTitle: "Expected Delivery Time\n\(upComingModelArray[section].expected_delivery_time)\n\nPhone Number\n\(upComingModelArray[section].phone_number)", delemit: "\n", sizeTitle: 14, sizeSubtitle: 14, titleColor: AppColor.textColor, SubtitleColor: AppColor.subtitleColor)
                    
                    
                    
                    footer.lblDeliveryPerson.attributedText = GlobalCustomMethods.shared.attributedStringOnGing2(title: "Delivery Person", subTitle: "\(upComingModelArray[section].delivery_peroson)", delemit: "\n", sizeTitle: 14, sizeSubtitle: 14, titleColor: AppColor.subtitleColor, SubtitleColor: AppColor.subtitleColor)
                    
                    footer.locationBtn.tag  = section
                    footer.locationBtn.addTarget(self, action: #selector(locationTapped), for: .touchUpInside)
                    
                }
                
                return footer
            }else {
                return UIView(frame: CGRect.zero)
            }
            
        }
        
    }
    
    
    @objc func locationTapped(sender:UIButton){
         if btnTag == 1{
            if (UIApplication.shared.canOpenURL(NSURL(string:"comgooglemaps://")! as URL)) {
                UIApplication.shared.openURL(NSURL(string:
                    "comgooglemaps://?saddr=&daddr=\(onGoingModelArray[sender.tag].latitude),\(onGoingModelArray[sender.tag].longitude)&directionsmode=driving")! as URL)
                
            } else {
                NSLog("Can't use comgooglemaps://");
            }
        }
         else if btnTag == 2{
            if (UIApplication.shared.canOpenURL(NSURL(string:"comgooglemaps://")! as URL)) {
                UIApplication.shared.openURL(NSURL(string:
                    "comgooglemaps://?saddr=&daddr=\(previousModelArray[sender.tag].latitude),\(previousModelArray[sender.tag].longitude)&directionsmode=driving")! as URL)
                
            } else {
                NSLog("Can't use comgooglemaps://");
            }
         }
         else {
            if (UIApplication.shared.canOpenURL(NSURL(string:"comgooglemaps://")! as URL)) {
                UIApplication.shared.openURL(NSURL(string:
                    "comgooglemaps://?saddr=&daddr=\(upComingModelArray[sender.tag].latitude),\(upComingModelArray[sender.tag].longitude)&directionsmode=driving")! as URL)
                
            } else {
                NSLog("Can't use comgooglemaps://");
            }
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if btnTag == 1{
            return 200
        }
        else if btnTag == 2{
            return 250
        }
        else{
            return 200
        }
        
        
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForHeaderInSection section: Int) -> CGFloat {
        if btnTag == 1{
            return 200
        }
        else if btnTag == 2{
            return 250
        }
        else{
            return 200
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if btnTag == 1{
            if onGoingModelArray[section].isSelected == true {
                
                
                if onGoingModelArray[section].expected_delivery_time == "" && onGoingModelArray[section].phone_number == "" && onGoingModelArray[section].delivery_peroson == ""{
                    
                    return 300
                    
                }else{
                    return 420
                }
                
                
            }else {
                return 1
            }
        }else if btnTag == 2{
            if previousModelArray[section].isSelected == true {
                if previousModelArray[section].delivered_time == ""{
                    
                    return 300
                    
                }else{
                    return 460
                }
                
                
            }else {
                return 1
            }
        }
            
        else{
            if upComingModelArray[section].isSelected == true {
                
                
                if upComingModelArray[section].expected_delivery_time == "" && upComingModelArray[section].phone_number == "" && upComingModelArray[section].delivery_peroson == ""{
                    
                    return 400
                    
                }else{
                    return 480
                }
                
                
            }else {
                return 1
            }
        }
    }
    
}

