//
//  DrawerTableViewCellAndXib.swift
//  JustBite
//
//  Created by Aman on 14/05/19.
//  Copyright © 2019 Mobulous. All rights reserved.
//

import UIKit

class DrawerTableViewCellAndXib: SBaseTableViewCell {
    
    //MARK: - IBOutlets
    
    @IBOutlet weak var imgPic: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblMoney: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    
    
    // MARK: - User Define Functions
    //TODO: Config TableViewCell
    
    public func configureCellWith(info: LeftMenuStruct) {
        self.imgPic.image = info.image
        self.lblTitle.text = info.title
        self.lblTitle.font = AppFont.Regular.size(AppFontName.SourceSansPro, size: 15)
        self.lblTitle.textColor = AppColor.subtitleColor
        GlobalCustomMethods.shared.provideCustomCornarRadius(btnRef: lblMoney, radius: 10)
        self.lblMoney.backgroundColor = AppColor.themeColor
        self.lblMoney.isHidden = info.isHidden
        self.lblMoney.font = AppFont.Regular.size(AppFontName.SourceSansPro, size: 15)
        self.lblMoney.textColor = AppColor.whiteColor
        self.lblMoney.text = "AED \(info.price ?? "0")"
    }
    
    
}
