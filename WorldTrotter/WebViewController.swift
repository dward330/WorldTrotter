//
//  WebViewController.swift
//  WorldTrotter
//
//  Created by Derrick Ward on 12/20/16.
//  Copyright © 2016 Derrick Ward. All rights reserved.
//

import UIKit;
import WebKit;

class WebViewController: UIViewController {
    
    var webView : WKWebView!
    
    override func loadView() {
        //Create and Set the View of this Controller
        self.webView = WKWebView();
        self.view = self.webView;
        
        let url = URL(string: "https://www.hugginsfamilysvg.com");
        let urlRequest = URLRequest(url: url!);
        
        //Set Website View should show
        self.webView.load(urlRequest);
    }
    
    override func viewDidLoad() {
        print("Web View Did Load!");
    }
}
