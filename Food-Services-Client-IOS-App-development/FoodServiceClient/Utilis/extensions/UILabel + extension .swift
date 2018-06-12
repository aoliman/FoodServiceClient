//
//  UILabel.swift
//  FoodServiceProvider
//
//  Created by Index on 12/18/17.
//  Copyright © 2017 index-pc. All rights reserved.
//
import Localize_Swift

extension UILabel
{
    func SetAttribute(AppendingattStringTitle:String )
    {
        let title = NSMutableAttributedString(string: self.text!, attributes: [NSAttributedStringKey.foregroundColor : UIColor.black])
        let attributes = [NSAttributedStringKey.foregroundColor : UIColor.init(hex: "4695a5")]
        let attStringTitle = NSAttributedString(string: AppendingattStringTitle, attributes: attributes)
        title.append(attStringTitle)
        self.attributedText = title
    }
    
    func setAlignment()
    {
        
        if Localize.currentLanguage() == "en"
        {
            self.textAlignment = .left

        }
        else
        {
            self.textAlignment = .right

        }
    }
    
    func createCornerRadius()
    {
        if(Localize.currentLanguage() == "en")
        {
            let maskPath = UIBezierPath(roundedRect: self.bounds,
                                        byRoundingCorners: [.bottomLeft],
                                        cornerRadii: CGSize(width: 15.0, height: 0.0))
            
            let maskLayer = CAShapeLayer()
            maskLayer.path = maskPath.cgPath
            self.layer.mask = maskLayer
            
        }
        else
        {
            let maskPath = UIBezierPath(roundedRect: self.bounds,
                                        byRoundingCorners: [.bottomRight],
                                        cornerRadii: CGSize(width: 15.0, height: 0.0))
            
            let maskLayer = CAShapeLayer()
            maskLayer.path = maskPath.cgPath
            self.layer.mask = maskLayer
            
        }
        
    }
    
    func addIconLabel(_ icon: String, _ color: UIColor, _ iconLabel: UILabel)
    {
        self.addSubview(iconLabel)
        iconLabel.textColor = color
        iconLabel.text = String.fontAwesomeIcon(code: icon)
        
        iconLabel.snp.remakeConstraints { make in
            if Localize.currentLanguage() == "en"
            {
                make.right.equalTo(self.snp.right).offset(-15)
            }else
            {
                make.left.equalTo(self.snp.left).offset(15)
            }
            make.width.equalTo(30)
            make.height.equalTo(self.snp.height)
            make.centerY.equalTo(self)
        }
        iconLabel.isHidden = false
    }
    //
    //    func createBottomBorder()
    //    {
    //        let maskPath = UIBezierPath(roundedRect: self.bounds,
    //                                    byRoundingCorners: [.],
    //                                    cornerRadii: CGSize(width: 15.0, height: 0.0))
    //
    //        let maskLayer = CAShapeLayer()
    //        maskLayer.path = maskPath.cgPath
    //        self.layer.mask = maskLayer
    //
    //    }
    
}



