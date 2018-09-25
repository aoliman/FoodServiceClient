//
//  DeliverPlaceOrderCollectionViewCell.swift
//  FoodServiceProvider
//
//  Created by Index on 2/5/18.
//  Copyright © 2018 index-pc. All rights reserved.
//

import UIKit
import Localize_Swift

class DeliverPlaceOrderCell: UICollectionViewCell
{
    var didSetupConstraints = false

    var type: UILabel = {
        let label = UILabel()
        label.setAlignment()
        label.textColor = .darkGray
        label.text = "type".localized()
        label.font = UIFont.appFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.adjustsFontSizeToFitWidth = true

        return label
    }()
    
    var quantity: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .darkGray
        label.text = "quantity".localized()
        label.font = UIFont.appFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.adjustsFontSizeToFitWidth = true

        return label
    }()
    
    var price: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .darkGray
        label.text = "Price".localized()
        label.font = UIFont.appFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.adjustsFontSizeToFitWidth = true

        return label
    }()
    var view: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    
  
    
    
    override func prepareForReuse()
    {
        super.prepareForReuse()
    }
    
    override init(frame: CGRect)
    {
        super.init(frame: frame)

        self.backgroundColor = UIColor.navigationBarColor().withAlphaComponent(0.1)

        addViews()
        setNeedsUpdateConstraints()
        updateViewConstraints()
    }
    
    func addViews()
    {
        addSubview(type)
        addSubview(view)
        view.addSubview(quantity)
        view.addSubview(price)
    }
    
    func updateViewConstraints()
    {
        if (!didSetupConstraints)
        {
            type.snp.makeConstraints
            {
                make in
                make.height.equalTo(self.snp.height)
                make.width.equalTo(self.snp.width).multipliedBy(0.4)
                make.centerY.equalTo(self.snp.centerY)
                if Localize.currentLanguage() == "en" {
                    make.left.equalTo(self.snp.left).offset(10)
                } else{
                    make.right.equalTo(self.snp.right).offset(-10)
                }
            }
            price.snp.makeConstraints
            {
                make in
                make.height.equalTo(self.snp.height)
                make.width.equalTo(self.snp.width).multipliedBy(0.3)
                make.centerY.equalTo(self.snp.centerY)
                if Localize.currentLanguage() == "en" {
                    make.right.equalTo(self.snp.right).offset(-10)
                } else {
                    make.left.equalTo(self.snp.left).offset(10)
                }
            }
            quantity.snp.makeConstraints
            {
                make in
                make.height.equalTo(self.snp.height)
                make.width.equalTo(self.snp.width).multipliedBy(0.3)
                make.centerY.equalTo(self.snp.centerY)
                if Localize.currentLanguage() == "en" {
                    make.right.equalTo(price.snp.left).offset(-10)
                } else {
                    make.left.equalTo(price.snp.right).offset(10)
                }
            }
            
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

