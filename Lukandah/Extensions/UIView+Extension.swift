//
//  UIView+Extension.swift
//  Lukandah
//
//  Created by MacBook M1 on 13/05/22.
//

import UIKit

extension UIView{
    
          func roundCorners(_ corners:UIRectCorner, radius: CGFloat) {
            let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
            let mask = CAShapeLayer()
            mask.path = path.cgPath
            self.layer.mask = mask
        }
    
}
