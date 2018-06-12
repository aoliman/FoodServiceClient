//
//  UIViewController.swift
//  FoodServiceProvider
//
//  Created by index-pc on 12/9/17.
//  Copyright © 2017 index-pc. All rights reserved.
//

import UIKit

extension UIViewController {
    
    static var nothingLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .gray
        label.font = UIFont.appFontBold(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.isHidden = true
        return label
    }()
    
    func setupView() {
        view.backgroundColor = .white
    }
    
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    func addNothingAvailableLabel() {
        view.addSubview(UIViewController.nothingLabel)
        UIViewController.nothingLabel.isHidden = false
        UIViewController.nothingLabel.snp.makeConstraints
            {
                make in
                make.width.equalTo(self.view.snp.width)
                make.height.equalTo(60)
                make.center.equalTo(self.view.snp.center)
        }
    }
    
    func removeNothingLabel() {
        UIViewController.nothingLabel.removeFromSuperview()
    }
    
    func setupNavigationBar() {
        //        let backItem = UIBarButtonItem(title: "Back".localized(), style: .plain, target: nil, action: nil)
        //        self.navigationController?.navigationBar.topItem?.backBarButtonItem = backItem
        self.navigationController?.isNavigationBarHidden = false
        self.navigationController?.navigationBar.topItem?.backButton.setTitle("Back".localized(), for: .normal)
        self.navigationController?.navigationBar.backgroundColor =  UIColor.navigationBarColor()
        self.navigationController?.navigationBar.barTintColor = UIColor.navigationBarColor()
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func previousViewController() -> UIViewController? {
        if let stack = self.navigationController?.viewControllers {
            for i in (1..<stack.count).reversed() {
                if(stack[i] == self) {
                    print(stack[i-1])
                    return stack[i-1]
                }
            }
        }
        return nil
    }
    
    func currentViewController() -> UIViewController? {
        if let stack = self.navigationController?.viewControllers {
            for i in (1..<stack.count).reversed() {
                if(stack[i] == self) {
                    print(stack[i])
                    return stack[i]
                }
            }
        }
        return nil
    }
    
    func changeTitleAttribute() {
        self.navigationController?.navigationBar.titleTextAttributes =
            [NSForegroundColorAttributeName: UIColor.black,
             NSFontAttributeName: UIFont.appFont(ofSize: 21)]
        
    }
}

