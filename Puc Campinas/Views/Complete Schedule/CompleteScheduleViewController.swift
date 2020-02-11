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
    
    var completeSchedule: [Subject]?
    var todaySubjects: [Subject]?
    
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
    
    func getDayForIndex() -> Int {
        let index = weekdaysSegmentedControl.selectedSegmentIndex
        return (index < 6) ? index + 2 : 1
    }
    
    @objc func updateTodaySubjects() {
        todaySubjects = completeSchedule?.classes(forDay: getDayForIndex())
        if (todaySubjects?.isEmpty ?? true) {
            scheduleTableView.setEmptyState(with: "Sem aulas nesse dia")
        } else {
            scheduleTableView.backgroundView = nil
        }
        scheduleTableView.reloadData()
    }
}

//MARK: - UITableViewDelegate & UITableViewDataSource

extension CompleteScheduleViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todaySubjects?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: kCompleteScheduleCell, for: indexPath) as? CompleteScheduleTableViewCell else  {
            return UITableViewCell()
        }
        if let todaySubjects =  todaySubjects, todaySubjects.count > 0 {
            cell.initialize(with: todaySubjects[indexPath.row])
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let subject = self.todaySubjects?[indexPath.row] else { return }
        let detailView = ClassDetailViewController()
        detailView.subject = subject
        detailView.title = subject.name?.formatTitle()
        self.navigationController?.pushViewController(detailView, animated: true)
    }
}
