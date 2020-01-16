//
//  NotificationsTableViewController.swift
//  Puc Campinas
//
//  Created by Tomás Feitoza Martins  on 22/12/19.
//  Copyright © 2019 Tomas Martins. All rights reserved.
//

import UIKit
import PuccSwift

class NotificationsTableViewController: UITableViewController {
    var notifications: [PucNotification]?

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView(frame: .zero)
        self.tableView.reloadData()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notifications?.count ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: kPucNotificationCell, for: indexPath) as? NotificationsTableViewCell else  {
            return UITableViewCell()
        }
        cell.titleLabel?.text = notifications?[indexPath.row].type?.name
        cell.dateLabel?.text = notifications?[indexPath.row].date
        cell.descriptionLabel?.text = notifications?[indexPath.row].message
        return cell
    }
}
