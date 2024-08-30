//
//  OfferTableViewCellAndXib.swift
//  JustBite
//
//  Created by Aman on 16/05/19.
//  Copyright © 2019 Mobulous. All rights reserved.
//

import UIKit

class OfferTableViewCellAndXib: SBaseTableViewCell {
    
    @IBOutlet weak var noteLbl: UILabel!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var imgThumbnail: UIImageView!
    @IBOutlet weak var viewMain: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        
        GlobalCustomMethods.shared.provideShadow(btnRef: viewMain)
        GlobalCustomMethods.shared.provideCustomCornarRadius(btnRef: viewMain, radius: 5)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    public func configureWith(info:OfferListDataModel){
        
        let inputFormatter = DateFormatter()
        
        inputFormatter.dateFormat = "yyyy-MM-dd"
        let showDate = inputFormatter.date(from: info.valid_date)
        inputFormatter.dateFormat = "dd/MM/yyyy"
        let resultString = inputFormatter.string(from: showDate!)
        
        
    lblTitle.attributedText = GlobalCustomMethods.shared.attributedStringOffer(title: "\(info.note)", subTitle: "\(info.res_name)\n Get \(info.discount)% off on all orders", subTitle2: "This offer is valid from 12/04/2019 till \(resultString)", delemit: "\n", sizeTitle: 17, sizeSubtitle2: 14, sizeSubtitle: 15, titleColor: AppColor.textColor, SubtitleColor: AppColor.subtitleColor, SubtitleColor2: AppColor.placeHolderColor)
        self.imgThumbnail.sd_setImage(with: URL(string: info.thumbnail), placeholderImage: UIImage(named: "user_signup"))
    }
    
    
}
