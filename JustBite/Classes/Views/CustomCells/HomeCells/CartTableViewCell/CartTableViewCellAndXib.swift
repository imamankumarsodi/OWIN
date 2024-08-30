//
//  CartTableViewCellAndXib.swift
//  JustBite
//
//  Created by Aman on 13/05/19.
//  Copyright © 2019 Mobulous. All rights reserved.
//

import UIKit

class CartTableViewCellAndXib: SBaseTableViewCell {
    
    //MARK: IBOutlets
    
    @IBOutlet weak var imgType: UIImageView!
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var lblDetails: UILabel!
    @IBOutlet weak var btnMinusRef: UIButton!
    @IBOutlet weak var btnQtyRef: UIButton!
    @IBOutlet weak var btnPlusRef: UIButton!
    @IBOutlet weak var btnCustomizeRef: UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
  
    
    
}



extension CartTableViewCellAndXib{
    internal func configure(item:menuItemDataModel){ // Baad main isme data model pass karana hai
        lblDetails.attributedText = GlobalCustomMethods.shared.attributedString(title: item.name, subTitle: "USD \(item.price)", delemit: "\n", sizeTitle: 15, sizeSubtitle: 16, titleColor: AppColor.placeHolderColor, SubtitleColor: AppColor.textColor)
        
        btnMinusRef.titleLabel?.font = AppFont.Regular.size(AppFontName.SourceSansPro, size: 30)
        btnMinusRef.setTitleColor(AppColor.themeColor, for: .normal)
        
        btnPlusRef.titleLabel?.font = AppFont.Regular.size(AppFontName.SourceSansPro, size: 30)
        btnPlusRef.setTitleColor(AppColor.themeColor, for: .normal)
        
        
        
        GlobalCustomMethods.shared.provideCustomCornarRadius(btnRef: btnQtyRef, radius: 5)
        GlobalCustomMethods.shared.provideCustomBorder(btnRef: btnQtyRef)
        
        if item.customizeDataModelArray.count > 0{
            btnQtyRef.setTitle("\(item.totalQuantity)", for: .normal)
        }else{
            btnQtyRef.setTitle("\(item.quantity)", for: .normal)
        }
        
        
        
        
        print(item.img)
        imgView.sd_setImage(with: URL(string: item.img), placeholderImage: UIImage(named: "user_signup"))
        
        if item.item_type == 0{
          imgType.image = #imageLiteral(resourceName: "veg_symbol")
        }else{
            imgType.image = #imageLiteral(resourceName: "nonveg_symbol")
        }
        
//        if item.customizeDataModelArray.count > 0{
//            btnCustomizeRef.isHidden = false
//        btnCustomizeRef.titleLabel?.attributedText = GlobalCustomMethods.shared.attributedStringForUnderLine(title: "Customize", sizeTitle: 10, titleColor: AppColor.textColor)
//        }else{
//             btnCustomizeRef.isHidden = true
//        }
    }
    
    
    
}
