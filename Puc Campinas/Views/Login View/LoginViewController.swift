//
//  LoginViewController.swift
//  Puc Campinas
//
//  Created by Tomas Martins on 02/12/19.
//  Copyright © 2019 Tomas Martins. All rights reserved.
//

import UIKit
import PuccSwift

class LoginViewController: UIViewController {
    
    //MARK: @IBOutlets
    @IBOutlet var usernameTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    @IBOutlet var loginButton: UIButton!
    
    var delegate: NewSessionDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        interaction(isEnabled: false)
        usernameTextField.delegate = self
        passwordTextField.delegate = self
    }
    
    @IBAction func loginButtonPressed(_ sender: Any) {
        self.doLogin()
    }
    
    func doLogin() {
        self.loginButton.showLoading()
        guard let username = self.usernameTextField.text, let password = self.passwordTextField.text else {
            // handle invalid text error
            loginButton.hideLoading()
            return
        }
        let configuration = PucConfiguration(username: username, password: password)
        let requester = LoginRequester(configuration: configuration) { (fetchedStudent, requestToken, error) in
            guard let student = fetchedStudent, student.error == nil else {
                self.showErrorAlert(error: error ?? .invalidToken)
                self.loginButton.hideLoading()
                return
            }
            //perform segue to TodayViewController
            DispatchQueue.main.async {
                UserDefaults.standard.set(true, forKey: "isLoggedIn")
                UserDefaults.standard.set(configuration.pucToken, forKey: "token")
                self.navigationController?.popViewController(animated: true)
                self.delegate?.didCloseModal()
                self.dismiss(animated: true, completion: nil)
            }
        }
        requester.start()
    }
    
    fileprivate func showErrorAlert(error: APIServiceError) {
        DispatchQueue.main.async {
            let errorAlert = UIAlertController(title: error.title, message: error.message, preferredStyle: .alert)
            errorAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            self.present(errorAlert, animated: true, completion: nil)
        }
    }
    
    func interaction(isEnabled: Bool) {
        self.loginButton.isEnabled = isEnabled
        let buttonColor = (isEnabled ? UIColor.systemBlue : UIColor.systemGray)
        self.loginButton.backgroundColor = buttonColor
    }
}

//MARK: - UITextFieldDelegate

extension LoginViewController: UITextFieldDelegate {
    
    // Hides keyboard when return is pressed
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        if loginButton.isEnabled {
            doLogin()
        }
        return true
    }
    
    // Checks if text fields has valid input for login
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let username = usernameTextField.text, let password = passwordTextField.text else {
            interaction(isEnabled: false)
            return false
        }
        let shouldEnable = !(username.isEmpty || password.isEmpty)
        interaction(isEnabled: shouldEnable)
        return true
    }
}
