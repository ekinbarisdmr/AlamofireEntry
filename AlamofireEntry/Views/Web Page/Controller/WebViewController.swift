//
//  WebViewController.swift
//  AlamofireEntry
//
//  Created by Ekin Barış Demir on 15.05.2021.
//

import UIKit
import WebKit

class WebViewController: UIViewController, WKNavigationDelegate, WKUIDelegate {
    
    @IBOutlet weak var webView: WKWebView!
    var link: String = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .clear
        
        view = webView
        
        webView.uiDelegate = self
        let myURL = URL(string: "\(link)")
        let myRequest = URLRequest(url: myURL!)
        webView.load(myRequest)
        webView.backgroundColor = .clear
        
        
        //To go forward:
        let leftSwipe = UISwipeGestureRecognizer(target: webView, action: #selector(webView.goForward))
        leftSwipe.direction = .left
        webView.addGestureRecognizer(leftSwipe)
        
        //To go back:
        let rightSwipe = UISwipeGestureRecognizer(target: webView, action: #selector(webView.goBack))
        rightSwipe.direction = .right
        webView.addGestureRecognizer(rightSwipe)
        
        
    }
    
    
    
    
    @IBAction func back(_ sender: Any) {
        
        if webView.canGoBack {
            webView.goBack()
        }
        
    }
    
    @IBAction func refresh(_ sender:Any) {
        
        if webView.canGoForward {
            webView.goForward()
        }
        
    }
    
    @IBAction func forward(_ sender:Any) {
        
        webView.reload()
        
    }
    
}


