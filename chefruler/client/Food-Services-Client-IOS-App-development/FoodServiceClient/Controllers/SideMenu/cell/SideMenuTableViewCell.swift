//
//  SideMenuTableViewCell.swift
//  FoodServiceProvider
//
//  Created by Index on 1/2/18.
//  Copyright © 2018 index-pc. All rights reserved.
//

import UIKit
import Localize_Swift

class SideMenuTableViewCell: UITableViewCell {

    
    var didSetupConstraints = false
    
    var label: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.setAlignment()
        label.sizeToFit()
        label.contentMode = .scaleToFill
        label.font = UIFont.appFontBold(ofSize: 16)

        return label
    }()
    
    var icon: UILabel = {
        let label = UILabel()
        label.font = UIFont.fontAwesome(ofSize: 18)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        label.contentMode = .scaleToFill
        label.textAlignment = .center
        label.sizeToFit()

        return label
    }()
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        addViews()
        setNeedsUpdateConstraints()
        updateViewConstraints()
        
    }
    
    
    func addViews() {
        addSubview(label)
        addSubview(icon)

    }
    
    func updateViewConstraints() {
        if (!didSetupConstraints) {
            if Localize.currentLanguage() == "en" {
                label.snp.makeConstraints {
                    make in
                    make.left.equalTo(icon.snp.right).offset(20)
                    make.right.equalTo(self.snp.right).offset(-20)
                    make.centerY.equalTo(self.snp.centerY)
                    make.height.equalTo(30)
                }
                icon.snp.makeConstraints {
                    make in
                    make.left.equalTo(self.snp.left).offset(20)
                    make.width.equalTo(30)
                    make.centerY.equalTo(self.snp.centerY)
                    make.height.equalTo(30)
                }
            } else {
                label.snp.makeConstraints {
                    make in
                    make.right.equalTo(icon.snp.left).offset(-20)
                    make.left.equalTo(self.snp.left).offset(20)
                    make.centerY.equalTo(self.snp.centerY)
                    make.height.equalTo(30)
                }
                icon.snp.makeConstraints {
                    make in
                    make.right.equalTo(self.snp.right).offset(-20)
                    make.width.equalTo(30)
                    make.centerY.equalTo(self.snp.centerY)
                    make.height.equalTo(30)
                }
                
                
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
