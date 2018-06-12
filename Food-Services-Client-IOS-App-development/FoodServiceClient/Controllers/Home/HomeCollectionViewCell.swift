//
//  HomeCollectionViewCell.swift
//  FoodServiceClient
//
//  Created by Index on 5/21/18.
//  Copyright © 2018 Index. All rights reserved.
//

import UIKit
import Cosmos
import Alamofire
class HomeCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var Eateimage: UIImageView!
    @IBOutlet weak var NameOrderTxt: UILabel!
    @IBOutlet weak var RateView: CosmosView!
    
    @IBOutlet weak var ShadowView: UIView!
    
 
    
    class var ReuseIdentifier: String { return "org.alamofire.identifier.\(type(of: self))" }
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
//        Eateimage.layer.cornerRadius=10
//        self.layer.cornerRadius = 10
      
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        Eateimage.af_cancelImageRequest()
        Eateimage.layer.removeAllAnimations()
        Eateimage.image = nil
        NameOrderTxt.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
//        Eateimage.layer.cornerRadius=10
//        self.layer.cornerRadius = 10
        
    }
    
    
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layoutIfNeeded()
//        self.layer.cornerRadius = 10
//        self.clipsToBounds = true
//        self.layer.masksToBounds = true
//         Eateimage.layer.cornerRadius=10
        
        
        self.layer.cornerRadius = 8
        self.Eateimage.layer.cornerRadius = 8
        self.clipsToBounds=true
        
        //RateView.layer.cornerRadius = 10
        //ShadowView.layer.cornerRadius = 10
    }
    
   
    
    
}
