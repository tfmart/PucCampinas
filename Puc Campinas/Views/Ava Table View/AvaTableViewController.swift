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

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.prefersLargeTitles = true
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView(frame: .zero)
        tableView.showLoading()
        self.clearsSelectionOnViewWillAppear = true
        setupRefreshControl()
        fetchAvaSites()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationItem.largeTitleDisplayMode = .always
        if let index = self.tableView.indexPathForSelectedRow{
            self.tableView.deselectRow(at: index, animated: true)
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return AvaManager.sites.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: kAvaHomeTableViewCell, for: indexPath) as? AvaHomeTableViewCell else {
            return UITableViewCell()
        }
        cell.initialize(withSite: AvaManager.sites[indexPath.row])
        cell.accessoryType = .disclosureIndicator
        return cell
    }
    
    func fetchAvaSites() {
        self.tableView.showLoading()
        AvaManager.fetchSites { (_) in
            DispatchQueue.main.async {
                self.tableView.reloadData()
                self.tableView.hideLoading()
            }
        } failure: { (_) in
            self.tableView.setEmptyState(with: "Nenhuma página do AVA foi encontrada")
        }
    }
    
    @objc func refreshSites() {
        self.fetchAvaSites()
        self.refreshControl?.endRefreshing()
    }
    
    func setupRefreshControl() {
        self.refreshControl?.attributedTitle = NSAttributedString(string: "Puxe para atualizar")
        self.refreshControl?.addTarget(self, action: #selector(refreshSites), for: .valueChanged)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == kAvaPagesSegue {
            if let avaPagesViewController = segue.destination as? AvaPagesTableViewController,
                let selectedIndex = self.tableView.indexPathForSelectedRow?.row {
                avaPagesViewController.avaSite = AvaManager.sites[selectedIndex]
                avaPagesViewController.token = AvaManager.token
            }
        }
    }
}
