//
//  ProfileViewController.swift
//  Puc Campinas
//
//  Created by Tomas Martins on 15/12/19.
//  Copyright © 2019 Tomas Martins. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.prefersLargeTitles = true
        let logoutButton = UIBarButtonItem(title: "Sair", style: .plain, target: self, action: #selector(logoutButtonPressed))
        self.navigationItem.rightBarButtonItem = logoutButton
        
        // Do any additional setup after loading the view.
    }
    
    @objc func logoutButtonPressed() {
        let logoutAlert = UIAlertController(title: "Finalizar sessão", message: "Tem certeza de que deseja encerrar sua sessão?", preferredStyle: .alert)
        let logoutAction = UIAlertAction(title: "Sim", style: .destructive) { action in
            self.endSession()
        }
        let cancelAction = UIAlertAction(title: "Não", style: .cancel, handler: nil)
        logoutAlert.addAction(logoutAction)
        logoutAlert.addAction(cancelAction)
        self.present(logoutAlert, animated: true, completion: nil)
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
