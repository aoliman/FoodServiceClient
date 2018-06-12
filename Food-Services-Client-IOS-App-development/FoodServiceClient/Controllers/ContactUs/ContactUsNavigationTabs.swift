//
//  ContactUsNavigationTabs.swift
//  FoodServiceProvider
//
//  Created by Index on 2/24/18.
//  Copyright © 2018 index-pc. All rights reserved.
//

import UIKit
import Segmentio

class ContactUsNavigationTabs: UIViewController
{
    let callUsVC = CallUsVC()
    let contactUsVC = ContactUsVC()
    
    var didSetupConstraints = false
    
    fileprivate var segmentioStyle = SegmentioStyle.onlyLabel
    
    let segmentioView: Segmentio = {
        let segmentio = Segmentio()
        var content = [SegmentioItem]()
        segmentio.translatesAutoresizingMaskIntoConstraints = false
        
        
        return segmentio
    }()
    
    var mainView: UIScrollView = {
        let view = UIScrollView()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupView()
        self.setupNavigationBar()
        self.view.addSubview(segmentioView)
        self.view.addSubview(mainView)
        self.segmentioView.selectedSegmentioIndex  = 0
        
        SegmentioBuilder.buildSegmentioView(segmentioView: segmentioView, segmentioStyle: .onlyLabel, titles: ["CallUs", "Contact Us"])

        updateViewConstraints()
        self.setupView()
        
        updateView()
        
        segmentioView.valueDidChange = { [weak self] _, segmentIndex in
            self?.updateView()
            print("selected index in segmentio is \(segmentIndex)")
            
        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

