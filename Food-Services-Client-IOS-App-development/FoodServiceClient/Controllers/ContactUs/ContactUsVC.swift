//
//  ContactUsVC.swift
//  FoodServiceProvider
//
//  Created by Index on 2/24/18.
//  Copyright © 2018 index-pc. All rights reserved.
//

import UIKit
import Material

class ContactUsVC: UIViewController {
    
    let label: UILabel = {
        let label = UILabel()
        label.font = UIFont.appFontRegular(ofSize: 16)
        label.numberOfLines = 0
        label.textColor = .darkGray
        label.textAlignment = .center
        label.text = "Do you have any question, note or a complaint? Our team is ready to help as soon as possible".localized()
        label.lineBreakMode = .byWordWrapping
        label.adjustsFontSizeToFitWidth = true
        label.translatesAutoresizingMaskIntoConstraints = false

        return label
        
    }()
    
    let emailTextField: UITextField = {
        let text = TextField()
        text.placeholder = "Email".localized()
        text.setAlignment()
        text.keyboardType = .emailAddress
        text.textColor = .darkGray
        text.font = UIFont.appFont(ofSize: 16)
        text.translatesAutoresizingMaskIntoConstraints  = false
        text.changeActiveColorPlaceholder()
        return text
    }()
    
    let nameTextField: UITextField = {
        let text = TextField()
        text.changeActiveColorPlaceholder()
        text.placeholder = "Name".localized()
        text.setAlignment()
        text.translatesAutoresizingMaskIntoConstraints  = false
        text.font = UIFont.appFont(ofSize: 16)

        return text
    }()
    
    let messageTextField: UITextField = {
        let text = TextField()
        text.placeholder = "Message".localized()
        text.setAlignment()
        text.textColor = .darkGray
        text.isSecureTextEntry = true
        text.translatesAutoresizingMaskIntoConstraints  = false
        text.changeActiveColorPlaceholder()
        text.font = UIFont.appFont(ofSize: 16)

        return text
    }()
    
    var sendButton: UIButton = {
        let button = UIButton.appButton()
        button.setTitle("Send".localized(), for: .normal)
        button.backgroundColor = UIColor.navigationBarColor()
        //button.cornerRadius = 3
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        addSubView()
        setupView()
        setupNavigationBar()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
