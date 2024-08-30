//
//  ContactUsTableViewCell.swift
//  JustBite
//
//  Created by Aman on 16/05/19.
//  Copyright © 2019 Mobulous. All rights reserved.
//

import UIKit

class ContactUsTableViewCell: SBaseTableViewCell {
    
    @IBOutlet weak var viewMain: UIView!
    
    @IBOutlet weak var imgView: UIImageView!
    
    @IBOutlet weak var lblDetail: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        GlobalCustomMethods.shared.provideCustomBorder(btnRef: self.viewMain)
        lblDetail.font = AppFont.Regular.size(AppFontName.SourceSansPro, size: 16)
        lblDetail.textColor = AppColor.textColor
        
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    // MARK: - User Define Functions
    //TODO: Config TableViewCell
    
    public func configureCellWith(info: ContactUsStruct) {
        imgView.image = info.image
        lblDetail.text = info.title
        
    }
    
    
}
