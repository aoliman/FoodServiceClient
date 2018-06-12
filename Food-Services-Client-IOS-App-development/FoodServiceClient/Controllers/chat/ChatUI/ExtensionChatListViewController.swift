//
//  Extension.swift
//  FoodServiceProvider
//
//  Created by Index on 1/7/18.
//  Copyright © 2018 index-pc. All rights reserved.
//

import Foundation
import Localize_Swift

extension ChatListViewController {
    
    override func updateViewConstraints() {
        
        if !didSetupConstraints {
            setOnlineSwitch.snp.makeConstraints {
                make in
                make.width.equalTo(50)
                make.height.equalTo(30)
                make.top.equalTo(titleLabel.snp.top)
                if Localize.currentLanguage() == "ar" {
                    make.left.equalTo(titleLabel.snp.left)
                } else {
                    make.right.equalTo(titleLabel.snp.right)
                }
            }
            titleLabel.snp.makeConstraints {
                make in
                make.top.equalTo(self.view.snp.top).offset(20)
                make.left.equalTo(self.view.snp.left).offset(20)
                make.right.equalTo(self.view.snp.right).offset(-20)
                make.height.equalTo(30)
            }
            tableView.snp.makeConstraints() {
                make in
                make.top.equalTo(titleLabel.snp.bottom).offset(20)
                make.left.equalTo(self.view.snp.left)
                make.right.equalTo(self.view.snp.right)
                make.bottom.equalTo(self.view.snp.bottom)
            }
            didSetupConstraints = true
        }
        super.updateViewConstraints()
    }
    
    func addSubViews() {
        self.view.addSubview(setOnlineSwitch)
        self.view.addSubview(titleLabel)
        self.view.addSubview(tableView)
    }
}
