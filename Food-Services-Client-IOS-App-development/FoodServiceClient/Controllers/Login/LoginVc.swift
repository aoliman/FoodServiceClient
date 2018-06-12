//
//  LoginViewController.swift
//
//  Created by index-pc on 12/7/17.
//  Copyright © 2017 index-pc. All rights reserved.
//

import UIKit
import SnapKit
import Localize_Swift
import Material
import FontAwesome_swift
import RxSwift
import Moya
class LoginVc: UIViewController
{
    
    var didSetupConstraints = false
    
    var Getallproducterepo = GetallProdacteRepo()
    lazy var repo = UserRepository()
    private let disposeBag = DisposeBag()
    
    var isLogged = false
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
    
    //main view
    var logoView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints  = false
        return view
    }()
    let logo: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = #imageLiteral(resourceName: "food_service_logo")
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    //main view
    var mainView: UIView = {
        
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints  = false
        
        return view
    }()
    
    // email text field
    let emailTextField: ErrorTextField = {
        let text = ErrorTextField()
        text.placeholder = "Email".localized()
        text.setAlignment()
        text.validator.build(.notEmpty, .email).show()
        
        text.keyboardType = .emailAddress
        text.textColor = .darkGray
        text.translatesAutoresizingMaskIntoConstraints  = false
        text.changeActiveColorPlaceholder()
        return text
    }()
    
    let passwordTextField: ErrorTextField = {
        let text = ErrorTextField()
        text.validator.build(.notEmpty).show()
        text.placeholder = "Password".localized()
        text.setAlignment()
        text.textColor = .darkGray
        text.isSecureTextEntry = true
        text.translatesAutoresizingMaskIntoConstraints  = false
        text.changeActiveColorPlaceholder()
        return text
    }()
    
    
    
    //showPasswordButton as sub of password text field
    let showPasswordButton:UIButton = {
        let button = Button(type: .custom)
        button.imageView?.contentMode = .scaleAspectFit
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.font = UIFont.fontAwesome(ofSize: 20)
        button.setTitleColor(UIColor(red:0.27, green:0.58, blue:0.65, alpha:0.5), for: .selected)
        button.setTitle( String.fontAwesomeIcon(code: "fa-eye-slash"), for: .normal)
        button.setTitleColor(.lightGray, for: .normal)
        return button
    }()
    
    //5- forget password button
    let forgetPasswordButton: UIButton = {
        let button = Button(type: .custom)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        button.titleLabel?.textAlignment = .center
        button.setTitle("Forget password?".localized(),  for: .normal)
        button.setTitleColor( UIColor.init(hex: "4695a5"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints  = false
        button.setTitleColor(UIColor(red:0.27, green:0.58, blue:0.65, alpha:0.5), for: .selected)
       // 
        return button
    }()
    
    let registerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    let noAccountLabel: UILabel = {
        let label = UILabel()
        label.text = "Have no account!".localized()
        label.setAlignment()
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    var registerButton: UIButton = {
        let button = Button(type: .custom)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        button.setAlignment()
        button.setTitle("Register".localized(),  for: .normal)
        button.setTitleColor(UIColor.init(hex: "4695a5"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints  = false
        button.setTitleColor(UIColor(red:0.27, green:0.58, blue:0.65, alpha:0.5), for: .selected)
       
        return button
    }()
    
    var loginButton: RaisedButton = {
        let button = RaisedButton(title: "Login".localized(), titleColor: .white)
        button.titleLabel?.font = UIFont.appFontRegular(ofSize: 16)
        button.backgroundColor = UIColor.appColor()
        button.titleLabel?.textAlignment = .left
        button.layer.cornerRadius = 10
        button.setTitleColor(.white, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints  = false
        button.pulseColor = .white
        button.setTitle("Login".localized(), for: .normal)
        
        return button
    }()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        self.SetupDelegate()
        
        self.setupNavBar()
        self.setupNavigationBar()
        
        buttonsActions()
        
        addSubviews()
        
        hideKeyboardWhenTappedAround()
        
        view.setNeedsUpdateConstraints()
        self.navigationItem.setHidesBackButton(true, animated:true)
        repo.isValid(observables: self.emailTextField.validator.isValid,
                     self.passwordTextField.validator.isValid
            ).subscribe(onNext: { (boolValue) in
                UiHelpers.setEnabled(button: self.loginButton, isEnabled: boolValue)
            }).disposed(by: self.disposeBag)
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        emailTextField.text = nil
        passwordTextField.text = nil
       
        self.setupView()
        self.navigationController?.isNavigationBarHidden = true
        self.tabBarController?.hidesBottomBarWhenPushed  = true
        self.title = "Login".localized()
        self.setupNavBar()
        
        buttonsActions()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
extension LoginVc :UITextFieldDelegate {

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == emailTextField {
            passwordTextField.becomeFirstResponder()
        }
        
        if textField ==  passwordTextField  {
            self.dismissKeyboard()
            self.login {
                Loader.hideLoader()
             }
        }
        return false
    }
}

//MARK:- this extension for api service
extension LoginVc
{
    // action for keyboard
    public func login(completion: @escaping () -> ()) {
        guard let emailText = self.emailTextField.text else {
            return
        }
        guard let passwordText = self.passwordTextField.text else {
            return
        }
        if DataUtlis.data.isInternetAvailable() {
            Loader.showLoader()
            UIApplication.shared.isNetworkActivityIndicatorVisible = true
            repo.login(email: emailText, password: passwordText)?.subscribe(onNext:  { response in
                if response != nil {
                    Loader.hideLoader()
                    Singeleton.userDefaults.set(response.token, forKey: defaultsKey.token.rawValue)
                    Singeleton.userDefaults.set(true, forKey: defaultsKey.isLogged.rawValue)
                    Singeleton.userDefaults.set(response.user.toJSON(), forKey: defaultsKey.userData.rawValue)
                    Singeleton.userDefaults.synchronize()

                    
                }
            }, onError: { error in
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                
                Loader.hideLoader()
            }).disposed(by: self.disposeBag)
            completion()
        } else {
            
            DataUtlis.data.noInternetDialog()
        }
    }
    
    
    @objc func Login() {
        guard let emailText = self.emailTextField.text else {
            return
        }
        guard let passwordText = self.passwordTextField.text else {
            return
        }
        
     if DataUtlis.data.isInternetAvailable() {
        Loader.showLoader()
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        
        repo.login(email: emailText, password: passwordText)?.subscribe(onNext:  { response in
            if response != nil {
              Loader.hideLoader()
                Singeleton.userDefaults.set(response.token, forKey: defaultsKey.token.rawValue)
                Singeleton.userDefaults.set(true, forKey: defaultsKey.isLogged.rawValue)
                Singeleton.userDefaults.set(response.user.toJSON(), forKey: defaultsKey.userData.rawValue)
                Singeleton.userDefaults.set(response.user.name, forKey: defaultsKey.userName.rawValue)
                Singeleton.userDefaults.set(response.user.phone, forKey: defaultsKey.userPhone.rawValue)
                Singeleton.userDefaults.set(response.user.email, forKey: defaultsKey.userEmail.rawValue)
                Singeleton.userDefaults.set(passwordText, forKey: defaultsKey.userPassword.rawValue)

                Singeleton.userDefaults.synchronize()
                saveUserId(Userid:(Singeleton.userInfo?.id)!)
                saveUserAuthKey(Userauthkey:Singeleton.token)
                let storyboard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                let homeController : GetAllProducteAndFilter = storyboard.instantiateViewController(withIdentifier: "GetAllProducteAndFilter") as! GetAllProducteAndFilter
                let sideMenuViewController = SideMenuViewController()
                let appToolbarController = AppToolbarController(rootViewController: homeController)
                appToolbarController.mytitle="Home".localize()
                if Localize.currentLanguage() == "en"
                {
                    self.Getallproducterepo.SendLanguage(Language: "en", completionSuccess: { (resulte) in
                        
                    })
                    
                    let viewController = AppNavigationDrawerController(rootViewController: appToolbarController, leftViewController: sideMenuViewController)
                    viewController.isHiddenStatusBarEnabled = false
                    self.navigationController?.pushViewController(viewController, animated: true)
                   
                }
                else
                {
                    self.Getallproducterepo.SendLanguage(Language: "ar", completionSuccess: { (resulte) in
                        
                    })
                    let viewController = AppNavigationDrawerController(rootViewController: appToolbarController, rightViewController: sideMenuViewController)
                    viewController.isHiddenStatusBarEnabled = false
                    self.navigationController?.pushViewController(viewController, animated: true)

                }

                

            }
            }, onError: { error in
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                Loader.hideLoader()
                let moyaError  = error as? MoyaError
                let response: Response? = moyaError?.response
                let statusCode: Int? = response?.statusCode
                
                switch statusCode! {
                  case 401:
                    DataUtlis.data.ErrorDialog(Title: "Error".localized(), Body:"Invalid mail or password".localized() )

                  case 404:
                    DataUtlis.data.ErrorDialog(Title: "Error".localized(), Body:"Invalid mail or password".localized() )

                  case 500:
                    DataUtlis.data.ErrorDialog(Title: "Error".localized(), Body:"ServrError".localized() )
                default:
                    print("done")
                }
                
            }).disposed(by: self.disposeBag)
        
        } else {
           DataUtlis.data.noInternetDialog()
        }
    }
    
}

