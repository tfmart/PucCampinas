//
//  AvaTableViewController.swift
//  Puc Campinas
//
//  Created by Tomas Martins on 15/12/19.
//  Copyright © 2019 Tomas Martins. All rights reserved.
//

import UIKit
import PuccSwift

class AvaTableViewController: UITableViewController {
    var avaSites: [AvaSite]?
    var token: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.prefersLargeTitles = true
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView(frame: .zero)
        tableView.showLoading()
        fetchAvaSites()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return avaSites?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: kAvaHomeTableViewCell, for: indexPath) as? AvaHomeTableViewCell else {
            return UITableViewCell()
        }
        if let avaSite = avaSites?[indexPath.row] {
            cell.initialize(withSite: avaSite)
            cell.accessoryType = .disclosureIndicator
        }
        return cell
    }
    
    func fetchAvaSites() {
        let requester = AvaSiteRequester(configuration: PucConfiguration.shared) { (avaEntity, requestToken, error) in
            guard let avaEntity = avaEntity, let avaSites = avaEntity.siteCollection else {
                //handle request error
                return
            }
            DispatchQueue.main.async {
                self.avaSites = avaSites
                self.token = requestToken
                self.tableView.reloadData()
            }
        }
        self.tableView.hideLoading()
        requester.start()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == kAvaPagesSegue {
            if let avaPagesViewController = segue.destination as? AvaPagesTableViewController,
                let selectedIndex = self.tableView.indexPathForSelectedRow?.row {
                avaPagesViewController.avaSite = self.avaSites?[selectedIndex]
                avaPagesViewController.token = self.token
            }
        }
    }
}
