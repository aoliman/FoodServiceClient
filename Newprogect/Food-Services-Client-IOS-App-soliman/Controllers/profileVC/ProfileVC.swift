//
//  ProfileVC.swift
//  FoodServiceClient
//
//  Created by Index PC-2 on 3/18/18.
//  Copyright © 2018 Index. All rights reserved.
//

import Foundation
import Localize_Swift
import UIKit
import Material
import MapKit
import SnapKit
import MapKit
import CoreLocation
import GooglePlaces
import GoogleMaps
import Gloss
import CoreLocation
import FontAwesome_swift



class ProfileVC: UIViewController , UIImagePickerControllerDelegate ,UINavigationControllerDelegate ,UIGestureRecognizerDelegate  {
    
    
    func ReloadData() {
        mapView.clear()
        viewDidLoad()
      
     
    }
    
   
    weak var delegate: ReloadSideMenuDelegate?
//image controller
    var controller = UIImagePickerController()
    var tapGestureRecognizer = UITapGestureRecognizer()
    var locationManager = CLLocationManager()
    
    var location:UserLocation?
    var currentCLLocation:CLLocation?
    var placesClient: GMSPlacesClient!
    var zoomLevel: Float = 15.0
    var selectedLat:Float?
    var selectedLong:Float?
    var prfileres = ProfileRespository()
    var nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.appFontRegular(ofSize: 16)
        label.numberOfLines = 0
        label.textAlignment = .center
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor.appColor()
        return label
        
    }()
    
    // receive is direct from
    var recieveLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.appFont(ofSize: 12)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor.appGreenColor()
        return label
        
    }()
    var userImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = imageView.frame.size.width / 2
        
       
        
        return imageView
    }()
    // image action to upload image
    @objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer)
    {
        
//        self.navigationController?.pushViewController(EditProfileVc(), animated: false)
        // present(controller, animated: true, completion: nil)
        
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let selectedimage = info[UIImagePickerControllerOriginalImage] as! UIImage
        userImage.image?=selectedimage.circle
        
       let  uploadimage = UIImageJPEGRepresentation(selectedimage, 0.25)
        print(uploadimage)
        prfileres.UpdateProfileImage(id:(Singeleton.userInfo?.id)! , image:uploadimage! ) { (client) in
            Singeleton.userDefaults.set(client.toJSON(), forKey: defaultsKey.userData.rawValue)
            print(Singeleton.userInfo?.toJSON())
            Singeleton.userDefaults.synchronize()
            self.delegate?.reloadTableView(true)
            
        }
        dismiss(animated: true, completion: nil)
    }
    
    var contactUsButton: UIButton = {
        let button = Button(type: .custom)
        button.layer.cornerRadius = 10
        button.backgroundColor = UIColor.navigationBarColor()
        button.titleLabel?.textColor = .white
        button.titleLabel?.font = UIFont.appFont(ofSize: 12)
        button.setTitle("profileContactUs".localized(), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.pulseColor = .white
        
        return button
    }()
    var EditPrifileBtn: UIButton = {
        let button = Button(type: .custom)
        button.layer.cornerRadius = 6
        button.backgroundColor = UIColor.navigationBarColor()
        button.titleLabel?.textColor = .white
        button.titleLabel?.font = UIFont.appFont(ofSize: 12)
        button.titleLabel?.font=UIFont.fontAwesome(ofSize: 14)
        button.setTitle(String.fontAwesomeIcon(name: .edit), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.pulseColor = .white
        
        return button
    }()
    
    
    var deliveryTypeLabel: UILabel = {
        
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.appFont(ofSize: 12)
        label.numberOfLines = 0
        label.textAlignment = .center
        if #available(iOS 10.0, *) {
            label.adjustsFontForContentSizeCategory = true
        } else {
            // Fallback on earlier versions
        }
        label.text = "Direct delivery selected until you add delivery place from map".localized()
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    var locationTitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.appFont(ofSize: 12)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor.appColor()
        return label
        
    }()
    
    
    var locationLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.appFont(ofSize: 12)
        label.numberOfLines = 0
        label.textAlignment = .center
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor.black
        return label
        
    }()
    var emailLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.appFont(ofSize: 16)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor.black
        return label
        
    }()
    var phoneLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.appFont(ofSize: 12)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor.navigationBarColor()
        return label
        
    }()
    var mapView: GMSMapView = {
        let mapView = GMSMapView()
        
        return mapView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //add controller image delegate and type
        tapGestureRecognizer.delegate=self
        tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        
        userImage.isUserInteractionEnabled = true
        userImage.addGestureRecognizer(tapGestureRecognizer)
         controller.delegate=self
        controller.sourceType = .photoLibrary
        EditPrifileBtn.addTarget(self, action: #selector(EditProfileAction), for: .touchUpInside)
        addSubviews()
        configerMap()
        
        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
        mapView.clear()
        viewDidLoad()
    }
    
    func configerMap() {
        
        placesClient = GMSPlacesClient.shared()
        mapView.delegate = self
        
        
    }
    
    func setMap(For lat:Float ,long:Float , name : String) {
        
        let camera = GMSCameraPosition.camera(withLatitude: CLLocationDegrees(lat), longitude: CLLocationDegrees(long),
                                              zoom: 12)
        //let mapView = GMSMapView.map(withFrame: .zero, camera: camera)
        self.mapView.camera = camera
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: CLLocationDegrees(lat), longitude: CLLocationDegrees(long))
        marker.snippet = name
        marker.icon = GMSMarker.markerImage(with: .navigationBarColor())
        marker.map = self.mapView

        self.mapView.animate(to: camera)
        
        
    }
    @objc func EditProfileAction() {
        let storyboard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let Editprofilecontroller : EditProfile = storyboard.instantiateViewController(withIdentifier: "EditProfile") as! EditProfile
        Editprofilecontroller.delegate = self.delegate!
        self.navigationController?.pushViewController(Editprofilecontroller, animated: false)
        
    }
    
    

}
