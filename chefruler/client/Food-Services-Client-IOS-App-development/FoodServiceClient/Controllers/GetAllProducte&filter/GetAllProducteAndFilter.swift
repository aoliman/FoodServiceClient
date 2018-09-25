//
//  GetAllProducteAndFilter.swift
//  FoodService
//
//  Created by index-ios on 3/17/18.
//  Copyright © 2018 index-ios. All rights reserved.
//

import UIKit
import Localize_Swift

class GetAllProducteAndFilter: UIViewController {
   var AttributeViewClicked=[1,0]
    @IBOutlet weak var leftView: UIView!
    @IBOutlet weak var rightview: UIView!
    @IBOutlet weak var RightviewHight: NSLayoutConstraint!
    @IBOutlet weak var LeftviewHight: NSLayoutConstraint!
    
    @IBOutlet weak var tabStackView: UIStackView!
    @IBOutlet weak var Btnleft: UIButton!
    @IBOutlet weak var Btnright: UIButton!
    var type = 0
    @IBOutlet weak var contentview: UIView!
    var IsPartyCooker=false
    fileprivate var currentViewController: UIViewController?
    var Getallproducterepo = GetallProdacteRepo()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Loader.hideLoader()
        type = UserDefaults.standard.integer(forKey: Type)
       self.navigationController?.navigationBar.tintColor = .white
        let attrs = [
            NSAttributedStringKey.foregroundColor: UIColor.white
        ]
        UINavigationBar.appearance().titleTextAttributes = attrs
       FirestTimeRightClicked()
       LeftClicked()
       Btnright.setTitleColor(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), for: .normal)
         
        
    }
    override func viewWillDisappear(_ animated: Bool) {
        
        
        
        UserDefaults.standard.set( 0 , forKey: Type)
        print("type now ----- \(UserDefaults.standard.integer(forKey: Type))")
    }
    
    override func viewWillAppear(_ animated: Bool) {
       
    }
    
    @IBAction func BtnLeftClicked(_ sender: Any) {
        LeftClicked()
    }
    
    @IBAction func BtnRightClicked(_ sender: Any) {
        RightClicked()
    }
    
    
    //isleftCliecked
    func LeftClicked(){
     
    if(type == 0){
    Btnleft.setTitle("Producte".localize(), for: .normal)
    Btnright.setTitle("Map".localize(), for: .normal)
    }else {
    Btnleft.setTitle("Producte".localize(), for: .normal)
    Btnright.setTitle("Profile".localize(), for: .normal)
    
        }
     AttributeViewClicked[0]=1
     AttributeViewClicked[1]=0
    
    Btnleft.titleLabel?.textColor=#colorLiteral(red: 0, green: 0.7209913731, blue: 0.8212221265, alpha: 1)
     Btnright.setTitleColor(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), for: .normal)
    rightview.backgroundColor=#colorLiteral(red: 0.6626856923, green: 0.6627831459, blue: 0.6626645327, alpha: 1)
    leftView.backgroundColor=#colorLiteral(red: 0.00610976154, green: 0.5290079117, blue: 0.5844504237, alpha: 1)
    RightviewHight.constant=(tabStackView.layer.frame.size.height)*2/100
    LeftviewHight.constant=(tabStackView.layer.frame.size.height)*4/100
        if(type==2){
            setupNavigationBar()
            let Type =  UserDefaults.standard.string(forKey: Profiletype)!
            print("type  \(UserDefaults.standard.string(forKey: Profiletype))")
            switch Type {
            case "party-cookers":
                self.title = "Party Cooker".localize()
                break
            case "home-cookers":
                self.title = "Home Cooker".localize()
                break
            case "food-cars":
                self.title = "Food Car".localize()
                
                break
            case "restaurant-owners":
                self.title = "Resturante".localize()
                break
            default:
                break
                
            }
            
            presentController("PartyCookerProduct")
        }else{
            self.title = "Home".localize()
          presentController("GetAllProducteController")
        }
       

       
    }
   

   //isrightCliecked
    func RightClicked()
    {
        AttributeViewClicked[0]=0
        AttributeViewClicked[1]=1
        
        
        if(type == 0){
            Btnleft.setTitle("Producte".localize(), for: .normal)
            Btnright.setTitle("Map".localize(), for: .normal)
            presentController("MapController")
             self.title = "Home".localize()
        }else {
             self.title = "Profile".localize()
            Btnleft.setTitle("Producte".localize(), for: .normal)
            Btnright.setTitle("Profile".localize(), for: .normal)
            presentController("ProfileHomeCookerMap")
            
        }
        
       Btnright.setTitleColor(#colorLiteral(red: 0.3386343718, green: 0.7418183684, blue: 0.7497805953, alpha: 1), for: .normal)
        Btnleft.titleLabel?.textColor=#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        rightview.backgroundColor=#colorLiteral(red: 0, green: 0.5690457821, blue: 0.5746168494, alpha: 1)
        leftView.backgroundColor=#colorLiteral(red: 0.6626856923, green: 0.6627831459, blue: 0.6626645327, alpha: 1)
        RightviewHight.constant=(tabStackView.layer.frame.size.height)*4/100
        LeftviewHight.constant=(tabStackView.layer.frame.size.height)*2/100
        Btnright.layoutIfNeeded()
        
    }
    func FirestTimeRightClicked(){
        AttributeViewClicked[0]=0
        AttributeViewClicked[1]=1
        
        
        if(type == 0){
            Btnleft.setTitle("Producte".localize(), for: .normal)
            Btnright.setTitle("Map".localize(), for: .normal)
         ///   presentController("MapController")
            self.title = "Home".localize()
        }else {
            self.title = "Profile".localize()
            Btnleft.setTitle("Producte".localize(), for: .normal)
            Btnright.setTitle("Profile".localize(), for: .normal)
          //  presentController("ProfileHomeCookerMap")
            
        }
        
        Btnright.setTitleColor(#colorLiteral(red: 0.3386343718, green: 0.7418183684, blue: 0.7497805953, alpha: 1), for: .normal)
        Btnleft.titleLabel?.textColor=#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        rightview.backgroundColor=#colorLiteral(red: 0, green: 0.5690457821, blue: 0.5746168494, alpha: 1)
        leftView.backgroundColor=#colorLiteral(red: 0.6626856923, green: 0.6627831459, blue: 0.6626645327, alpha: 1)
        RightviewHight.constant=(tabStackView.layer.frame.size.height)*4/100
        LeftviewHight.constant=(tabStackView.layer.frame.size.height)*2/100
        Btnright.layoutIfNeeded()
        
    }
    
    // to present view of controller in my view
    fileprivate func presentController(_ controller: String) {
       removeCurrentViewController()
      let controller = self.storyboard!.instantiateViewController(withIdentifier: controller)
                controller.willMove(toParentViewController: self)
                self.contentview.addSubview(controller.view)
                self.addChildViewController(controller)
                controller.didMove(toParentViewController: self)
        //important to make view take bounds of my view
        controller.view.frame = contentview.bounds
        controller.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
      
    }

    fileprivate func removeCurrentViewController() {
       
        for subview: UIView in contentview.subviews {
            subview.removeFromSuperview()
        }
        
       
    }
   

  

    

}



