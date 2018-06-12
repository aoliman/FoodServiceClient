//
//  InfoHomeCookerCell.swift
//  FoodServiceClient
//
//  Created by Index on 5/27/18.
//  Copyright © 2018 Index. All rights reserved.
//

import UIKit

class InfoHomeCookerCell: UITableViewCell {

    @IBOutlet weak var Namelabel: UILabel!
    @IBOutlet weak var pricelabel: UILabel!
    @IBOutlet weak var QuantityLabel: UILabel!
    
    @IBOutlet weak var CountValue: UITextField!
    
    @IBOutlet weak var NameValue: UILabel!
    @IBOutlet weak var priceValue: UILabel!
    
    @IBOutlet weak var MinuseBtn: UIButton!
    
    @IBOutlet weak var PlusBtn: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        Namelabel.text = "producte name".localize()
        pricelabel.text = "Price".localize()
        QuantityLabel.text = "Quantity".localize()
     self.dropShadow(color: #colorLiteral(red: 0.7233663201, green: 0.7233663201, blue: 0.7233663201, alpha: 0.6231271404), opacity: 0.7, offSet: CGSize(width: -1, height: 1), radius: 2, scale: true)

    }
    override func layoutSubviews() {
        super.layoutSubviews()
        Namelabel.text = "producte name".localize()
        pricelabel.text = "Price".localize()
        QuantityLabel.text = "Quantity".localize()
        self.dropShadow(color: #colorLiteral(red: 0.7233663201, green: 0.7233663201, blue: 0.7233663201, alpha: 0.6231271404), opacity: 0.7, offSet: CGSize(width: -1, height: 1), radius: 2, scale: true)
        
    }
    
    

    

}
