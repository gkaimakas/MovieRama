//
//  UIView.swift
//  MoviewRamaViews
//
//  Created by George Kaimakas on 09/11/2018.
//  Copyright © 2018 George Kaimakas. All rights reserved.
//


extension UIView
{
    func round(corners: UIRectCorner, radius: CGFloat)
    {
        if #available(iOS 11.0, *) {
            var maskedCorners: CACornerMask = []
            
            if corners.contains(.topLeft) {
                maskedCorners.insert(.layerMinXMinYCorner)
            }
            if corners.contains(.topRight) {
                maskedCorners.insert(.layerMaxXMinYCorner)
            }
            if corners.contains(.bottomLeft) {
                maskedCorners.insert(.layerMinXMaxYCorner)
            }
            if corners.contains(.bottomRight) {
                maskedCorners.insert(.layerMaxXMaxYCorner)
            }
            
            self.clipsToBounds = true
            layer.cornerRadius = radius
            layer.maskedCorners = maskedCorners
            
        } else {
            self.clipsToBounds = true
            let path = UIBezierPath(roundedRect: bounds,
                                    byRoundingCorners: corners,
                                    cornerRadii: CGSize(width: radius, height: radius))
            
            let maskLayer = CAShapeLayer()
            
            maskLayer.path = path.cgPath
            layer.mask = maskLayer
        }
    }
}
