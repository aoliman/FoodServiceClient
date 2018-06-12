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
        label.font = UIFont.fontAwesome(ofSize: 20)
        label.textColor = .green
        label.isHidden = true
        label.layer.borderWidth = 3
       // label.borderWidthPreset = BorderWidthPreset(rawValue: 3)
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
        label.textColor = .darkGray
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
        nameLabel.addSubview(numberOfUnreadMessages)
        userImage.addSubview(onlineStatusLabel)
    }
    
    func updateViewConstraints() {
        
        if (!didSetupConstraints) {
            userImage.snp.makeConstraints {
                make in
                if Localize.currentLanguage() == "ar" {
                    make.right.equalTo(self.snp.right).offset(-10)
                } else {
                    make.left.equalTo(self.snp.left).offset(10)
                }
                make.width.equalTo(self.snp.width).multipliedBy(0.25)
                make.top.equalTo(self.snp.top).offset(5)
                make.bottom.equalTo(self.snp.bottom).offset(-5)
            }
            
            onlineStatusLabel.snp.makeConstraints {
                make in
                if Localize.currentLanguage() == "ar" {
                    make.right.equalTo(userImage.snp.centerX).offset(-20)
                } else {
                    make.left.equalTo(userImage.snp.centerX).offset(20 )
                }
                make.width.equalTo(20)
                make.height.equalTo(20)
                make.bottom.equalTo(userImage.snp.centerY).offset(30)
            }
            nameLabel.snp.makeConstraints {
                make in
                if Localize.currentLanguage() == "ar" {
                    make.right.equalTo(userImage.snp.left).offset(-10)
                } else {
                    make.left.equalTo(userImage.snp.right).offset(10)
                }
                make.top.equalTo(self.snp.top)
                make.width.equalTo(self.snp.width).multipliedBy(0.6)
                make.height.equalTo(30)
            }
            lastMessageLabel.snp.makeConstraints {
                make in
                make.right.equalTo(nameLabel.snp.right)
                make.left.equalTo(nameLabel.snp.left)
                make.top.equalTo(nameLabel.snp.bottom).offset(5)
                make.bottom.equalTo(self.snp.bottom).offset(-5)
            }
            numberOfUnreadMessages.snp.makeConstraints {
                make in
                if Localize.currentLanguage() == "ar" {
                    make.right.equalTo(nameLabel.snp.left)
                } else {
                    make.left.equalTo(nameLabel.snp.right)
                }
                make.height.equalTo(nameLabel.snp.height)
                make.width.equalTo(35)
                make.centerY.equalTo(self.snp.centerY)
            }
        }
        
    }

    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }

}
