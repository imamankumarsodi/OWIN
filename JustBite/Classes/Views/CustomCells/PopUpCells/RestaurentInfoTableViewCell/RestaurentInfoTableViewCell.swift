//
//  RestaurentInfoTableViewCell.swift
//  JustBite
//
//  Created by Aman on 14/05/19.
//  Copyright © 2019 Mobulous. All rights reserved.
//

import UIKit
import Cosmos
class RestaurentInfoTableViewCell: SBaseTableViewCell {
    
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblSubTitle: UILabel!
   
    @IBOutlet weak var viewRating: CosmosView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    public func configure(info:RestaurentReviewModel){
        self.lblTitle.font = AppFont.Regular.size(AppFontName.SourceSansPro, size: 15)
        self.lblTitle.text = info.user_name
        self.lblTitle.textColor = AppColor.themeColor
        self.lblSubTitle.attributedText = GlobalCustomMethods.shared.attributedString(title: "3 weeks ago\n", subTitle: info.review, delemit: "\n", sizeTitle: 12, sizeSubtitle: 14, titleColor: AppColor.placeHolderColor, SubtitleColor: AppColor.placeHolderColor)

        self.viewRating.rating = info.rating
    }
    
}
