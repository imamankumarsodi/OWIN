//
//  TopUpOfferTableViewCell.swift
//  JustBite
//
//  Created by Aman on 16/05/19.
//  Copyright © 2019 Mobulous. All rights reserved.
//

import UIKit

class TopUpOfferTableViewCell: SBaseTableViewCell {
    
    @IBOutlet weak var imgSelected: UIImageView!
    @IBOutlet weak var lblDetails: UILabel!
   
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        configure()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    internal func configure(){
        self.lblDetails.font = AppFont.Regular.size(AppFontName.SourceSansPro, size: 17)
        self.lblDetails.textColor = AppColor.placeHolderColor
        self.lblDetails.text = "Cheeky Chicken"
//        self.imageView?.image = #imageLiteral(resourceName: "un_salected_rb")
        
    }
    
}
