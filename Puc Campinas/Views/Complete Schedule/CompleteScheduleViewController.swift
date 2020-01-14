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
    @IBOutlet weak var emptyClassView: UIView!
    
    //MARK: - Properties
    
    var completeSchedule: [Subject]?
    var todaySubjects: [Subject]?
    var footerView: UIView {
        let footer = UIView()
        footer.backgroundColor = UIColor(named: "TodayViewBackgroundColor")
        return footer
    }
    var emptyStateView: EmptyStateView {
        let emptyView = EmptyStateView(message: "Sem aulas nesse dia",
                                            frame: CGRect(x: 0, y: 0, width: scheduleTableView.bounds.width, height: scheduleTableView.bounds.height))
        return emptyView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.weekdaysSegmentedControl.addTarget(self, action: #selector(updateTodaySubjects), for: .valueChanged)
        updateTodaySubjects()
        self.scheduleTableView.tableFooterView = footerView
        self.scheduleTableView.rowHeight = UITableView.automaticDimension
        self.scheduleTableView.estimatedRowHeight = 120
    }
    
    //MARK: - Methods
    
    func getDayForIndex() -> Int {
        let index = weekdaysSegmentedControl.selectedSegmentIndex
        return (index < 6) ? index + 2 : 1
    }
    
    @objc func updateTodaySubjects() {
        todaySubjects = completeSchedule?.classes(forDay: getDayForIndex())
        scheduleTableView.backgroundView = (todaySubjects?.isEmpty ?? true) ? emptyStateView : nil
        scheduleTableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == kClassDetailSegue {
            if let detailTableView = segue.destination as? ClassDetailsTableViewController,
                let selectedIndex = scheduleTableView.indexPathForSelectedRow?.row {
                detailTableView.subject = todaySubjects?[selectedIndex]
                detailTableView.title = todaySubjects?[selectedIndex].name?.formatTitle()
            }
        }
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
}
