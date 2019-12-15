//
//  UIViewController+Session.swift
//  Puc Campinas
//
//  Created by Tomas Martins on 15/12/19.
//  Copyright © 2019 Tomas Martins. All rights reserved.
//

import UIKit

extension UIViewController {
    func endSession() {
        UserDefaults.standard.set(false, forKey: "isLoggedIn")
        UserDefaults.standard.removeObject(forKey: "token")
        let loginViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "loginViewController")
        loginViewController.modalPresentationStyle = .fullScreen
        self.present(loginViewController, animated: true)
    }
}
