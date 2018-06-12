//
//  NotificationCollectionViewCell.swift
//  FoodServiceProvider
//
//  Created by Index on 2/19/18.
//  Copyright © 2018 index-pc. All rights reserved.
//

import UIKit
import Localize_Swift

class NotificationCollectionViewCell: UICollectionViewCell
{
    
    var didSetupConstraints = false
    
    var label: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.appFont(ofSize: 16)
        label.setAlignment()
        label.sizeToFit()
        label.adjustsFontSizeToFitWidth = true
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var timeLabel: UILabel = {
        let label = UILabel()
        label.setAlignment()
        label.font = UIFont.appFont(ofSize: 12)
        label.numberOfLines = 0
        label.textColor = UIColor.appColor()
        label.setAlignment()
        label.sizeToFit()
        label.adjustsFontSizeToFitWidth = true
        label.contentMode = .scaleToFill
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var emotionIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    override init(frame: CGRect)
    {
        super.init(frame: frame)
        self.layer.cornerRadius = 5
        
        self.clipsToBounds = true
        self.backgroundColor = UIColor.init(hex: "e8f6f9")
        addViews()
        setNeedsUpdateConstraints()
        updateViewConstraints()
        
    }
    
    override func prepareForReuse()
    {
        
    }
    
    func addViews()
    {
        addSubview(label)
        addSubview(timeLabel)
        addSubview(emotionIcon)
    }
    
    func updateViewConstraints()
    {
        if (!didSetupConstraints)
        {
            label.snp.makeConstraints
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
                    //                make.width.equalTo(self.snp.width).multipliedBy(0.5)
                    make.centerY.equalTo(self.snp.centerY)
            }
            
            timeLabel.snp.makeConstraints
                {
                    make in
                    if Localize.currentLanguage() == "en" {
                        make.right.equalTo(self.snp.right).offset(-10)
                    } else {
                        make.left.equalTo(self.snp.left).offset(10)
                    }
                    make.height.equalTo(30)
                    make.bottom.equalTo(self.snp.bottom).offset(-3)
            }
            
            emotionIcon.snp.makeConstraints
                {
                    make in
                    
                    if Localize.currentLanguage() == "en" {
                        make.left.equalTo(label.snp.right)
                    } else {
                        make.right.equalTo(label.snp.left)
                    }
                    make.height.equalTo(30)
                    make.width.equalTo(30)
                    make.centerY.equalTo(label.snp.centerY)
            }
            
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


