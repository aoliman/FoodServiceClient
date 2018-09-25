//
//  ViewOfCellInCompleteorder.swift
//  FoodService
//
//  Created by index-ios on 3/14/18.
//  Copyright © 2018 index-ios. All rights reserved.
//

import UIKit

class ViewOfCellInCompleteorder: UIView {

    override func draw(_ rect: CGRect) {
        let aPath = UIBezierPath()
        
        aPath.move(to: CGPoint(x:0, y:0))
        
        aPath.addLine(to: CGPoint(x:CGFloat(Double(self.layer.frame.width)), y:0))
        
        //Keep using the method addLineToPoint until you get to the one where about to close the path
        
        aPath.close()
        
        //If you want to stroke it with a red color
        UIColor.lightGray.set()
        aPath.stroke()
        //If you want to fill it as well
        aPath.fill()
    }

}
