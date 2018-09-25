//
//  ProductCollectionCell.swift
//  FoodService
//
//  Created by index-ios on 4/9/18.
//  Copyright © 2018 index-ios. All rights reserved.
//
protocol Checkitem {
    func CheckitemId(id :Int)
}


import UIKit
import BEMCheckBox
class ProductCollectionCell: UICollectionViewCell , BEMCheckBoxDelegate {
    @IBOutlet weak var Eateimage: UIImageView!
    @IBOutlet weak var NameOrderTxt: UILabel!
  
    @IBOutlet weak var RateImage: UIImageView!
    
     var delegate: Checkitem?
    @IBOutlet weak var Price: UILabel!
    
    @IBOutlet weak var checkbox: BEMCheckBox!
   
    @IBOutlet weak var graidaneview: UIView!
    var  gradine :CAGradientLayer!
    
    
    class var ReuseIdentifier: String { return "org.alamofire.identifier.\(type(of: self))" }
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        Eateimage.layer.cornerRadius=6
       
        checkbox.on=false
        checkbox.offFillColor=#colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.7496744792)
        checkbox.onFillColor=#colorLiteral(red: 0.1518855989, green: 0.878056109, blue: 0.28721717, alpha: 1)
        checkbox.onCheckColor=#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        checkbox.onTintColor=#colorLiteral(red: 0.1518855989, green: 0.878056109, blue: 0.28721717, alpha: 1)
        checkbox.lineWidth=1
        checkbox.onAnimationType = .fill
        checkbox.boxType = .square
        checkbox.delegate=self
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
    func didTap(_ checkBox: BEMCheckBox) {
        
        delegate?.CheckitemId(id: checkbox.tag)
    }
   
   
    
}
