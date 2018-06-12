//
//  Addtocardcell.swift
//  FoodService
//
//  Created by index-ios on 3/20/18.
//  Copyright © 2018 index-ios. All rights reserved.
//

import UIKit
import Material
class Addtocardcell: UITableViewCell {

 
    
    @IBOutlet weak var errottext: UILabel!
    @IBOutlet weak var Btnaddcard: RaisedButton!
    @IBOutlet weak var textproducte: ErrorTextField!
    var max : Int = 0
    var min : Int = 0
    var cansend:Bool = false
    var orderdata : getproductdata!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
       
       Btnaddcard.setTitle("Add to Card".localized(), for: .normal)
        
       
        textproducte.placeholderLabel.text = "Product quantity".localize()
        textproducte.placeholderActiveColor=#colorLiteral(red: 0, green: 0.5928431153, blue: 0.6563891768, alpha: 0.8477172852)
        textproducte.placeholderNormalColor=#colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        textproducte.dividerColor=#colorLiteral(red: 0, green: 0.5690457821, blue: 0.5746168494, alpha: 0.5591430664)
        textproducte.dividerActiveColor=#colorLiteral(red: 0.3386343718, green: 0.7418183684, blue: 0.7497805953, alpha: 1)
        textproducte.dividerNormalColor=#colorLiteral(red: 0.3386343718, green: 0.7418183684, blue: 0.7497805953, alpha: 1)
        textproducte.placeholderLabel.textAlignment = .center
        textproducte.dividerNormalHeight=2
        textproducte.dividerActiveHeight=3
        textproducte.textAlignment = .center
        Btnaddcard.layer.cornerRadius=10
        
        
        
//
//    textproducte.placeholderVerticalOffset=CGFloat.init(GetHight(percentage: 0.5, view: textproducte))
   
        textproducte.placeholderActiveColor=#colorLiteral(red: 0, green: 0.5928431153, blue: 0.6563891768, alpha: 0.8477172852)
        textproducte.placeholderNormalColor=#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        textproducte.dividerColor=#colorLiteral(red: 0, green: 0.5690457821, blue: 0.5746168494, alpha: 1)
        textproducte.dividerActiveColor=#colorLiteral(red: 0, green: 0.5690457821, blue: 0.5746168494, alpha: 1)
        textproducte.dividerColor=#colorLiteral(red: 0, green: 0.5928431153, blue: 0.6563891768, alpha: 0.8477172852)
        textproducte.dividerNormalHeight=2
        textproducte.dividerActiveHeight=3
       
//        textproducte.placeholderActiveScale=1
//        textproducte.detailVerticalOffset = -3
        if #available(iOS 10.0, *) {
            textproducte.keyboardType = .asciiCapableNumberPad
        } else {
            // Fallback on earlier versions
        }

        
        
        
    }
    func senddata( orderdata : getproductdata){
        self.orderdata=orderdata
    }
    
    
    
    
    
    
    

    @IBAction func AddtocardAction(_ sender: Any) {
        if(textproducte.text == ""){
            errottext.text="Enter Number Between \(max) And \(min)"

            
        }
        if (cansend == true){



        }
        
    }
  
    
    
    @IBAction func TxtProducteDataChange(_ sender: ErrorTextField) {
        sender.placeholder=""
        if let text = textproducte.text {
            
            if ( max != nil && min != nil  && text != "") {
                if( Int(text)! <= min   ) {
                if( Int(text)! >= max){
                      errottext.text=""
                        cansend=true
                    }else {
                        errottext.text="Enter Number Between \(max) And \(min)"
                        cansend=false }}
                else { errottext.text="Enter Number Between \(max) And \(min)"
                     cansend=false}}
          }
         }
    
    
    
}
