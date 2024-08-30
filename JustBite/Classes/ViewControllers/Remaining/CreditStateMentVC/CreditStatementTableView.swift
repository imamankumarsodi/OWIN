//
//  CreditStatementTableView.swift
//  JustBite
//
//  Created by Aman on 16/05/19.
//  Copyright © 2019 Mobulous. All rights reserved.
//

import Foundation
import Foundation
import UIKit

extension CreditStatementVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
}

extension CreditStatementVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataStore.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CreditStatementsTableViewCell.className, for: indexPath) as? CreditStatementsTableViewCell else {
            fatalError(ConstantTexts.unexpectedIndexPath)
        }
        
        if indexPath.row % 2 == 0{
            cell.backgroundColor = #colorLiteral(red: 0.948936522, green: 0.9490727782, blue: 0.9489067197, alpha: 1)
        }else{
            cell.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        }
        
        cell.configureWith(info: dataStore[indexPath.row])
        
        return cell
    }
    
}

