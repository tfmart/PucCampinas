//
//  CompleteScheduleViewController.swift
//  Puc Campinas
//
//  Created by Tomas Martins on 28/12/19.
//  Copyright © 2019 Tomas Martins. All rights reserved.
//

import UIKit
import PuccSwift

class CompleteScheduleViewController: UIViewController {
    
    //MARK: - @IBOutlets
    
    @IBOutlet weak var scheduleTableView: UITableView!
    @IBOutlet weak var weekdaysSegmentedControl: UISegmentedControl!
    
    //MARK: - Properties
    
    var selectedWeekday: Weekday? {
        let index = weekdaysSegmentedControl.selectedSegmentIndex
        let selectedDay = (index < 6) ? index + 2 : 1
        return Weekday(rawValue: selectedDay)
    }
    
    var todaySchedule: [Subject] {
        guard let weekday = selectedWeekday else { return [] }
        return ScheduleManager.classes(for: weekday)
    }
    
    //MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(named: "TodayViewBackgroundColor")
        self.weekdaysSegmentedControl.addTarget(self, action: #selector(updateTodaySubjects), for: .valueChanged)
        updateTodaySubjects()
        scheduleTableView.tableFooterView = UIView(frame: .zero)
        self.scheduleTableView.rowHeight = UITableView.automaticDimension
        self.scheduleTableView.estimatedRowHeight = 120
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if let index = self.scheduleTableView.indexPathForSelectedRow {
            self.scheduleTableView.deselectRow(at: index, animated: true)
        }
    }
    
    
    //MARK: - Methods
    @objc func updateTodaySubjects() {
        if todaySchedule.isEmpty {
            scheduleTableView.setEmptyState(with: "Sem aulas nesse dia")
            scheduleTableView.reloadData()
        } else {
            scheduleTableView.backgroundView = nil
            scheduleTableView.reloadData()
        }
    }
}

//MARK: - UITableViewDelegate & UITableViewDataSource

extension CompleteScheduleViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todaySchedule.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: kCompleteScheduleCell, for: indexPath) as? CompleteScheduleTableViewCell else  {
            return UITableViewCell()
        }
        if !todaySchedule.isEmpty {
            cell.initialize(with: todaySchedule[indexPath.row])
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailView = ClassDetailViewController()
        detailView.subject = todaySchedule[indexPath.row]
        detailView.title = todaySchedule[indexPath.row].name?.formatTitle()
        self.navigationController?.pushViewController(detailView, animated: true)
    }
}
