//
//  AvaWebViewController.swift
//  Puc Campinas
//
//  Created by Tomas Martins on 16/12/19.
//  Copyright © 2019 Tomas Martins. All rights reserved.
//

import WebKit
import UIKit

class AvaWebViewController: UIViewController {
    let webView = WKWebView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
    let activityIndicator = UIActivityIndicatorView()
    var url: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemBackground
        self.showLoading()
        self.navigationItem.largeTitleDisplayMode = .never
        configureWebView()
        self.view.addSubview(webView)
    }
    
    func configureWebView() {
        self.webView.navigationDelegate = self
        webView.alpha = 0
        if let urlString = self.url, let url = URL(string: urlString) {
            let request = URLRequest(url: url)
            webView.load(request)
        }
    }
}

//MARK: - WKNavigationDelegate

extension AvaWebViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        removeHtmlElements()
        UIView.animate(withDuration: 0.5, animations: {
            webView.alpha = 1
        }) { didFinish in
            self.removeLoading()
        }
    }
    
    func removeHtmlElements() {
        let removeHeaderJS = "var style = document.createElement('style'); style.innerHTML = '.logoutLink { display: none !important; } .backLink { display: none !important; } .resetToolLink { display: none !important; } '; document.head.appendChild(style); "
        webView.evaluateJavaScript(removeHeaderJS)
    }
}

//MARK: - UIActivityIndicatorView

extension AvaWebViewController {
    func showLoading() {
        activityIndicator.hidesWhenStopped = true
        activityIndicator.center = CGPoint(x: self.view.frame.width/2, y: self.view.frame.height/2)
        activityIndicator.startAnimating()
        self.view.addSubview(activityIndicator)
    }
    
    func removeLoading() {
        DispatchQueue.main.async {
            self.activityIndicator.stopAnimating()
            self.activityIndicator.removeFromSuperview()
        }
    }
}
