//
//  LockViewController.swift
//  FoodServiceProvider
//
//  Created by Index on 5/16/18.
//  Copyright © 2018 index-pc. All rights reserved.
//

import UIKit
import Localize_Swift

class LockViewController: UIViewController {

    var lockLabel: UILabel = {
        let label = UILabel()
        label.text = "Your account has been banned".localized()
        label.textAlignment = .center
        label.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        label.font = UIFont.appFontRegular(ofSize: 18)
        label.backgroundColor = #colorLiteral(red: 0.7607843137, green: 0.3294117647, blue: 0.2117647059, alpha: 1)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(lockLabel)

        setupView()
        
        lockLabel.snp.makeConstraints() {
            make in
            make.centerX.equalTo(self.view.snp.centerX)
            make.width.equalTo(self.view.snp.width)
            if UIDevice.current.model == "iPad" {
                make.height.equalTo(70)
            } else {
                make.height.equalTo(50)
            }
            make.bottom.equalTo(self.view.snp.bottom)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}
