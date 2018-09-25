//
//  ProducteCell.swift
//  FoodService
//
//  Created by index-ios on 3/18/18.
//  Copyright © 2018 index-ios. All rights reserved.
//

import UIKit

class ProducteCell: UICollectionViewCell {
    @IBOutlet weak var Eateimage: UIImageView!
    @IBOutlet weak var NameOrderTxt: UILabel!
    
    @IBOutlet weak var Price: UILabel!
    
    @IBOutlet weak var IconRate: UIImageView!
    
    @IBOutlet weak var Iconratewidthconstrain: NSLayoutConstraint!
    
    @IBOutlet weak var graidaneview: UIView!
  var  gradine :CAGradientLayer!
    
    
    class var ReuseIdentifier: String { return "org.alamofire.identifier.\(type(of: self))" }
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
      
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        Eateimage.af_cancelImageRequest()
        Eateimage.layer.removeAllAnimations()
        Eateimage.image = nil
        
    }
    
    
    
    
    override func layoutSubviews() {
        super.layoutSubviews()

    }

}
