

import UIKit

class shadowview: UIView {
    let mylayer = CAGradientLayer()
    override func awakeFromNib() {
        super.awakeFromNib()
       
        
        
        let color1 = #colorLiteral(red: 0.7254902124, green: 0.4784313738, blue: 0.09803921729, alpha: 1)
        let color2 = #colorLiteral(red: 0.5843137503, green: 0.8235294223, blue: 0.4196078479, alpha: 1)
        mylayer.startPoint = CGPoint(x: 0.3, y:  0.3)
        mylayer.endPoint = CGPoint(x:  0.7, y:  0.7)
        mylayer.colors=[color1,color2]
        mylayer.zPosition = 1
        mylayer.transform = CATransform3DMakeRotation(CGFloat.pi / 2, 0, 0, 1)

        self.layer.addSublayer(mylayer)
        
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        mylayer.frame=CGRect(x: 0, y: 0, width: self.frame.size.width, height: self.frame.size.height)
    }
    
}

