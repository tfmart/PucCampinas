//
//  ClassDetailsUITableViewController.swift
//  Puc Campinas
//
//  Created by Tomas Martins on 04/01/20.
//  Copyright © 2020 Tomas Martins. All rights reserved.
//

import UIKit
import PuccSwift

class ClassDetailsTableViewController: UITableViewController {
    
    var subject: Subject?

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.allowsSelection = false
        tableView.alwaysBounceVertical = tableView.contentSize.height > tableView.frame.size.height
        self.navigationItem.largeTitleDisplayMode = .never
        self.view.backgroundColor = UIColor(named: "TodayViewBackgroundColor")
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (subject?.description != nil) ? 2 : 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            if let cell = tableView.dequeueReusableCell(withIdentifier: kDetailTableViewCell, for: indexPath) as? ClassDetailsTableViewCell {
                cell.subject = subject
                cell.initialize()
                return cell
            }
        }
        
        if indexPath.row == 1 {
            if let cell = tableView.dequeueReusableCell(withIdentifier: kSummaryButtonCell, for: indexPath) as? SummaryButtonTableViewCell,
                let summary = subject?.description {
                cell.summary = summary
                return cell
            }
        }
        return UITableViewCell()
    }
}

extension ClassDetailsTableViewController: TodayViewCellDelegate {
    func selectedItem(_ item: Any) {
        if let summary = item as? String {
            let summaryView = SummaryViewController()
            summaryView.summary = summary
            self.navigationController?.present(summaryView, animated: true)
        }
    }
}
