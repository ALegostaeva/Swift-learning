//
//  WikiViewController.swift
//  Project16
//
//  Created by Александра Легостаева on 09/05/2019.
//  Copyright © 2019 self. All rights reserved.
//

import UIKit
import WebKit

class WikiViewController: UIViewController {

    var webView: WKWebView!
    var place: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        webView = WKWebView()
        view = webView
        
        if let place = place, let url = URL(string: "https://en.wikipedia.org/wiki/\(place)") {
            webView.load(URLRequest(url: url))
        } else {
            return
        }
    }

}
