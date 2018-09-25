//
//  UICollectionViewCell.swift
//  FoodServiceProvider
//
//  Created by Index on 2/1/18.
//  Copyright © 2018 index-pc. All rights reserved.
//

import Foundation
import UIKit
extension UICollectionViewCell
{
    func addBottomBorderWithColor()
    {
        let border = CALayer()
        border.backgroundColor = UIColor.appColor().withAlphaComponent(0.8).cgColor
        border.frame = CGRect(x: 0, y: self.frame.size.height - 1, width: self.frame.size.width, height: 1)
        self.layer.addSublayer(border)
    }
    func addLeftBorderWithColor() {
        let border = CALayer()
        border.backgroundColor = UIColor.appColor().withAlphaComponent(0.8).cgColor
        border.frame = CGRect(x: 0, y: 0, width: 1, height: self.frame.size.height)
        self.layer.addSublayer(border)
    }
    
    func addTopBorderWithColor() {
        let border = CALayer()
        border.backgroundColor = UIColor.appColor().withAlphaComponent(0.8).cgColor
        border.frame = CGRect(x: 0, y: 0, width: self.frame.size.width, height: 1)
        self.layer.addSublayer(border)
    }
    func addBottomBorderWithColor(_ color: UIColor)
    {
        let border = CALayer()
        border.backgroundColor = color.cgColor
        border.frame = CGRect(x: 0, y: self.frame.size.height - 1, width: self.frame.size.width, height: 1)
        self.layer.addSublayer(border)
    }
}

