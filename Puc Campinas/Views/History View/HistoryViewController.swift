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
    var history: [FormattedHistory] = []

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
        historyTableView.register(UINib(nibName: "HistoryDetailTableViewCell", bundle: nil), forCellReuseIdentifier: kHistoryDetailCell)
        historyTableView.rowHeight = UITableView.automaticDimension
        historyTableView.estimatedRowHeight = 140
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
            self.history = history.formattedData
            DispatchQueue.main.async {
                self.historyTableView.reloadData()
                self.historyTableView.hideLoading()
            }
        }
        self.historyTableView.showLoading()
        requester.start()
    }

}

extension HistoryViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.history[section].subject.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.history.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: kHistoryDetailCell, for: indexPath) as? HistoryDetailTableViewCell else {
            return UITableViewCell()
        }
        cell.titleLabel.text = self.history[indexPath.section].subject[indexPath.row].name?.formatTitle()
        cell.hoursLabel.text = "\(String(describing: self.history[indexPath.section].subject[indexPath.row].workload)) horas de aula"
        cell.codeLabel.text = self.history[indexPath.section].subject[indexPath.row].code
        cell.gradeLabel.text = self.history[indexPath.section].subject[indexPath.row].finalGrade
        cell.statusLabel.text = self.history[indexPath.section].subject[indexPath.row].description.rawValue
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return history[section].year.formatYear()
    }
    
}
