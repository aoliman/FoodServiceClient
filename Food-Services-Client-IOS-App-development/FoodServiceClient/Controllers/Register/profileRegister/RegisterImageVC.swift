//
//  RegisterImageVC.swift
//  FoodServiceClient
//
//  Created by Ramy Nasser Code95 on 3/9/18.
//  Copyright © 2018 Index. All rights reserved.
//

import UIKit
import SnapKit
import PopupDialog
import Localize_Swift
import Material
import RxSwift
private let reuseIdentifier = "Cell"
private let imageCellIdentifier = "imageCellIdentifier"


class RegisterImageVC:UIViewController {
    var didSetupConstraints = false
    
    //var delegate: ContinueRegiserDelegate?
    var prfileres = ProfileRespository()
    var photosArray = [Data]()
    lazy var userRepository = UserRepository()
    private let disposeBag = DisposeBag()

    var  registerView:UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    let logo: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = #imageLiteral(resourceName: "food_service_logo")
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    var titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = UIColor.appColor()
        label.font = UIFont.appFontBold(ofSize: 14)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "upload profile photos".localize()
        return label
    }()
    
    var openCameraButton: UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "camera"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.imageView?.contentMode = .scaleAspectFit
        
        return button
    }()
    
    var collectionView:UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: CGRect(),collectionViewLayout:layout)
        collectionView.layer.cornerRadius = 10
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        return collectionView
    }()
    
    var photosView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
 lazy var continueRegisterButton: RaisedButton = {
        let button = RaisedButton(title: "Continue register".localized(), titleColor: .white)
        button.titleLabel?.font = UIFont.appFontRegular(ofSize: 16)
        button.backgroundColor = UIColor.appColor()
        button.titleLabel?.textAlignment = .left
        button.layer.cornerRadius = 4
        button.setTitleColor(.white, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints  = false
        button.pulseColor = .white
        button.setTitle("Continue register".localized(), for: .normal)

        button.rx.tap.asDriver().drive(onNext: {
            self.uploadProfileImage()
        }).disposed(by: self.disposeBag)
        
        return button
    }()
    
    static var popup: PopupDialog?
    
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        setupView()
        setupNavigationBar()
        addSubviews()
        updateViewConstraints()
        UiHelpers.setEnabled(button: self.continueRegisterButton, isEnabled: false)

        //collection view
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        collectionView.register(ImageCollectionViewCell.self, forCellWithReuseIdentifier: imageCellIdentifier)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .white
        
        openCameraButton.addTarget(self, action: #selector(popupPhotoCamera), for: .touchUpInside)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavigationBar()
        self.navigationController?.navigationBar.tintColor = .white
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        continueRegisterButton.sizeToFit()
        continueRegisterButton.contentEdgeInsets = UIEdgeInsets(top: 10, left: 20, bottom: 10, right: 20)
        
    }
    
    
    
}
extension RegisterImageVC: UICollectionViewDataSource, UICollectionViewDelegate
{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        
        let itemsCount = photosArray.count
        
        return itemsCount > 0 ? itemsCount : 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
           let cell = collectionView.dequeueReusableCell(withReuseIdentifier: imageCellIdentifier, for: indexPath)
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath)
    {
        guard let cell = cell as? ImageCollectionViewCell else {return}
        if photosArray.count > 0
        {
            let decodedimage = UIImage(data: photosArray[indexPath.row])
            cell.imageView.image = decodedimage
            cell.closeButton.isHidden = false
            cell.closeButton.tag = indexPath.row
            
            cell.tag = indexPath.row
            if cell.delegate == nil {
                cell.delegate = self
            }
        }
    }
    
}
extension RegisterImageVC : UICollectionViewDelegateFlowLayout
{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat
        
    {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets
    {
        return UIEdgeInsetsMake(0, 10, 0, 10)
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat
    {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        var width  : Double
        
        width  = Double(UIScreen.main.bounds.width)
        
        return CGSize(width: width * 0.5 - 15, height: Double(photosView.frame.height) )
    }
    
}

extension RegisterImageVC: RemoveImageDelegate
{
    func removeImage(cell: ImageCollectionViewCell)
    {
        let index = cell.tag
        photosArray.remove(at: index)
        collectionView.reloadData()
    }
}
extension RegisterImageVC {
    
    func uploadProfileImage() {
        if DataUtlis.data.isInternetAvailable() {
            Loader.showLoader()
            UIApplication.shared.isNetworkActivityIndicatorVisible = true

        if photosArray.count > 0 {
            let  uploadimage = photosArray[0]
            prfileres.UpdateProfileImage(id:(Singeleton.userInfo?.id)! , image:uploadimage ) { (client) in
                
                print(client)
                let vc = DetermineLocationVc ()
                self.present(vc, animated: true, completion: nil)
                //self.navigationController?.pushViewController(vc, animated: true)
                Loader.hideLoader()
            }
            
//            userRepository.uploadProfileImage(id: Singeleton.userId!, images: photosArray, onSuccess: { (response, statusCode) in
//
//                Loader.hideLoader()
//                UIApplication.shared.isNetworkActivityIndicatorVisible = false
//                Singeleton.userDefaults.set(response?.token, forKey: defaultsKey.token.rawValue)
//                Singeleton.userDefaults.set(response?.user.id, forKey: defaultsKey.userId.rawValue)
//
//                let vc = DetermineLocationVc ()
//                self.navigationController?.pushViewController(vc, animated: true)
//
//            }, onFailure: { (errorResponse, statusCode) in
//
//                Loader.hideLoader()
//                UIApplication.shared.isNetworkActivityIndicatorVisible = false
//                if let errorMessage = errorResponse?.error[0].msg{
//                    DataUtlis.data.WarningDialog(Title: "Error".localized(), Body: errorMessage)}
//
//            })
            
        } else {
            
        }
            
    } else {
            DataUtlis.data.noInternetDialog()
    }
}
}
