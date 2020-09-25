//
//  LoginDetailViewController.swift
//  InspirationApp
//
//  Created by Илья Козлов on 9/24/20.
//  Copyright © 2020 Илья Козлов. All rights reserved.
//

import UIKit
import WebKit
class LoginDetailViewController: UIViewController, WKNavigationDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        //keychain place
        
        var r: CGRect = self.view.bounds
        r.origin = CGPoint.zero
        
        let webView = WKWebView.init(frame: r)
        webView.autoresizingMask = UIView.AutoresizingMask( rawValue: UIView.AutoresizingMask.flexibleWidth.rawValue | UIView.AutoresizingMask.flexibleHeight.rawValue)
        self.view.addSubview(webView)
        
        let item: UIBarButtonItem = UIBarButtonItem.init(barButtonSystemItem: UIBarButtonItem.SystemItem.cancel, target: self, action: #selector(actionCancel))
        
        self.navigationItem.setRightBarButton(item, animated: true)
        
        
        self.navigationItem.title = "Authorize"
       
        let urlString: String =
        "https://unsplash.com/oauth/authorize?client_id=NqjzpaBLzRLHwexqIhm4vvXvb4rGo5M2nPQj4vWJKYY&client_secret=geS_47ls8YfiDUeZn_ElLEGxGwYOWzY4XrkG1D4D1xw&redirect_uri=urn:ietf:wg:oauth:2.0:oob&scope*=public+write_likes&response_type=code&grant_type=authorization_code&Accept-Version=v1&"

        let url: NSURL = NSURL.init(string: urlString)!
        let request: NSURLRequest = NSURLRequest.init(url: url as URL)
        webView.navigationDelegate=self;
        webView.load(request as URLRequest)
    
    }
    @objc func actionCancel(sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        if navigationAction.navigationType == .linkActivated {
            NSLog("allow")
            //decisionHandler(.allow)
        }
        
        let urlString = (navigationAction.request.url?.absoluteString)!
        let url = NSURL.init(string: urlString)
        
        if (url?.absoluteString?.contains("native?code"))!  {
            
        }
    decisionHandler(.allow)
       
        
    }
}

