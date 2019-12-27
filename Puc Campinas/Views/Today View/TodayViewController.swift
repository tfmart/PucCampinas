//
//  ViewController.swift
//  Puc Campinas
//
//  Created by Tomas Martins on 02/12/19.
//  Copyright © 2019 Tomas Martins. All rights reserved.
//

import UIKit
import PuccSwift

class TodayViewController: UIViewController {
    
    //MARK: - @IBOutlets
    @IBOutlet weak var tableView: UITableView!
    
    //MARK: - Properties
    var schedule: [Subject]?
    var avaSites: [AvaSite]?
    var pucNotifications: [PucNotification]?
    var avaToken: String?
    
    var shouldScroll: Bool {
        return tableView.contentSize.height > tableView.frame.size.height
    }
    
    var isLoggedIn: Bool {
        let session = UserDefaults.standard.bool(forKey: "isLoggedIn")
        guard let token = UserDefaults.standard.string(forKey: "token") else {
            return false
        }
        return session && !token.isEmpty
    }
    
    //MARK: - Life Cycle methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.titleView = setTitle(title: "Hoje", subtitle: Date().scheduleDateTitle()?.uppercased() ?? "")
        self.tableView.alwaysBounceVertical = shouldScroll
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        initialConfiguration()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.hidesBarsOnSwipe = shouldScroll
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.hidesBarsOnSwipe = false
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    //MARK: - Initial Configuration
    func initialConfiguration() {
        if !isLoggedIn {
            presentLogin()
        } else {
            getConfiguration()
            fetchSchedule()
            fetchAvaClasses()
            fetchPucNotifications()
        }
    }
    
    
    //MARK: - Requester methods
    
    func fetchSchedule() {
        let scheduleRequester = ScheduleRequester(configuration: PucConfiguration.shared) { (schedule, requestToken, error) in
            guard let schedule = schedule else {
                //Handle API error
                return
            }
//            self.schedule = schedule
            self.schedule = DemoSchedule.shared.schedule
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        scheduleRequester.start()
    }
    
    func fetchAvaClasses() {
        let avaRequester = AvaSiteRequester(configuration: PucConfiguration.shared) { (avaEntity, requestToken, error) in
            guard let avaEntity = avaEntity, let avaSites = avaEntity.siteCollection else {
                //Handle API error
                return
            }
            self.avaSites = avaSites
            self.avaToken = requestToken
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        avaRequester.start()
    }
    
    func fetchPucNotifications() {
        let notificationRequester = NotificationRequester(configuration: PucConfiguration.shared) { (notifications, requestToken, error) in
            guard let notifications = notifications else {
                return
            }
            self.pucNotifications = notifications
        }
        notificationRequester.start()
    }
    
    //MARK: - LoginViewController
    
    func presentLogin() {
        let loginViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "loginViewController")
        loginViewController.modalPresentationStyle = .fullScreen
        self.present(loginViewController, animated: true)
    }
    
    private func getConfiguration() {
        guard let token = UserDefaults.standard.string(forKey: "token"),
        let decodedData = Data(base64Encoded: token),
        let decodedString = String(data: decodedData, encoding: .utf8) else { return }
        let configurationData = decodedString.components(separatedBy: ":")
        PucConfiguration.shared.username = configurationData[0]
        PucConfiguration.shared.password = configurationData[1]
    }
}

extension TodayViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == kTodayNotification,
            let notificationTableView = segue.destination as? NotificationsTableViewController {
            notificationTableView.notifications = self.pucNotifications
        }
    }
}

//MARK: - UITableViewDataSource + UITableViewDelegate

extension TodayViewController: UITableViewDataSource, UITableViewDelegate {
    
    //Number of Rows
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    //Cell for Row At
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            if let scheduleCell = tableView.dequeueReusableCell(withIdentifier: kTodayScheduleTableCell, for: indexPath) as? ScheduleTableViewCell {
                scheduleCell.schedule = schedule
                scheduleCell.todaysSchedule = schedule?.todayClasses()
                scheduleCell.setLabels()
                scheduleCell.selectionStyle = .none
                scheduleCell.scheduleCollectionView.reloadData()
                return scheduleCell
            }
        }
        
        if indexPath.row == 1 {
            if let scheduleButtonCell = tableView.dequeueReusableCell(withIdentifier: kTodayButtonCell, for: indexPath) as? ScheduleButtonTableViewCell {
                scheduleButtonCell.selectionStyle = .none
                return scheduleButtonCell
            }
        }
        
        if indexPath.row == 2 {
            if let avaCell = tableView.dequeueReusableCell(withIdentifier: kTodayAvaTableCell, for: indexPath) as? AvaTableViewCell  {
                avaCell.selectionStyle = .none
                avaCell.avaSites = avaSites
                avaCell.avaCollectionView.reloadData()
                avaCell.delegate = self
                return avaCell
            }
        }
        
        return UITableViewCell()
    }
    
    //Height for Row At
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 192
        }
        if indexPath.row == 1 {
            return 74
        }
        if indexPath.row == 2 {
            return 220
        }
        return 0
    }
}

extension TodayViewController: TodayViewCellDelegate {
    func selectedItem(_ item: Any) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        if let avaSite = item as? AvaSite,
            let avaDetailViewController = storyBoard.instantiateViewController(withIdentifier: "avaPagesTableView") as? AvaPagesTableViewController {
            avaDetailViewController.avaSite = avaSite
            avaDetailViewController.token = self.avaToken
            self.navigationController?.pushViewController(avaDetailViewController, animated: true)
        } else if let subject = item as? Subject {
            //Class detail view segue
        }
    }
}
