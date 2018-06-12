//
//  orderInfoAndFilterCell.swift
//  FoodServiceClient
//
//  Created by Index on 5/31/18.
//  Copyright © 2018 Index. All rights reserved.


import UIKit

class orderInfoAndFilterCell: UITableViewCell {
    
    
   
    @IBOutlet weak var orderImage: UIImageView!
    @IBOutlet weak var OrderTypeImage: UIImageView!
    @IBOutlet weak var OrderName: UILabel!
    @IBOutlet weak var OrderNumber: UILabel!
    @IBOutlet weak var orderdate: UILabel!
    @IBOutlet weak var Orderprice: UILabel!
    @IBOutlet weak var OrderStatus: UILabel!
    @IBOutlet weak var OrderNumberlabel: UILabel!
    var State:String=""
    
    
     class var ReuseIdentifier: String { return "org.alamofire.identifier.\(type(of: self))" }
    
    override func awakeFromNib() {
        super.awakeFromNib()
       Setup()
       
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        Setup()
    }
    
    
    
    override func prepareForReuse() {
        super.prepareForReuse()
        orderImage.af_cancelImageRequest()
        orderImage.layer.removeAllAnimations()
        orderImage.image = nil
        OrderTypeImage.af_cancelImageRequest()
        OrderTypeImage.layer.removeAllAnimations()
        OrderTypeImage.image = nil
        Orderprice.text = "No Value".localize()
       
        
    }
    
    func Setup(){
        
        
        orderImage.layer.cornerRadius =  orderImage.layer.frame.width/2
//        OrderTypeImage.layer.cornerRadius =  orderImage.layer.frame.width/2
        OrderNumberlabel.text = "order num ".localize()
        
        
        
        
        
    }
  

}
