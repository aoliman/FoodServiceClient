//
//  ProfileInfoTableViewCell.swift
//  FoodServiceProvider
//
//  Created by Index on 1/2/18.
//  Copyright © 2018 index-pc. All rights reserved.
//

import UIKit
import Localize_Swift

class ProfileInfoTableViewCell: UITableViewCell
{
    var didSetupConstraints = false
    

    var onlineStatusLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.fontAwesome(ofSize: 20)
        label.textColor = .green
        label.borderColor = .white
        label.layer.cornerRadius = 9
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = String.fontAwesomeIcon(code: "fa-circle")
        label.textAlignment = .center
        
        return label
    }()
    let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.appFontBold(ofSize: 14)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.setAlignment()
        label.sizeToFit()
        label.contentMode = .scaleToFill
        
        return label
        
    }()
    
    var userImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        return imageView
    }()
    
    var mailLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.appFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.setAlignment()
        label.sizeToFit()
        label.contentMode = .scaleToFill

        return label
    }()
    var view: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override func prepareForReuse() {
        super.prepareForReuse()

        nameLabel.text = nil
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.userImage.convertToCircle()
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = .white
        self.selectionStyle = .none
        addViews()
        setNeedsUpdateConstraints()
        updateViewConstraints()
       
    }
    
    func addViews() {
        addSubview(view)
        view.addSubview(nameLabel)
        addSubview(userImage)
        userImage.addSubview(onlineStatusLabel)
        view.addSubview(mailLabel)
        userImage.layer.borderWidth = 0

    }
    
    func updateViewConstraints() {
        if (!didSetupConstraints) {
            userImage.snp.makeConstraints {
                make in
                if Localize.currentLanguage() == "en" {
                    make.left.equalTo(self.snp.left).offset(15)
                } else {
                    make.right.equalTo(self.snp.right).offset(-15)
                }
                make.width.equalTo(self.snp.width).multipliedBy(0.35)
                make.centerY.equalTo(self.snp.centerY)
                make.height.equalTo(self.snp.height).multipliedBy(0.5)
            }
            onlineStatusLabel.snp.makeConstraints {
                make in
                if Localize.currentLanguage() == "en" {
                    make.right.equalTo(userImage.snp.centerX).offset(-20)
                } else {
                    make.left.equalTo(userImage.snp.centerX).offset(20)
                }
                make.width.equalTo(20)
                make.height.equalTo(20)
                make.bottom.equalTo(userImage.snp.centerY).offset(35)
            }
            view.snp.makeConstraints {
                make in
                make.height.equalTo(60)
                if Localize.currentLanguage() == "en" {
                    make.left.equalTo(userImage.snp.right).offset(10)
                    make.right.equalTo(self.snp.right).offset(-10)
                     } else {
                    make.right.equalTo(userImage.snp.left).offset(-10)
                    make.left.equalTo(self.snp.left).offset(10)
                }
                make.centerY.equalTo(userImage.snp.centerY)
            }
            nameLabel.snp.makeConstraints {
                make in
                make.top.equalTo(view.snp.top)
                make.left.right.equalTo(view)
                make.height.equalTo(30)
            }
            mailLabel.snp.makeConstraints {
                make in
                make.left.right.equalTo(nameLabel)
                make.bottom.equalTo(view.snp.bottom)
                make.height.equalTo(30)
            }
            
        }
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
