//
//  ExtensionCookerOrdersViewController.swift
//  FoodServiceProvider
//
//  Created by Index on 2/25/18.
//  Copyright © 2018 index-pc. All rights reserved.
//

import Foundation
import Localize_Swift
import DropDown

extension MyOrdersVC
{
    
    
    func setAttributedButtonTitle()
    {
        let icon = NSMutableAttributedString(string: String.fontAwesomeIcon(code:"fa-caret-down")!, attributes: iconAttr)
        
        let orderAttrText = NSMutableAttributedString(string: "Order State".localized() + " " + " ", attributes: textAttr )
        orderAttrText.append(icon)
        statusButton.setAttributedTitle(orderAttrText, for: .normal)
    }
    
    func addViews()
    {
        self.view.addSubview(collectionView)
        self.view.addSubview(statusButton)
    }
    func dropDownSetup()
    {
        statusButton.addTarget(self, action: #selector(dropDown), for: .touchUpInside)
        
        orderStatusDropdown.anchorView = statusButton
        orderStatusDropdown.bottomOffset = CGPoint(x: (orderStatusDropdown.anchorView?.plainView.bounds.minX)!, y:((orderStatusDropdown.anchorView?.plainView.bounds.height)! + 50))
        orderStatusDropdown.dismissMode = .automatic
        
        orderStatusDropdown.dataSource = OrderStatus.getOrderStatus()
        
        
        orderStatusDropdown.customCellConfiguration = { (index: Index, item: String, cell: DropDownCell) -> Void in
            // Setup your custom UI components
            cell.optionLabel.textAlignment = .center
            cell.optionLabel.text = cell.optionLabel.text?.localized()
            if Localize.currentLanguage() == "en"
            {
            } else {
                self.orderStatusDropdown.layer.setAffineTransform(CGAffineTransform(scaleX: -1, y: 1))
                cell.layer.setAffineTransform(CGAffineTransform(scaleX: -1, y: 1))
            }
            
        }
        
        orderStatusDropdown.selectionAction =
            {
                [unowned self] (index: Int, item: String) in
                self.statusButton.setAttributedTitle(NSMutableAttributedString(string: item.localized() , attributes: self.textAttr), for: .normal)
                self.statusButton.backgroundColor = .clear
                //                self.delegate?.buttonTitleChanged(item)
                self.page = 0
                if index == 0 {
                    self.status = ""

                } else {
                    self.status = item

                }
                self.orderItems.removeAll()
                self.getOrders(limit: 10)
        }
        
        orderStatusDropdown.cancelAction = {
            if let title = self.orderStatusDropdown.selectedItem
            {
                self.statusButton.setAttributedTitle(NSMutableAttributedString(string: title , attributes: self.textAttr), for: .normal)
            }
            else
            {
                self.setAttributedButtonTitle()
            }
            self.statusButton.backgroundColor = .clear
        }
    }
    
    @objc func dropDown()
    {
        statusButton.backgroundColor = UIColor.navigationBarColor()
        let icon = NSMutableAttributedString(string: String.fontAwesomeIcon(code:"fa-caret-down")!, attributes: [NSAttributedStringKey.font : UIFont.fontAwesome(ofSize: 16),NSAttributedStringKey.foregroundColor: UIColor.white])
        let orderAttrText = NSMutableAttributedString(string: "Order State".localized() + " " + " ", attributes: [NSAttributedStringKey.foregroundColor: UIColor.white] )
        orderAttrText.append(icon)
        statusButton.setAttributedTitle(orderAttrText, for: .normal)
        orderStatusDropdown.show()
    }
    
    override func updateViewConstraints() {
        
        super.updateViewConstraints()
        if !didSetupConstraints {
            
            collectionView.snp.makeConstraints {
                make in
                make.left.equalTo(self.view.snp.left)
                make.right.equalTo(self.view.snp.right)
                make.top.equalTo(statusButton.snp.bottom).offset(17)
                make.bottom.equalTo(self.view.snp.bottom)
            }
            
            statusButton.snp.makeConstraints {
                make in
                make.height.equalTo(40)
                
                if Localize.currentLanguage() == "en" {
                    make.left.equalTo(self.view.snp.left).offset(10)
                    
                } else{
                    make.right.equalTo(self.view.snp.right).offset(-10)
                }
                make.top.equalTo(self.view.snp.top).offset(17)
                make.width.equalTo(130)
            }
        }
        didSetupConstraints = true
        
    }
}

