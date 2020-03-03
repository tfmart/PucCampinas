//
//  HistoryViewController.swift
//  Puc Campinas
//
//  Created by Tomas Martins on 02/03/20.
//  Copyright © 2020 Tomas Martins. All rights reserved.
//

import UIKit
import PuccSwift

class HistoryViewController: UIViewController {
    var historyTableView: UITableView!
    var history: [HistorySubjects] = []
    var sectionTitle: [String] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Histórico"
        self.setupTableView()
        self.getHistory()
    }
    
    private func setupTableView() {
        historyTableView = UITableView(frame: CGRect(x: 0,
                                                        y: 0,
                                                        width: self.view.frame.width,
                                                        height: self.view.frame.height),
                                          style: .plain)
        historyTableView.backgroundColor = UIColor(named: "TodayViewBackgroundColor")
        historyTableView.tableFooterView = UIView(frame: .zero)
        historyTableView.register(UITableViewCell.self, forCellReuseIdentifier: "kHistoryDetail")
        self.historyTableView.delegate = self
        self.historyTableView.dataSource = self
        self.view.addSubview(historyTableView)
    }
    
    private func getHistory() {
        let requester = HistoryRequester(configuration: PucConfiguration.shared) { (history, token, error) in
            guard let history = history else {
                //handle request error
                return
            }
            self.history = history
            self.historyTableView.reloadData()
        }
        requester.start()
    }

}

extension HistoryViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.history.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = historyTableView.dequeueReusableCell(withIdentifier: "kHistoryDetail", for: indexPath)
        cell.textLabel?.text = self.history[indexPath.row].name?.formatTitle()
        return cell
    }
    
//    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        return sectionTitle[section]
//    }
    
}
