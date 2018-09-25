//
//  CookersOrderCollectionViewCell.swift
//  FoodServiceProvider
//
//  Created by Index on 2/20/18.
//  Copyright © 2018 index-pc. All rights reserved.
//

import UIKit
import Localize_Swift

class OrderCell: UICollectionViewCell {
    var didSetupConstraints = false
    
    var clientName: UILabel = {
        let label = UILabel()
        label.setAlignment()
        label.textColor = .darkGray
        label.font = UIFont.appFont(ofSize: 14)
        label.sizeToFit()
        label.adjustsFontSizeToFitWidth = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    var dateLabel:UILabel = {
        let label = UILabel()
        label.setAlignment()
        label.textColor = .lightGray
        label.font = UIFont.appFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var clockIcon: UILabel = {
        let label = UILabel()
        label.font = UIFont.fontAwesome(ofSize: 20)
        label.textColor = .lightGray
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = String.fontAwesomeIcon(code: "fa-clock-o")
        label.setAlignment()
        
        return label
    }()
    
    var orderNumberLabel: UILabel = {
        let label = UILabel()
        label.setAlignment()
        label.text = "Order number".localized()
        label.textColor = .darkGray
        label.font = UIFont.appFont(ofSize: 14)
        label.sizeToFit()
        label.adjustsFontSizeToFitWidth = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
        
    }()
    
    var orderNumber: UILabel = {
        let label = UILabel()
        if Localize.currentLanguage() == "en" {
            label.textAlignment = .right
        } else {
            label.textAlignment = .left
        }
        label.textColor = UIColor.appColor()
        label.font = UIFont.appFont(ofSize: 14)
        label.sizeToFit()
        label.adjustsFontSizeToFitWidth = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
        
    }()
    
    var priceLabel: UILabel = {
        let label = UILabel()
        label.setAlignment()
        label.text = "totalPrice".localized()
        label.textColor = .darkGray
        label.font = UIFont.appFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
        
    }()
    
    var price: UILabel = {
        let label = UILabel()
        if Localize.currentLanguage() == "en" {
            label.textAlignment = .right
        } else {
            label.textAlignment = .left
        }
        label.textColor = UIColor.appColor()
        label.font = UIFont.appFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
        
    }()
    
    override func prepareForReuse()
    {
        super.prepareForReuse()
    }
    
    override init(frame: CGRect)
    {
        super.init(frame: frame)
        self.layer.masksToBounds = true
        self.backgroundColor = UIColor.navigationBarColor().withAlphaComponent(0.15)
//        self.layer.borderColor = UIColor(red:0.91, green:0.91, blue:0.91, alpha:1.0).cgColor
//        self.borderWidth = 1
        addViews()
        setNeedsUpdateConstraints()
        updateViewConstraints()
    }
    
    
    
    func addViews()
    {
        addSubview(clientName)
        addSubview(orderNumber)
        addSubview(orderNumberLabel)
        addSubview(price)
        addSubview(priceLabel)
        addSubview(dateLabel)
        addSubview(clockIcon)
    }
    
    func updateViewConstraints()
    {
        if (!didSetupConstraints)
        {
            clientName.snp.makeConstraints
            {
                make in
                make.height.equalTo(35)
                make.right.equalTo(self.snp.right).offset(-10)
                make.top.equalTo(self.snp.top).offset(15)
                make.left.equalTo(self.snp.left).offset(10)
            }
            clockIcon.snp.makeConstraints
            {
                make in
                if Localize.currentLanguage() == "en" {
                    make.left.equalTo(self.snp.left).offset(10)
                } else {
                    make.right.equalTo(self.snp.right).offset(-10)
                }
                make.width.equalTo(25)
                make.height.equalTo(30)
                make.centerY.equalTo(dateLabel.snp.centerY)
            }
            dateLabel.snp.makeConstraints
            {
                make in
                
                make.height.equalTo(35)
                if Localize.currentLanguage() == "en" {
                    make.left.equalTo(clockIcon.snp.right).offset(5)
                    make.right.equalTo(self.snp.right).offset(-10)
                } else {
                    make.right.equalTo(clockIcon.snp.left).offset(-5)
                    make.left.equalTo(self.snp.left).offset(10)
                 }
                make.top.equalTo(clientName.snp.bottom).offset(-5)
            }
            orderNumberLabel.snp.makeConstraints
            {
                make in
                if Localize.currentLanguage() == "en" {
                    make.left.equalTo(self.snp.left).offset(10)
                } else {
                    make.right.equalTo(self.snp.right).offset(-10)
                }
                make.width.equalTo(self.snp.width).multipliedBy(0.43)
                make.height.equalTo(35)
                make.top.equalTo(dateLabel.snp.bottom)
            }
            orderNumber.snp.makeConstraints
            {
                make in
                if Localize.currentLanguage() == "en"
                {
                    make.right.equalTo(self.snp.right).offset(-10)
                }
                else
                {
                    make.left.equalTo(self.snp.left).offset(10)

                }
                make.height.equalTo(35)
                make.width.equalTo(self.snp.width).multipliedBy(0.43)
                make.top.equalTo(dateLabel.snp.bottom)
            }
            priceLabel.snp.makeConstraints
            {
                make in
                if Localize.currentLanguage() == "en"
                {
                    make.left.equalTo(self.snp.left).offset(10)
                }
                else
                {
                    make.right.equalTo(self.snp.right).offset(-10)
                }
                make.width.equalTo(self.snp.width).multipliedBy(0.43)
                make.height.equalTo(35)
                make.top.equalTo(orderNumber.snp.bottom)
            }
            price.snp.makeConstraints
            {
                make in
                if Localize.currentLanguage() == "en"
                {

                    make.right.equalTo(self.snp.right).offset(-10)

                }
                else
                {
                    make.left.equalTo(self.snp.left).offset(10)
                }
                make.height.equalTo(35)
                make.width.equalTo(self.snp.width).multipliedBy(0.43)
                make.top.equalTo(orderNumber.snp.bottom)
            }
        }
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
