//
//  CreditStatementsTableViewCell.swift
//  JustBite
//
//  Created by Aman on 16/05/19.
//  Copyright © 2019 Mobulous. All rights reserved.
//

import UIKit

class CreditStatementsTableViewCell: UITableViewCell {
    @IBOutlet weak var lblDetails: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblPrice: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        lblDetails.font = AppFont.Regular.size(AppFontName.SourceSansPro, size: 15)
        lblDate.font = AppFont.Regular.size(AppFontName.SourceSansPro, size: 15)
        lblPrice.font = AppFont.Regular.size(AppFontName.SourceSansPro, size: 15)
        
        lblDetails.textColor = AppColor.subtitleColor
        lblDate.textColor = AppColor.subtitleColor
        
        
        
       
        
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    public func configureWith(info:TopupHistoryList){
        lblDetails.text = info.description
        lblDate.text = info.created_at
        lblPrice.text = "+AED \(info.price)"
        if info.type == "1"{
            lblPrice.textColor = AppColor.stepperColor
        }else{
             lblPrice.textColor = AppColor.themeColor
        }
    }
    
}
