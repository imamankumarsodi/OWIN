//
//  SBaseTableViewCell.swift
//  JustBite
//
//  Created by Aman on 04/05/19.
//  Copyright © 2019 Mobulous. All rights reserved.
//

import UIKit

class SBaseTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
