//
//  chatListTableViewCell.swift
//  FoodServiceProvider
//
//  Created by Index on 1/7/18.
//  Copyright © 2018 index-pc. All rights reserved.
//

import UIKit
import Localize_Swift

class ChatListTableViewCell: UITableViewCell {
    
    var didSetupConstraints = false
    
    
    var onlineStatusLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.fontAwesome(ofSize: 15)
        label.textColor = .green
        label.isHidden = true
        label.layer.borderWidth = 2
        label.borderColor = .white
        label.layer.cornerRadius = 9
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = String.fontAwesomeIcon(code: "fa-circle")
        label.textAlignment = .center
        
        return label
    }()
    
    var nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.appFontRegular(ofSize: 16)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .navigationBarColor()
        label.sizeToFit()
        return label
        
    }()
    
    var userImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        
        return imageView
    }()
    var lastMessageLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.appFont(ofSize: 14)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .gray
        return label
        
    }()
    
    var numberOfUnreadMessages: UILabel = {
        let label = UILabel()
        label.font = UIFont.appFontBold(ofSize: 14)
        label.backgroundColor = .appColor()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.clipsToBounds = true
        label.layer.cornerRadius = 10
        label.textAlignment = .center
        return label
    }()
    
    var lastMessageTimeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.appFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .lightGray
        return label
    }()
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.backgroundColor = .white
        numberOfUnreadMessages.text = ""
        lastMessageLabel.text = ""
        nameLabel.text = ""
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .gray
        
        addViews()
        setNeedsUpdateConstraints()
        updateViewConstraints()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addViews() {
        addSubview(nameLabel)
        addSubview(userImage)
        addSubview(lastMessageLabel)
        addSubview(numberOfUnreadMessages)
        userImage.addSubview(onlineStatusLabel)
        addSubview(lastMessageTimeLabel)
    }
    
    func updateViewConstraints() {
        
        if (!didSetupConstraints) {
            
            userImage.snp.makeConstraints {
                make in
                if Localize.currentLanguage() == "ar" {
                    make.right.equalTo(self.snp.right).offset(-5)
                } else {
                    make.left.equalTo(self.snp.left).offset(5)
                }
                make.width.equalTo(self.snp.width).multipliedBy(0.25)
                make.top.equalTo(self.snp.top).offset(10)
                make.bottom.equalTo(self.snp.bottom).offset(-10)
            }
            
            onlineStatusLabel.snp.makeConstraints {
                make in
                if Localize.currentLanguage() == "ar" {
                    make.right.equalTo(userImage.snp.centerX).offset(-20)
                } else {
                    make.left.equalTo(userImage.snp.centerX).offset(20 )
                }
                make.width.equalTo(15)
                make.height.equalTo(15)
                make.bottom.equalTo(userImage.snp.centerY).offset(30)
            }
            
            nameLabel.snp.makeConstraints {
                make in
                if Localize.currentLanguage() == "ar" {
                    make.right.equalTo(userImage.snp.left).offset(-5)
                } else {
                    make.left.equalTo(userImage.snp.right).offset(5)
                }
                make.bottom.equalTo(lastMessageLabel.snp.top).offset(3)
                make.height.equalTo(20)
            }
            
            lastMessageLabel.snp.makeConstraints {
                make in
                make.right.equalTo(nameLabel.snp.right)
                make.left.equalTo(nameLabel.snp.left)
                make.centerY.equalTo(userImage.snp.centerY)
                make.height.equalTo(30)
            }
            
            numberOfUnreadMessages.snp.makeConstraints {
                make in
                if Localize.currentLanguage() == "ar" {
                    make.right.equalTo(nameLabel.snp.left).offset(-10)
                } else {
                    make.left.equalTo(nameLabel.snp.right).offset(10)
                }
                make.height.equalTo(20)
                make.width.equalTo(35)
                make.centerY.equalTo(nameLabel.snp.centerY)
            }
            lastMessageTimeLabel.snp.makeConstraints {
                make in
                if Localize.currentLanguage() == "ar" {
                    lastMessageTimeLabel.textAlignment = .left
                    make.left.equalTo(self.snp.left).offset(15)
                    make.right.equalTo(numberOfUnreadMessages.snp.left).offset(-5)
                } else {
                    lastMessageTimeLabel.textAlignment = .right
                    make.right.equalTo(self.snp.right).offset(-15)
                    make.left.equalTo(numberOfUnreadMessages.snp.right).offset(5)
                }
                make.centerY.equalTo(numberOfUnreadMessages.snp.centerY)
                make.height.equalTo(20)
                
            }
           
        }
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }

}
