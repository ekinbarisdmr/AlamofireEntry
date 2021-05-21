//
//  BaseViewController.swift
//  AlamofireEntry
//
//  Created by Ekin Barış Demir on 16.05.2021.
//

import UIKit
import MBProgressHUD

class BaseViewController: UIViewController {
    
    enum RequestStatus {
        case unknown, pending, completed(Error?)
    }
    
    var shouldHideSubviewsOnRequestStatusChange = true
    //Durum değişikliği istendiğinde alt görünümleri gizleme?
    
    var requestStatus: RequestStatus = .unknown {
        didSet {
            switch requestStatus {
            case .unknown:
                subviewsIsHidden = true
            case .pending:
                subviewsIsHidden = true
                MBProgressHUD.showAdded(to: view, animated: true)
            case .completed(let error):
                if let error = error {
                    if (error as NSError).domain == "com.alamofireobjectmapper.error" && (error as NSError).code == 2 {
                        subviewsIsHidden = true
                    }
                    else {
                        subviewsIsHidden = true
                    }
                }
                else {
                    subviewsIsHidden = false
                }
                MBProgressHUD.hide(for: view, animated: true)
            }
        }
    }
    
    var subviewsIsHidden = false {
        didSet {
            if shouldHideSubviewsOnRequestStatusChange == true {
                for subview in view.subviews {
                    subview.isHidden = subviewsIsHidden
                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
    }
    
    
    
    
    
}
