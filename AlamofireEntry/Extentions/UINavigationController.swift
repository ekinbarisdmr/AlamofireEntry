//
//  UINavigationController.swift
//  AlamofireEntry
//
//  Created by Ekin Barış Demir on 14.05.2021.
//

import Foundation
import UIKit

extension UINavigationController {
    
    func setStatusBar(backgroundColor: UIColor) {
         let statusBarFrame: CGRect
         if #available(iOS 13.0, *) {
             statusBarFrame = view.window?.windowScene?.statusBarManager?.statusBarFrame ?? CGRect.zero
         } else {
             statusBarFrame = UIApplication.shared.statusBarFrame
         }
        let topInset: CGFloat = UIApplication.shared.keyWindow?.safeAreaInsets.top ?? statusBarFrame.height

        let statusBarView = UIView(frame: CGRect(x: statusBarFrame.origin.x, y: statusBarFrame.origin.y, width: statusBarFrame.width, height: topInset))

         statusBarView.backgroundColor = backgroundColor
         view.addSubview(statusBarView)
     }
    
    
    
    
    func setupNavigationController(){
        
        self.navigationItem.title = "Galeri"
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.customColor()]
        self.navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.customColor()]
        self.navigationController?.navigationBar.tintColor = UIColor.customColor()
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.backgroundColor = .white
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for:.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.layoutIfNeeded()
        self.navigationController?.setStatusBar(backgroundColor: .white)
        self.navigationController?.navigationBar.prefersLargeTitles = true


    }
}
