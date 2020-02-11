//
//  AvaAlertViewController.swift
//  Puc Campinas
//
//  Created by Tomas Martins on 09/02/20.
//  Copyright © 2020 Tomas Martins. All rights reserved.
//

import UIKit
import PuccSwift

class AvaAlertViewController: UIViewController {
    var tableView: UITableView!
    var siteID: String?
    var alerts: [Announcement] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        self.view.backgroundColor = UIColor(named: "TodayViewBackgroundColor")
        getAnnouncements()
        
    }
    
    func setupTableView() {
        self.tableView = UITableView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height), style: .insetGrouped)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.allowsSelection = false
        tableView.register(UINib(nibName: "AvaAlertTitleView", bundle: nil), forCellReuseIdentifier: kAlertViewCell)
        self.tableView.rowHeight = UITableView.automaticDimension
        self.tableView.estimatedRowHeight = 200
        self.view.addSubview(tableView)
    }
    
    func getAnnouncements() {
        self.tableView.showLoading()
        guard let siteID = self.siteID else {
            tableView.setEmptyState(with: "Nenhum alerta recente encontrado")
            return
        }
        let requester = SiteAlertRequester(configuration: PucConfiguration.shared, siteId: siteID) { (entity, token, error) in
            DispatchQueue.main.async {
                guard error == nil else {
                    self.tableView.setEmptyState(with: error!.message)
                    return
                }
                guard let avaEntity = entity, let alerts = avaEntity.announcementCollection, !alerts.isEmpty else {
                    self.tableView.setEmptyState(with: "Nenhum alerta recente encontrado")
                    return
                }
                self.alerts = alerts
                self.tableView.backgroundView = nil
                self.tableView.reloadData()
            }
        }
        requester.start()
    }
}

extension AvaAlertViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return alerts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: kAlertViewCell, for: indexPath) as? AvaAlertTableViewCell {
            cell.initialize(title: alerts[indexPath.section].title!, author: (alerts[indexPath.section].createdBy?.formatTitle())!, description: alerts[indexPath.section].body!)
            return cell
        } else {
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = UIColor.clear
        return headerView
    }
}
