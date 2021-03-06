//
//  ProfileViewController.swift
//  Puc Campinas
//
//  Created by Tomas Martins on 15/12/19.
//  Copyright © 2019 Tomas Martins. All rights reserved.
//

import UIKit
import PuccSwift

class ProfileViewController: UIViewController {
    var tableView: UITableView!
    // User Info Cell properties
    var student: Student?
    var name: String!
    var ra: String!
    var courseName: String?
    var period: Int?
    var shift: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        self.navigationController?.navigationBar.prefersLargeTitles = true
        let logoutButton = UIBarButtonItem(title: "Sair", style: .plain, target: self, action: #selector(logoutButtonPressed))
        getStudentInfo()
        self.navigationItem.rightBarButtonItem = logoutButton
    }
    
    func setupTableView() {
        self.tableView = UITableView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height), style: .grouped)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 140
        tableView.separatorStyle = .none
        tableView.register(UINib(nibName: "UserInfoCell", bundle: nil), forCellReuseIdentifier: kUserInfoCell)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "kHistoryCell")
        self.view.addSubview(tableView)
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
    
    func getStudentInfo() {
        let requester = LoginRequester(configuration: PucConfiguration.shared) { (student, token, error) in
            DispatchQueue.main.async {
                guard let student = student else {
                    //handle error
                    self.tableView.hideLoading()
                    return
                }
                self.student = student
                self.checkStudentData()
                self.tableView.hideLoading()
                self.tableView.reloadData()
            }
        }
        requester.start()
        self.tableView.showLoading()
    }
    
    func checkStudentData() {
        if let name = self.student?.name?.formatTitle(),
            let ra = self.student?.ra,
            let courseName = self.student?.course?.name?.formatTitle(),
            let period = Int(self.student?.period ?? ""),
            let shift = self.student?.course?.shift {
            self.name = name
            self.ra = ra
            self.courseName = courseName
            self.period = period
            self.shift = shift
        }
    }
}

extension ProfileViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.student == nil ? 0 : 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: kUserInfoCell, for: indexPath) as! UserInfoTableViewCell
            if self.student != nil {
                cell.initialize(name: name, ra: ra, course: courseName ?? "Curso desconhecido",
                                quarter: period,
                                shift: shift ?? "Turno desconhecido")
                cell.selectionStyle = .none
                return cell
            }
        }
        
        if indexPath.section == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "kHistoryCell", for: indexPath)
            cell.textLabel?.text = "Histórico"
            cell.accessoryType = .disclosureIndicator
            return cell
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 1 {
            let historyViewController = HistoryViewController()
            tableView.deselectRow(at: indexPath, animated: true)
            self.navigationController?.pushViewController(historyViewController, animated: true)
        }
    }
    
}

extension ProfileViewController: NewSessionDelegate {
    func didCloseModal() {
        getStudentInfo()
    }
}
