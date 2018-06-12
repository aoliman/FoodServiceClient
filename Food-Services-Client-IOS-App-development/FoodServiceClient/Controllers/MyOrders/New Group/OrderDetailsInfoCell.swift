//
//  OrderDetailsInfoCollectionViewCell.swift
//  FoodServiceProvider
//
//  Created by Index on 2/6/18.
//  Copyright © 2018 index-pc. All rights reserved.
//

import UIKit
import Localize_Swift

class OrderDetailsInfoCell: UICollectionViewCell
{
    var didSetupConstraints = false
    
    var cellValues = [String]()
    
    var titleLable: UILabel = {
        let label = UILabel()
        label.setAlignment()
        label.font = UIFont.appFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var textLabel: UILabel = {
        let label = UILabel()
        label.setAlignment()
        label.textColor = .darkGray
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
        
        self.backgroundColor = UIColor.navigationBarColor().withAlphaComponent(0.1)
        
        addViews()
        setNeedsUpdateConstraints()
        updateViewConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addViews()
    {
        addSubview(textLabel)
        addSubview(titleLable)
    }
    
    func updateViewConstraints()
    {
        if (!didSetupConstraints)
        {
            titleLable.snp.makeConstraints
                {
                    make in
                    make.centerY.equalTo(self.snp.centerY)
                    make.width.equalTo(self.snp.width).multipliedBy(0.45)
                    make.height.equalTo(self.snp.height)
                    if Localize.currentLanguage() == "en"
                    {
                        make.left.equalTo(self.snp.left).offset(10)

                    } else {
                        make.right.equalTo(self.snp.right).offset(-10)

                    }
                    
            }
            textLabel.snp.makeConstraints
                {
                    make in
                    make.centerY.equalTo(self.snp.centerY)
                    make.width.equalTo(self.snp.width).multipliedBy(0.45)
                    make.height.equalTo(self.snp.height)
                    if Localize.currentLanguage() == "en"
                    {
                        make.left.equalTo(titleLable.snp.right)
                    }
                    else
                    {
                        make.right.equalTo(titleLable.snp.left)
                    }
            }
        }
    }
}

