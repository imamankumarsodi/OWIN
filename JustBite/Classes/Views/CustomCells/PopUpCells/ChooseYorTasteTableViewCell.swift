//
//  ChooseYorTasteTableViewCell.swift
//  JustBite
//
//  Created by Aman on 14/05/19.
//  Copyright © 2019 Mobulous. All rights reserved.
//

import UIKit

class ChooseYorTasteTableViewCell: SBaseTableViewCell {

    @IBOutlet weak var imgSelected: UIImageView!
    @IBOutlet weak var lblDetails: UILabel!
    @IBOutlet weak var lblPrice: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    public func configure(info:AddOnDataModel,type:Int){
        self.lblDetails.font = AppFont.Regular.size(AppFontName.SourceSansPro, size: 15)
        self.lblPrice.font = AppFont.Regular.size(AppFontName.SourceSansPro, size: 15)
        self.lblDetails.textColor = AppColor.placeHolderColor
        self.lblPrice.textColor = AppColor.placeHolderColor
        self.lblDetails.text = info.name
        self.lblPrice.text = "AED \(info.price)"
        
        if type != 1{
            if info.isSelected{
                self.imageView?.image = #imageLiteral(resourceName: "s_box")
            }else{
                self.imageView?.image = #imageLiteral(resourceName: "un_box")
            }
        }else{
            if info.isSelected{
                self.imageView?.image = #imageLiteral(resourceName: "radio_button")
            }else{
                self.imageView?.image = #imageLiteral(resourceName: "un_salected_rb")
            }
        }
        
        
       
        
        
    }
    
}
