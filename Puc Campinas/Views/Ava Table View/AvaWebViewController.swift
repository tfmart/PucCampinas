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
    var url: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.title = title
        self.navigationItem.largeTitleDisplayMode = .never
        configureWebView()
        self.view.addSubview(webView)
    }
    
    func configureWebView() {
        if let urlString = self.url, let url = URL(string: urlString) {
            let request = URLRequest(url: url)
            webView.load(request)
        }
    }
}
