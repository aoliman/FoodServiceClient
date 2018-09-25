//
//  ExtensionContactUsTabs.swift
//  FoodServiceProvider
//
//  Created by Index on 2/24/18.
//  Copyright © 2018 index-pc. All rights reserved.
//
import UIKit
extension ContactUsNavigationTabs {
    
    override func updateViewConstraints() {
        
        if(!didSetupConstraints) {
            
            segmentioView.snp.makeConstraints {
                (make) -> Void in
                make.width.equalTo(self.view.snp.width)
                make.centerX.equalTo(self.view)
                if UIDevice.current.model == "iPad" {
                    make.height.equalTo(80)
                } else {
                    
                    make.height.equalTo(50)
                }
                if #available(iOS 11.0, *) {
                    make.top.equalTo(additionalSafeAreaInsets.top)
                } else {
                    make.top.equalTo(self.view.snp.top).offset(70)
                    // Fallback on earlier versions
                }
            }
            mainView.snp.makeConstraints {
                (make) -> Void in
                make.top.equalTo(segmentioView.snp.bottom)
                make.left.equalTo(self.view.snp.left)
                make.right.equalTo(self.view.snp.right)
                make.bottom.equalTo(self.view.snp.bottom)
            }
            didSetupConstraints = true
        }
        super.updateViewConstraints()
        
    }
    
    func updateView() {
        let index = segmentioView.selectedSegmentioIndex
        if segmentioView.segmentioItems[index].title == "CallUs".localized() {
            self.add(asChildViewController: self.callUsVC)
            self.remove(asChildViewController: self.contactUsVC)
        } else if segmentioView.segmentioItems[index].title == "Contact Us".localized() {
            self.add(asChildViewController: self.contactUsVC)
            self.remove(asChildViewController: self.callUsVC)
        }
    }
    
//     func add(asChildViewController viewController: UIViewController) {
//        // Add Child View Controller
//        addChildViewController(viewController)
//
//        // Add Child View as Subview
//        mainView.addSubview(viewController.view)
//        //
//        //        // Configure Child View
//        viewController.view.frame = mainView.bounds
//        viewController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
//
//        // Notify Child View Controller
//        viewController.didMove(toParentViewController: self)
//    }
    
    private func remove(asChildViewController viewController: UIViewController) {
        // Notify Child View Controller
        viewController.willMove(toParentViewController: nil)
        
        // Remove Child View From Superview
        viewController.view.removeFromSuperview()
        
        // Notify Child View Controller
        viewController.removeFromParentViewController()
    }
}

