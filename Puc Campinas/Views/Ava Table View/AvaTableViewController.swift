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

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.prefersLargeTitles = true
        tableView.delegate = self
        tableView.dataSource = self
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
        cell.siteTitleLabel.text = avaSites?[indexPath.row].title
        return cell
    }
    
    func fetchAvaSites() {
        let requester = AvaSiteRequester(configuration: PucConfiguration.shared) { (avaEntity, error) in
            guard let avaEntity = avaEntity, let avaSites = avaEntity.siteCollection else {
                //handle request error
                return
            }
            DispatchQueue.main.async {
                self.avaSites = avaSites
                self.tableView.reloadData()
            }
        }
        requester.start()
    }
}
