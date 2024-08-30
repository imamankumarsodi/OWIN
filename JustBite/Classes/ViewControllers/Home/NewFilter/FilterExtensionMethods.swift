//
//  FilterExtensionMethods.swift
//  JustBite
//
//  Created by cst on 31/01/20.
//  Copyright © 2020 Mobulous. All rights reserved.
//

import Foundation
import UIKit

extension FilterViewController{
    
    //TODO: Navigation setup
    
    internal func navigationSetUpView() {
        preferredStatusBarStyle
        super.transparentNavigation()
        super.hideNavigationBar(false)
        
        let colorTop =  UIColor(red: 152.0/255.0, green: 24.0/255.0, blue: 37.0/255.0, alpha: 0.8).cgColor
        
        let colorMid = UIColor(red: 254.0/255.0, green: 116.0/255.0, blue: 47.0/255.0, alpha: 0.8).cgColor
        let colorMid1 = UIColor(red: 255.0/255.0, green: 201.0/255.0, blue: 75.0/255.0, alpha: 0.8).cgColor
        let colorBottom = UIColor(red: 119.0/255.0, green: 180.0/255.0, blue: 87.0/255.0, alpha: 0.8).cgColor
        
        gradientLayer.colors = [colorTop,colorMid,colorMid1,colorBottom]
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.4)
        gradientLayer.endPoint = CGPoint(x: 0.8, y: 0.4)
        
        
        gradientLayer.frame = self.GradinetView.bounds
        
        self.GradinetView.layer.insertSublayer(gradientLayer, at:0)
        super.addColorToNavigationBarAndSafeArea(color: gradientLayer, className: MyFavroiteVC.className)
        super.setupNavigationBarTitle("Filters", leftBarButtonsType: [.back], rightBarButtonsType: [])
        
    }
    
    func initialSetUp(){
          filterTV.register(UINib(nibName: "FilterTableViewCell", bundle: nil), forCellReuseIdentifier: "FilterTableViewCell")
    }
}

extension FilterViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return typeArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:FilterTableViewCell = filterTV.dequeueReusableCell(withIdentifier: "FilterTableViewCell", for: indexPath) as! FilterTableViewCell
        
        if indexPath.row == 0{
            cell.headingLbl.text = "Taste:"
            cell.selectorBtn.setImage(UIImage(named: "f_checked"), for: .normal)
            cell.itemsCV.register(UINib(nibName: "FilterCollectionViewCell", bundle: .main), forCellWithReuseIdentifier: "FilterCollectionViewCell")
            cell.itemsCV.delegate = self
            cell.itemsCV.dataSource = self
             return cell
        }
        else if indexPath.row == 1{
            cell.headingLbl.text = "Ratings:"
            cell.selectorBtn.setImage(UIImage(named: "f_uncheck"), for: .normal)
            cell.collectionHeight.constant = 0
            
            cell.itemsCV.register(UINib(nibName: "FilterCollectionViewCell", bundle: .main), forCellWithReuseIdentifier: "FilterCollectionViewCell")
            cell.itemsCV.delegate = self
            cell.itemsCV.dataSource = self
              return cell
        }
        else if indexPath.row == 2{
            cell.headingLbl.text = "Type:"
            cell.selectorBtn.setImage(UIImage(named: "f_checked"), for: .normal)
            
            cell.itemsCV.register(UINib(nibName: "FilterCollectionViewCell", bundle: .main), forCellWithReuseIdentifier: "FilterCollectionViewCell")
            cell.itemsCV.delegate = self
            cell.itemsCV.dataSource = self
              return cell
        }
        else if indexPath.row == 3{
            cell.headingLbl.text = "Eat Type:"
            cell.selectorBtn.setImage(UIImage(named: "f_checked"), for: .normal)
            
            cell.itemsCV.register(UINib(nibName: "FilterCollectionViewCell", bundle: .main), forCellWithReuseIdentifier: "FilterCollectionViewCell")
            cell.itemsCV.delegate = self
            cell.itemsCV.dataSource = self
            
            return cell
        }
        
    
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    
}

extension FilterViewController:UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell:FilterCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "FilterCollectionViewCell", for: indexPath) as! FilterCollectionViewCell
      /*  if indexPath.row == 0{
            cell.dishLbl.text = tasteArray[indexPath.row]
            return cell
        }
        if indexPath.row == 1{
//            cell.dishLbl.text = tasteArray[indexPath.row]
            return cell
        }
        else if indexPath.row == 2{
            cell.dishLbl.text = typeArray[indexPath.row]
            return cell
        }
        else if indexPath.row == 3{
            cell.dishLbl.text = eatArray[indexPath.row]
            return cell
        }
        */
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
       return CGSize(width: collectionView.frame.size.width / 3, height: collectionView.frame.size.height)
    }
  
}
