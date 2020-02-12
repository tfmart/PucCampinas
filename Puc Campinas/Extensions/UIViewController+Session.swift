//
//  UIViewController+Session.swift
//  Puc Campinas
//
//  Created by Tomas Martins on 15/12/19.
//  Copyright © 2019 Tomas Martins. All rights reserved.
//

import UIKit
import PuccSwift

extension UIViewController {
    func endSession() {
        UserDefaults.standard.set(false, forKey: "isLoggedIn")
        UserDefaults.standard.removeObject(forKey: "token")
        if let loginViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "loginViewController") as? LoginViewController {
            loginViewController.modalPresentationStyle = .fullScreen
            loginViewController.delegate = self as? NewSessionDelegate
            PucConfiguration.shared.username = ""
            PucConfiguration.shared.password = ""
            self.present(loginViewController, animated: true)
        }
    }
}
