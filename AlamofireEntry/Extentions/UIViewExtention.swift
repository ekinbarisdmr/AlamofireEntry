//
//  UIViewExtention.swift
//  AlamofireEntry
//
//  Created by Ekin Barış Demir on 15.05.2021.
//

import Foundation
import UIKit

extension UIView {
    func roundCorners(corners: UIRectCorner, radius: CGFloat) {
         let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
         let mask = CAShapeLayer()
         mask.path = path.cgPath
         layer.mask = mask
     }
     
}
