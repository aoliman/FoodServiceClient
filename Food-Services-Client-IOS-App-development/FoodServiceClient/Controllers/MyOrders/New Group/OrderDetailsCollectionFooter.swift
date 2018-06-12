//
//  OrderDetailsCollectionFooter.swift
//  FoodServiceProvider
//
//  Created by Index on 2/6/18.
//  Copyright © 2018 index-pc. All rights reserved.
//

import UIKit

class OrderDetailsCollectionFooter: UICollectionReusableView
{
    var didSetupConstraints = false

    let lineView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.appColor()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(frame: CGRect)
    {
        super.init(frame: frame)
        self.backgroundColor = UIColor.navigationBarColor().withAlphaComponent(0.1)
        addSubview(lineView)
    }
    
    override func prepareForReuse() {

    }
    
    required init(coder aDecoder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews()
    {
        if(!didSetupConstraints)
        {
            lineView.snp.makeConstraints
            {
                make in
                make.centerY.equalTo(self.snp.centerY)
                make.height.equalTo(1)
                make.left.equalTo(self.snp.left)
                make.right.equalTo(self.snp.right)
            }
            
        }
        
    }
}
