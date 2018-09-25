////
////  NotificationCollectionViewCell.swift
////  FoodServiceProvider
////
////  Created by Index on 2/19/18.
////  Copyright © 2018 index-pc. All rights reserved.
////
//
//import UIKit
//import Localize_Swift
//
//class NotificationCollectionViewCell: UICollectionViewCell
//{
//
//    var didSetupConstraints = false
//
//    var label: UILabel = {
//        let label = UILabel()
//        label.textColor = .black
//        label.font = UIFont.appFont(ofSize: 16)
//        label.setAlignment()
//        label.sizeToFit()
//        label.adjustsFontSizeToFitWidth = true
//
//        label.translatesAutoresizingMaskIntoConstraints = false
//        return label
//    }()
//
//    var timeLabel: UILabel = {
//        let label = UILabel()
//        label.setAlignment()
//        label.font = UIFont.appFont(ofSize: 12)
//        label.numberOfLines = 0
//        label.textColor = UIColor.appColor()
//        label.setAlignment()
//        label.sizeToFit()
//        label.adjustsFontSizeToFitWidth = true
//        label.contentMode = .scaleToFill
//        label.translatesAutoresizingMaskIntoConstraints = false
//        return label
//    }()
//
//    var emotionIcon: UIImageView = {
//        let imageView = UIImageView()
//        imageView.contentMode = .scaleAspectFit
//        imageView.clipsToBounds = true
//        imageView.translatesAutoresizingMaskIntoConstraints = false
//
//        return imageView
//    }()
//
//    override init(frame: CGRect)
//    {
//        super.init(frame: frame)
//        self.layer.cornerRadius = 5
//
//        self.clipsToBounds = true
//        self.backgroundColor = UIColor.init(hex: "e8f6f9")
//        addViews()
//        setNeedsUpdateConstraints()
//        updateViewConstraints()
//
//    }
//
//    override func prepareForReuse()
//    {
//
//    }
//
//    func addViews()
//    {
//        addSubview(label)
//        addSubview(timeLabel)
//        addSubview(emotionIcon)
//    }
//
//    func updateViewConstraints()
//    {
//        if (!didSetupConstraints)
//        {
//            label.snp.makeConstraints
//                {
//                    make in
//                    if Localize.currentLanguage() == "en"
//                    {
//                        make.left.equalTo(self.snp.left).offset(10)
//                    }
//                    else
//                    {
//                        make.right.equalTo(self.snp.right).offset(-10)
//                    }
//                    //                make.width.equalTo(self.snp.width).multipliedBy(0.5)
//                    make.centerY.equalTo(self.snp.centerY)
//            }
//
//            timeLabel.snp.makeConstraints
//                {
//                    make in
//                    if Localize.currentLanguage() == "en" {
//                        make.right.equalTo(self.snp.right).offset(-10)
//                    } else {
//                        make.left.equalTo(self.snp.left).offset(10)
//                    }
//                    make.height.equalTo(30)
//                    make.bottom.equalTo(self.snp.bottom).offset(-3)
//            }
//
//            emotionIcon.snp.makeConstraints
//                {
//                    make in
//
//                    if Localize.currentLanguage() == "en" {
//                        make.left.equalTo(label.snp.right)
//                    } else {
//                        make.right.equalTo(label.snp.left)
//                    }
//                    make.height.equalTo(30)
//                    make.width.equalTo(30)
//                    make.centerY.equalTo(label.snp.centerY)
//            }
//
//        }
//
//    }
//
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//}
//
//


//
//  NotificationCell.swift
//  FoodServiceProvider
//
//  Created by Index on 6/21/18.
//  Copyright © 2018 index-pc. All rights reserved.
//

//import UIKit
//import Localize_Swift
//import SwiftIcons
//
//class NotificationCell: UICollectionViewCell {
//
//    var didSetupConstraints = false
//
//    var imageView: UIImageView = {
//
//        let imageView = UIImageView()
//        imageView.layer.masksToBounds = true
//        imageView.contentMode = .scaleAspectFill
//        imageView.translatesAutoresizingMaskIntoConstraints = false
//        imageView.clipsToBounds = true
//
//        return imageView
//    }()
//
//    var nameLabel: UILabel = {
//        let label = UILabel()
//        label.textColor = .black
//        label.font = UIFont.appFontRegular(ofSize: 16)
//        label.setAlignment()
//        label.sizeToFit()
//        label.adjustsFontSizeToFitWidth = true
//        label.translatesAutoresizingMaskIntoConstraints = false
//        return label
//    }()
//
//    var detailsLabel: UILabel = {
//        let label = UILabel()
//        label.textColor = .black
//        label.font = UIFont.appFont(ofSize: 16)
//        label.setAlignment()
//        if #available(iOS 10.0, *) {
//            label.adjustsFontForContentSizeCategory = true
//        } else {
//            // Fallback on earlier versions
//        }
//        label.numberOfLines = 0
//        label.sizeToFit()
//        label.adjustsFontSizeToFitWidth = true
//        label.translatesAutoresizingMaskIntoConstraints = false
//        return label
//    }()
//
//    var dateLabel:UILabel = {
//        let label = UILabel()
//        label.setAlignment()
//        label.textColor = .lightGray
//        label.isHidden = true
//        label.font = UIFont.appFont(ofSize: 14)
//        label.sizeToFit()
//        label.translatesAutoresizingMaskIntoConstraints = false
//
//        return label
//    }()
//
//    var newLabel: UILabel = {
//        let label = UILabel()
//        label.setAlignment()
//        label.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
//        label.isHidden = true
//        label.backgroundColor = .navigationBarColor()
//        label.font = UIFont.appFont(ofSize: 16)
//        label.text = "  new  ".localized()
//        label.clipsToBounds = true
//        label.layer.cornerRadius = 4
//        label.sizeToFit()
//        label.translatesAutoresizingMaskIntoConstraints = false
//        return label
//    }()
//
//    var clockIcon: UILabel = {
//        let label = UILabel()
//        label.isHidden = true
//        label.sizeToFit()
//        label.setIcon(icon: .fontAwesome(.clockO), iconSize: 16, color: .lightGray, bgColor: .clear)
//        label.setAlignment()
//        label.translatesAutoresizingMaskIntoConstraints = false
//        return label
//    }()
//
//
//    override init(frame: CGRect) {
//
//        super.init(frame: frame)
//        self.layer.cornerRadius = 5
//        self.clipsToBounds = true
//        addViews()
//        setNeedsUpdateConstraints()
//        updateViewConstraints()
//        let shadowPath2 = UIBezierPath(rect: self.bounds)
//        self.layer.masksToBounds = false
//        self.layer.shadowColor = UIColor.black.cgColor
//        self.layer.shadowOffset = CGSize(width: CGFloat(1.0), height: CGFloat(1.0))
//        self.layer.shadowOpacity = 0.08
//        self.layer.shadowPath = shadowPath2.cgPath
//        self.borderColor = UIColor.lightGray.withAlphaComponent(0.1)
//        self.layer.borderWidth = 1
//
//    }
//
//    override func prepareForReuse() {
//        clockIcon.isHidden = true
//        dateLabel.isHidden = true
//        newLabel.isHidden = true
//        imageView.image = nil
//        imageView.backgroundColor = UIColor.clear
//    }
//
//    func addViews() {
//
//        addSubview(clockIcon)
//        addSubview(dateLabel)
//        addSubview(imageView)
//        addSubview(detailsLabel)
//        addSubview(nameLabel)
//        addSubview(newLabel)
//    }
//    override func layoutSubviews() {
//        super.layoutSubviews()
//        self.imageView.layer.cornerRadius = CGFloat(roundf(Float(self.imageView.frame.size.width/2.0)))
////        detailsLabel.sizeToFit()
//    }
//
//    func updateViewConstraints() {
//
//        if (!didSetupConstraints) {
//
//            imageView.snp.makeConstraints {
//                make in
//                if Localize.currentLanguage() == "ar" {
//                    make.right.equalTo(self.snp.right).offset(-10)
//                } else {
//                    make.left.equalTo(self.snp.left).offset(10)
//                }
//                make.width.height.equalTo(self.snp.height).multipliedBy(0.7)
//                make.centerY.equalTo(self.snp.centerY)
//            }
//
//            nameLabel.snp.makeConstraints {
//                make in
//                if Localize.currentLanguage() == "ar" {
//                    make.right.equalTo(imageView.snp.left).offset(-10)
//                } else {
//                    make.left.equalTo(imageView.snp.right).offset(10)
//                }
//                make.top.equalTo(self.snp.top).offset(10)
//                make.height.equalTo(30)
//            }
//
//            detailsLabel.snp.makeConstraints() {
//                make in
//                make.top.equalTo(nameLabel.snp.bottom).offset(5)
//                make.bottom.equalTo(self.snp.bottom).offset(-5)
//                if Localize.currentLanguage() == "ar" {
//                    make.right.equalTo(imageView.snp.left).offset(-10)
//                    make.left.equalTo(self.snp.left).offset(10)
//                } else {
//                    make.left.equalTo(imageView.snp.right).offset(10)
//                    make.right.equalTo(self.snp.right).offset(-10)
//                }
//            }
//
//            clockIcon.snp.makeConstraints {
//                make in
//                if Localize.currentLanguage() == "ar" {
//                    make.left.equalTo(dateLabel.snp.right).offset(5)
//                } else {
//                    make.right.equalTo(dateLabel.snp.left).offset(-5)
//                }
//                make.centerY.equalTo(dateLabel.snp.centerY)
//            }
//
//            dateLabel.snp.makeConstraints {
//                make in
//
//                if Localize.currentLanguage() == "ar" {
//                    make.left.equalTo(self.snp.left).offset(10)
//                } else {
//                    make.right.equalTo(self.snp.right).offset(-10)
//                }
//                make.centerY.equalTo(nameLabel.snp.centerY)
//            }
//
//            newLabel.snp.makeConstraints {
//                make in
//
//                if Localize.currentLanguage() == "ar" {
//                    make.left.equalTo(self.snp.left).offset(10)
//                } else {
//                    make.right.equalTo(self.snp.right).offset(-10)
//                }
//                make.centerY.equalTo(nameLabel.snp.centerY)
//            }
//
//        }
//
//    }
//
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//
//
//}

import UIKit
import Localize_Swift
import SwiftIcons

class NotificationCell: UICollectionViewCell {
    
    var didSetupConstraints = false
    
    var imageView: UIImageView = {
        
        let imageView = UIImageView()
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        
        return imageView
    }()
    
    var nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.appFontRegular(ofSize: 16)
        label.setAlignment()
        label.sizeToFit()
        label.adjustsFontSizeToFitWidth = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var detailsLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.appFont(ofSize: 16)
        label.setAlignment()
        if #available(iOS 10.0, *) {
            label.adjustsFontForContentSizeCategory = true
        } else {
            // Fallback on earlier versions
        }
        label.numberOfLines = 0
        label.sizeToFit()
        label.adjustsFontSizeToFitWidth = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var dateLabel:UILabel = {
        let label = UILabel()
        label.setAlignment()
        label.textColor = .lightGray
        label.isHidden = true
        label.font = UIFont.appFont(ofSize: 14)
        label.sizeToFit()
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    var newLabel: UILabel = {
        let label = UILabel()
        label.setAlignment()
        label.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        label.isHidden = true
        label.backgroundColor = .navigationBarColor()
        label.font = UIFont.appFont(ofSize: 16)
        label.text = "  new  ".localized()
        label.clipsToBounds = true
        label.layer.cornerRadius = 4
        label.sizeToFit()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var clockIcon: UILabel = {
        let label = UILabel()
        label.isHidden = true
        label.sizeToFit()
        label.setIcon(icon: .fontAwesome(.clockO), iconSize: 16, color: .lightGray, bgColor: .clear)
        label.setAlignment()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        self.layer.cornerRadius = 5
        self.clipsToBounds = true
        addViews()
        setNeedsUpdateConstraints()
        updateViewConstraints()
        let shadowPath2 = UIBezierPath(rect: self.bounds)
        self.layer.masksToBounds = false
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize(width: CGFloat(1.0), height: CGFloat(1.0))
        self.layer.shadowOpacity = 0.08
        self.layer.shadowPath = shadowPath2.cgPath
        self.borderColor = UIColor.lightGray.withAlphaComponent(0.1)
        self.layer.borderWidth = 1
        
    }
    
    override func prepareForReuse() {
        clockIcon.isHidden = true
        dateLabel.isHidden = true
        newLabel.isHidden = true
        imageView.backgroundColor = .clear
        imageView.image = nil
    }
    
    func addViews() {
        
        addSubview(clockIcon)
        addSubview(dateLabel)
        addSubview(imageView)
        addSubview(detailsLabel)
        addSubview(nameLabel)
        addSubview(newLabel)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.imageView.layer.cornerRadius = CGFloat(roundf(Float(self.imageView.frame.size.width/2.0)))
        
    }
    
    func updateViewConstraints() {
        
        if (!didSetupConstraints) {
            
            imageView.snp.makeConstraints {
                make in
                if Localize.currentLanguage() == "ar" {
                    make.right.equalTo(self.snp.right).offset(-10)
                } else {
                    make.left.equalTo(self.snp.left).offset(10)
                }
                make.width.height.equalTo(self.snp.height).multipliedBy(0.7)
                make.centerY.equalTo(self.snp.centerY)
            }
            
            nameLabel.snp.makeConstraints {
                make in
                if Localize.currentLanguage() == "ar" {
                    make.right.equalTo(imageView.snp.left).offset(-10)
                } else {
                    make.left.equalTo(imageView.snp.right).offset(10)
                }
                make.top.equalTo(self.snp.top).offset(10)
                make.height.equalTo(30)
            }
            
            detailsLabel.snp.makeConstraints() {
                make in
                make.top.equalTo(nameLabel.snp.bottom).offset(5)
                make.bottom.equalTo(self.snp.bottom).offset(-5)
                if Localize.currentLanguage() == "ar" {
                    make.right.equalTo(imageView.snp.left).offset(-10)
                    make.left.equalTo(self.snp.left).offset(10)
                } else {
                    make.left.equalTo(imageView.snp.right).offset(10)
                    make.right.equalTo(self.snp.right).offset(-10)
                }
            }
            
            clockIcon.snp.makeConstraints {
                make in
                if Localize.currentLanguage() == "ar" {
                    make.left.equalTo(dateLabel.snp.right)
                    //                    make.right.equalTo(nameLabel.snp.left).offset(-5)
                } else {
                    make.right.equalTo(dateLabel.snp.left)
                    //                    make.left.equalTo(nameLabel.snp.right).offset(5)
                }
                make.centerY.equalTo(dateLabel.snp.centerY)
                make.width.height.equalTo(20)
            }
            
            dateLabel.snp.makeConstraints {
                make in
                
                if Localize.currentLanguage() == "ar" {
                    make.left.equalTo(self.snp.left).offset(10)
                } else {
                    make.right.equalTo(self.snp.right).offset(-10)
                }
                make.centerY.equalTo(nameLabel.snp.centerY)
            }
            
            newLabel.snp.makeConstraints {
                make in
                
                if Localize.currentLanguage() == "ar" {
                    make.left.equalTo(self.snp.left).offset(10)
                } else {
                    make.right.equalTo(self.snp.right).offset(-10)
                }
                make.centerY.equalTo(nameLabel.snp.centerY)
            }
            
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


