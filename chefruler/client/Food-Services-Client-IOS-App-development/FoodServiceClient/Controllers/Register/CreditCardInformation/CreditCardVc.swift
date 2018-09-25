//
//  CreditCardInformationViewController.swift
//  FoodServiceProvider
//
//  Created by Index on 12/31/17.
//  Copyright © 2017 index-pc. All rights reserved.
//

import UIKit
import Material
import DropDown
import RxSwift
import RxKeyboard
import Localize_Swift
class CreditCardVc: UIViewController
{
    var didSetupConstraints = false
    var Isedite = false
//    var loginResponse: LoginModel?
 
    // this the specified day for month
    lazy var repo = UserRepository()
    private let disposeBag = DisposeBag()
    var Getallproducterepo = GetallProdacteRepo()
    
    var monthsNumber = [month.January.rawValue ,
                  month.February.rawValue ,
                  month.March.rawValue ,
                  month.April.rawValue ,
                  month.May.rawValue ,
                  month.June.rawValue ,
                  month.July.rawValue ,
                  month.August.rawValue ,
                  month.September.rawValue ,
                  month.October.rawValue ,
                  month.November.rawValue ,
                  month.December.rawValue ,
                  ]
    
    var months:[String] = {
        var array = [String]()
        let formatter = DateFormatter()
        let monthComponents = formatter.monthSymbols
        array.append(contentsOf: monthComponents!)
        return array
        }()

    var years:[String] = {
        var array = [String]()
        
        let currentDate = Date()
        let calendar = Calendar.current
        let currentYear = calendar.component(.year, from: currentDate)
        let years = (currentYear...2100).map { String($0) }
     
        array.append(contentsOf: years)
        
        return array
    }()
    
    var countries:[String] = {
        var array = [String]()
        for countryCode in NSLocale.isoCountryCodes
        {
            let currentLocale : NSLocale = NSLocale.init(localeIdentifier :  NSLocale.current.identifier)
            let countryName : String? = currentLocale.displayName(forKey: NSLocale.Key.countryCode, value: countryCode)
            if countryName != nil
            {
                array.append(countryName!)
            }

        }
        return array
    }()

    
    let logo: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = #imageLiteral(resourceName: "food_service_logo")
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    var scrollView: UIScrollView = {
        let view = UIScrollView()
        
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    
    var label: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = UIColor.init(hex: "4695a5")
        label.text = "CreditCardInformation".localized()
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textAlignment = .center
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()

    let creditCardNumberTextField: ErrorTextField = {
        let text = ErrorTextField()
        text.changeActiveColorPlaceholder()
        text.validator.build(.notEmpty).show()
        text.placeholder = "Credit card number".localized()
        text.setAlignment()
        text.translatesAutoresizingMaskIntoConstraints  = false
        text.keyboardType = .numbersAndPunctuation
        return text
    }()
    
    let passwordTextField: ErrorTextField = {
        let text = ErrorTextField()
        text.changeActiveColorPlaceholder()
        text.validator.build(.notEmpty).show()
        text.placeholder = "Password".localized()
        text.setAlignment()
        text.isSecureTextEntry = true
        text.translatesAutoresizingMaskIntoConstraints  = false
        
        return text
    }()
    
    var validateDateLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = .lightGray
        label.text = "validate date".localized()
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.setAlignment()
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    var mounthTextField: ErrorTextField = {

        let text = ErrorTextField()
        text.changeActiveColorPlaceholder()
        text.validator.build(.notEmpty).show()
        text.setAlignment()
        text.translatesAutoresizingMaskIntoConstraints  = false
        text.addDownArrow()
        text.placeholder = "mounth".localized()
        text.isUserInteractionEnabled = true
        return text

    }()
    
    var yearTextField: ErrorTextField = {
        let text = ErrorTextField()
        text.changeActiveColorPlaceholder()
        text.setAlignment()
        text.validator.build(.notEmpty).show()
        text.translatesAutoresizingMaskIntoConstraints  = false
        text.addDownArrow()
        text.placeholder = "Year".localized()
        text.isUserInteractionEnabled = true
        
        return text
    }()
    
    var monthDropdown: DropDown = {
        let dropDown = DropDown()
        dropDown.translatesAutoresizingMaskIntoConstraints = false
        dropDown.backgroundColor = .white
        dropDown.direction = .bottom
        dropDown.separatorColor = UIColor.gray
        dropDown.selectionBackgroundColor = UIColor.init(red: 241/255, green: 241/255, blue: 244/255, alpha: 1)
        dropDown.textColor = .darkGray
        dropDown.layer.cornerRadius = 5
        
        return dropDown
    }()
    
    var yearDropdown: DropDown = {
        let dropDown = DropDown()
        dropDown.translatesAutoresizingMaskIntoConstraints = false
        dropDown.backgroundColor = .white
        dropDown.direction = .bottom
        dropDown.separatorColor = UIColor.gray
        dropDown.selectionBackgroundColor = UIColor.init(red: 241/255, green: 241/255, blue: 244/255, alpha: 1)
        dropDown.textColor = .darkGray
        dropDown.layer.cornerRadius = 5
        
        return dropDown
    }()
    
    let nameOnCard: ErrorTextField = {
        let text = ErrorTextField()
        text.validator.build(.notEmpty).show()
        text.changeActiveColorPlaceholder()
        text.placeholder = "Name as written on card".localized()
        text.setAlignment()
        text.translatesAutoresizingMaskIntoConstraints  = false
        
        return text
    }()
    
    var countryTextField: ErrorTextField = {
        let text = ErrorTextField()
        text.validator.build(.notEmpty).show()
        text.changeActiveColorPlaceholder()
        text.setAlignment()
        text.translatesAutoresizingMaskIntoConstraints  = false
        text.addDownArrow()
        text.placeholder = "Country".localized()
        text.isUserInteractionEnabled = true
        return text
        
    }()
    
    var countryDropdown: DropDown = {
        let dropDown = DropDown()
        dropDown.translatesAutoresizingMaskIntoConstraints = false
        dropDown.backgroundColor = .white
        dropDown.direction = .bottom
        dropDown.separatorColor = UIColor.gray
        dropDown.selectionBackgroundColor = UIColor.init(red: 241/255, green: 241/255, blue: 244/255, alpha: 1)
        dropDown.textColor = .darkGray
        dropDown.layer.cornerRadius = 5
        
        return dropDown
    }()

    let postalCodeTextField: ErrorTextField = {
        let text = ErrorTextField()
        text.validator.build(.notEmpty).show()
        text.changeActiveColorPlaceholder()
        text.placeholder = "Postal code".localized()
        text.setAlignment()
        text.translatesAutoresizingMaskIntoConstraints  = false
        text.keyboardType = .numbersAndPunctuation
        return text
    }()
    
    lazy var continueRegisterButton: RaisedButton = {
        let button = RaisedButton(title: "Continue register".localized(), titleColor: .white)
        button.titleLabel?.font = UIFont.appFontRegular(ofSize: 16)
        button.backgroundColor = UIColor.appColor()
        button.titleLabel?.textAlignment = .left
        button.layer.cornerRadius = 10
        button.setTitleColor(.white, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints  = false
        button.pulseColor = .white
        button.setTitle("Continue register".localized(), for: .normal)
        button.rx.tap.asDriver().drive(onNext: {
            self.hideKeyboardWhenTappedAround()
            self.addCreditInfo()
        }).disposed(by: self.disposeBag)
        
        
        return button
    }()
    
    var validationErrorLabel: UILabel = {
        let label = UILabel()
        label.isHidden = true
        label.textColor = .red
        label.font = UIFont.fontAwesome(ofSize: 20)
        label.text = String.fontAwesomeIcon(code: "fa-exclamation-circle")
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.scrollView.bounces = false
        self.scrollView.alwaysBounceVertical = false
        scrollView.contentSize = CGSize(width: UIScreen.main.bounds.width, height:681.6)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name:NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name:NSNotification.Name.UIKeyboardWillHide, object: nil)
        self.SetupDelegate()
        self.setupView()
        self.setupNavigationBar()
        
        addSubviews()
        dropDownSetup()
        hideKeyboardWhenTappedAround()
        
        RxKeyboard.instance.visibleHeight.drive(onNext: { (keyboardVisibleHeight) in
            self.scrollView.contentInset.bottom = keyboardVisibleHeight
        }).disposed(by: self.disposeBag)
        
        
        
        
        repo.isValid(observables: self.creditCardNumberTextField.validator.isValid,
                     self.passwordTextField.validator.isValid  ,
                     self.nameOnCard.validator.isValid,
                     self.postalCodeTextField.validator.isValid

            ).subscribe(onNext: { (boolValue) in
                UiHelpers.setEnabled(button: self.continueRegisterButton, isEnabled: boolValue)
                
            }).disposed(by: self.disposeBag)
        if Isedite {
//            Getallproducterepo.GetCreditCardInfo(id: (Singeleton.userInfo?.id)!, completionSuccess: { (creditcard) in
//
//                self.creditCardNumberTextField.text = creditcard.number
//                self.passwordTextField.text = Singeleton.
//                self.monthDropdown.selectRow(creditcard.finishMonth-1)
//                self.mounthTextField.text = self.months[creditcard.finishMonth-1]
//                self.yearDropdown.selectRow(self.years.index(of:String(creditcard.finishYear))!)
//                self.nameOnCard.text = creditcard.nameInCard
//                self.countryTextField.text = creditcard.country
//
//
//            })
            
        }
        
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        continueRegisterButton.sizeToFit()
        continueRegisterButton.contentEdgeInsets = UIEdgeInsets(top: 10, left: 20, bottom: 10, right: 20)
        
    }
    
}


extension CreditCardVc
{
    func addCreditInfo()
    {
        
        guard let creditCardText = self.creditCardNumberTextField.text else {
            return
        }
        guard let passwordText = self.passwordTextField.text else {
            return
        }
        guard let mounthText = self.mounthTextField.text else {
            return
        }
        guard let yearText = self.yearTextField.text else {
            return
        }
        
        guard let nameOnCardText = self.nameOnCard.text else {
            return
        }
        guard let countryText = self.countryTextField.text else {
            return
        }
        guard let postalCodeText = self.nameOnCard.text else {
            return
        }
        if DataUtlis.data.isInternetAvailable() {
            Loader.showLoader()
            UIApplication.shared.isNetworkActivityIndicatorVisible = true
               let selectedMonthIndex = Int(monthDropdown.indexForSelectedRow!)
               let monthNumber = monthsNumber[selectedMonthIndex]
            repo.addCreditCardInfo(id: (Singeleton.userInfo?.id)!, credit_card_number: creditCardText, credit_card_password: passwordText, credit_card_finish_year: Int(yearText)!, credit_card_finish_month: monthNumber, name_in_credit_card: nameOnCardText, country: countryText, postal_code: postalCodeText, onSuccess: { (response, statusCode) in
                
              //////////////////////////
//                saveUserId(Userid:(Singeleton.userInfo?.id)!)
//                saveUserAuthKey(Userauthkey:Singeleton.token)
                let storyboard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                let homeController : GetAllProducteAndFilter = storyboard.instantiateViewController(withIdentifier: "GetAllProducteAndFilter") as! GetAllProducteAndFilter
                let sideMenuViewController = SideMenuViewController()
                let appToolbarController = AppToolbarController(rootViewController: homeController)
                appToolbarController.mytitle="Home".localize()
                if Localize.currentLanguage() == "en"
                {
                    if self.Isedite {
                        self.motionDismissViewController()
                    }else{
                        let viewController = AppNavigationDrawerController(rootViewController: appToolbarController, leftViewController: sideMenuViewController)
                        viewController.isHiddenStatusBarEnabled = false
                        self.navigationController?.pushViewController(viewController, animated: true)
                    }
                    
                    
                }
                else
                {
                    if self.Isedite {
                        self.motionDismissViewController()
                    }else{
                    let viewController = AppNavigationDrawerController(rootViewController: appToolbarController, rightViewController: sideMenuViewController)
                    viewController.isHiddenStatusBarEnabled = false
                    self.navigationController?.pushViewController(viewController, animated: true)
                    }
                }
                
                
            }, onFailure: { (errorResponse, statusCode) in
                Loader.hideLoader()
                UIApplication.shared.isNetworkActivityIndicatorVisible = true

                let errorMessage = errorResponse?.error[0].msg
                DataUtlis.data.WarningDialog(Title: "Error".localized(), Body: errorMessage!)

                
            })

          
         }  else {
             DataUtlis.data.noInternetDialog()
        }
            
            

        
    }
    
}

extension CreditCardVc :UITextFieldDelegate
{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        return textField.resignFirstResponder()
    }
    
    func textFieldDidEndEditing(_ textField: UITextField)
    {
        validationErrorLabel.isHidden = true
    }
}


