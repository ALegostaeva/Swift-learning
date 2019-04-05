//
//  ViewController.swift
//  Project4
//
//  Created by Александра Легостаева on 02/04/2019.
//  Copyright © 2019 self. All rights reserved.
//

import UIKit
import WebKit

class ViewController: UIViewController, WKNavigationDelegate {

    var webView: WKWebView!
    
    override func loadView() {
        webView = WKWebView()
        webView.navigationDelegate = self
        view = webView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let url = URL(string: "https://imgdr.com.au/")
        webView.load(URLRequest(url: url!))
        webView.allowsBackForwardNavigationGestures = true
        
        func openTapped() {
            
            let ac = UIAlertController(title: "Open page…", message: nil, preferredStyle: .actionSheet)
            
            ac.addAction(UIAlertAction(title: "apple.com", style: .default, handler: openPage))
            ac.addAction(UIAlertAction(title: "imgdr.com.au", style: .default, handler: openPage))
            ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
            
            ac.popoverPresentationController?.barButtonItem = self.navigationItem.rightBarButtonItem
            present(ac, animated: true)
            
        }
        
        func openPage(action: UIAlertAction) {
            let url = URL(string: "https://" + action.title!)!
            webView.load(URLRequest(url: url))
        }
        
        func webView(_<#T##webView: WKWebView##WKWebView#>, didFinish navigation: <#T##WKNavigation!#>) {
            title = webView.title
        }
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Open", style: .plain, target: self, action: #selector(openTapped))
        
        
    }

}

