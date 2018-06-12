//
//  Profile.swift
//  FoodService
//
//  Created by index-ios on 3/29/18.
//  Copyright © 2018 index-ios. All rights reserved.
//

import UIKit
import Material
import  AlamofireImage
import Alamofire
class Profile: UIViewController {
var Getallproducterepo = GetallProdacteRepo()
    @IBOutlet weak var Tableviewprofile: UITableView!
    var profiletid:Int!
    var profiletype:String!
    var ProfileInfomation:Owner!
    var Haveplivery = false
    var members : [Int] = [Singeleton.userInfo!.id!]
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        CancelAllrequsst()
      myLoader.hideCustomLoader()
   profiletid = UserDefaults.standard.integer(forKey: Profileid)
   profiletype = UserDefaults.standard.string(forKey: Profiletype)
        print(profiletype)
       LoadOwnerProfileInfo(id: profiletid, type: UserDefaults.standard.string(forKey: Profiletype)!)
       havedeliveryplace()
      Tableviewprofile.delegate=self
        Tableviewprofile.dataSource=self
        if(UserDefaults.standard.string(forKey: Profiletype) == "food-cars"){
            UserDefaults.standard.set(1, forKey: Type )
        }
    }

}


extension Profile : UITableViewDelegate , UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if (indexPath.row == 0 ) {
            let cell : profileCellInfo = Tableviewprofile.dequeueReusableCell(withIdentifier: "profileCellInfo", for: indexPath) as! profileCellInfo
            if (ProfileInfomation != nil ){
                cell.name.text=ProfileInfomation.name
               // cell.email.text=ProfileInfomation.email
                //cell.phonenumber.text=ProfileInfomation.phone
                cell.countary.text=ProfileInfomation.address
                cell.Btnconnect.addTarget(self, action: #selector(MakeCall), for: .touchUpInside)
                if(ProfileInfomation.profileImg != nil){
                    cell.imagrprofile.af_setImage(withURL: URL(string: ProfileInfomation.profileImg)!)
                    }
                // Use if you need just to show the stars without getting user's input
                 cell.RateView.settings.updateOnTouch = false
                
                // Show only fully filled stars
                 cell.RateView.settings.fillMode = .precise
                cell.RateView.rating=ProfileInfomation.rating
                cell.RateView.text=String(ProfileInfomation.rating)
                if(Haveplivery){
                    cell.Typedelivery.text="Direct delivery from the workplace".localized()
                    
                }
            }
            return cell
        }
        if (indexPath.row == 1 ) {
            let cell : ProfileMap = Tableviewprofile.dequeueReusableCell(withIdentifier: "ProfileMap", for: indexPath) as! ProfileMap
            if (ProfileInfomation != nil ){
                cell.SetLoactionofowner(lat:Double(ProfileInfomation.location.lat) , long: Double(ProfileInfomation.location.lng), type: "party-cookers")
                
                
               
            }
            return cell
        }
        else {
          return TableViewCell()
        }
    }
    
   
   
    

    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if(indexPath.row == 0){
            return UIScreen.main.bounds.height*50/100
        }
        else if(indexPath.row == 1){
            return (UIScreen.main.bounds.height*45/100)
        }
       
            
            
            
            
        else {
            return UIScreen.main.bounds.height*35/100
        }
    }
    
    
    //load OwnerProfile
    func LoadOwnerProfileInfo(id :Int ,type :String )  {
        Getallproducterepo.GetProfileInfo(id: id, type: type) { (SuccessResponse) in
            if(SuccessResponse != nil){
                //Success Get ownerInfo
                let data=SuccessResponse as! Owner
                print(data)
                if data != nil {
                    self.members.append(data.id!)
                    self.ProfileInfomation=data
                    self.havedeliveryplace()
                    self.Tableviewprofile.reloadData()
                    myLoader.hideCustomLoader()
                }
               
            }
        }
        
    }
    
    
    @objc func MakeCall(){
        let chatViewContoller = ChatViewController()
        print(self.ProfileInfomation)
        
        var reciver = User(json: ProfileInfomation.toJSON()!)
        print(reciver)
        chatViewContoller.receiver =  reciver
        chatViewContoller.conversationId = setConverstionFireBaseId()
       // self.navigationController?.navigationBar.topItem?.backButton.setTitle("".localized(), for: .normal)
        
        self.navigationController?.pushViewController(chatViewContoller, animated: true)
    }
    
    func setConverstionFireBaseId() -> String {
       return members[0] < members[1] ? "\(members[0]) \(members[1])" : "\(members[1]) \(members[0])"
        
    }
    
    
    func havedeliveryplace(){
        myLoader.showCustomLoaderview(uiview:self.view )
    Getallproducterepo.GetHomeCookerPlace(ownedid: profiletid  ,type: profiletype) { (SuccessResponse) in
   
    if(SuccessResponse != nil ){
   
        self.Haveplivery=true
        self.Tableviewprofile.reloadData()
        
      }
        myLoader.hideCustomLoader()
    }
        
        
        
        
   
   
  
    
}

}
