//
//  CollectionViewCell.swift
//  FoodServiceProvider
//
//  Created by Index on 1/11/18.
//  Copyright © 2018 index-pc. All rights reserved.
//

import UIKit
import JSQMessagesViewController
import Localize_Swift

class ChatMessageCollectionViewCell: JSQMessagesCollectionViewCell
{
    var checkSend: UILabel = {
        let label = UILabel()
        label.isHidden = true
        label.textColor = .darkGray
        label.font = UIFont.fontAwesome(ofSize: 20)
        label.text = String.fontAwesomeIcon(code: "fa-clock-o")
        label.textAlignment = .center
//        label.isHidden = true
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    override init(frame: CGRect)
    {
        super.init(frame: frame)
        
        checkSend.snp.makeConstraints
        {
            make in
            make.height.equalTo(self.textView.snp.height)
            make.width.equalTo(30)
            make.centerY.equalTo(self.textView.snp.centerY)
            if Localize.currentLanguage() == "ar"
            {
                make.right.equalTo(self.textView.snp.left)
            }
            else
            {
                make.left.equalTo(self.textView.snp.right)
            }
            
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
