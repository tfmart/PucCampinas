//
//  ClassDetailViewController.swift
//  Puc Campinas
//
//  Created by Tomas Martins on 04/02/20.
//  Copyright © 2020 Tomas Martins. All rights reserved.
//

import UIKit
import PuccSwift
import MapKit.MKGeometry

class ClassDetailViewController: UIViewController {
    
    var tableView: UITableView!
    var subject: Subject?
    var cellCount: Int = 0
    var cellType: [DetailCellType] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupTableView()
        self.navigationItem.largeTitleDisplayMode = .never
        self.view.backgroundColor = UIColor(named: "TodayViewBackgroundColor")
        tableView.alwaysBounceVertical = tableView.contentSize.height > tableView.frame.size.height
        self.tableView.reloadData()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationItem.largeTitleDisplayMode = .always
    }
    
    func getCells() {
        if subject?.courseName?.formatTitle() != nil, subject?.turn != nil {
            cellCount += 1
            cellType.append(.courseInfo)
        }
        if subject?.time != nil , subject?.duration != nil {
            cellCount += 1
            cellType.append(.schedule)
        }
        if subject?.professor?.formatTitle() != nil, subject?.classroom != nil {
            cellCount += 1
            cellType.append(.classroom)
        }
        if subject?.building?.formatTitle() != nil, subject?.classroom != nil,
            subject?.locationWithCampusString != nil,
            let latitude = subject?.latitude, let longitude = subject?.longitude,
            Double(latitude) != nil, Double(longitude) != nil {
            cellCount += 1
            cellType.append(.location)
        }
        cellCount += 1
        cellType.append(.attendance)
    }
}

extension ClassDetailViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return cellCount
        } else {
            return subject?.description != nil ? 1 : 0
        }
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return subject?.description != nil ? 2 : 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section > 0, let summary = subject?.description {
            let cell = tableView.dequeueReusableCell(withIdentifier: kSummaryCell, for: indexPath) as! SummaryButtonCell
            cell.delegate = self
            cell.initialize(with: summary)
            return cell
        } else {
            let type = cellType[indexPath.row]
            switch type {
            case .courseInfo:
                if let cell = tableView.dequeueReusableCell(withIdentifier: kDetailCell, for: indexPath) as? ClassDetailCell {
                    cell.initalize(.courseInfo, firstDescription: (subject?.courseName?.formatTitle())!, secondDescription: (subject?.turn)!)
                    return cell
                }
            case .schedule:
                if let cell = tableView.dequeueReusableCell(withIdentifier: kDetailCell, for: indexPath) as? ClassDetailCell {
                    cell.initalize(.schedule, firstDescription: (subject?.time)!, secondDescription: (subject?.duration)!)
                    return cell
                }
            case .classroom:
                if let cell = tableView.dequeueReusableCell(withIdentifier: kDetailCell, for: indexPath) as? ClassDetailCell {
                    cell.initalize(.classroom, firstDescription: (subject?.professor?.formatTitle())!, secondDescription: (subject?.classroom)!)
                    return cell
                }
            case .location:
                if let cell = tableView.dequeueReusableCell(withIdentifier: kLocationCell, for: indexPath) as? LocationInfoCell {
                    if let building = subject?.building?.formatTitle(), subject?.classroom != nil,
                        let title = subject?.locationWithCampusString,
                        let latitude = subject?.latitude, let longitude = subject?.longitude,
                        let latitudeValue = Double(latitude), let longitudeValue = Double(longitude) {
                        cell.initialize(title: title, latitude: latitudeValue, longitude: longitudeValue, building: "Prédio \(building)")
                        cell.delegate = self
                    }
                    return cell
                }
            case .attendance:
                if let cell = tableView.dequeueReusableCell(withIdentifier: kAttendanceCell, for: indexPath) as? ClassAttendanceTableViewCell {
                    cell.initialize(percentage: subject?.attendance, attendedAmount: subject?.attendedClasses, totalAmount: subject?.amountClasses, lastUpdate: subject?.lastUpdate)
                    return cell
                }
            case .description:
                return UITableViewCell()
            }
        }
        return UITableViewCell()
    }
    
    func setupTableView() {
        self.tableView = UITableView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height), style: .insetGrouped)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.allowsSelection = false
        tableView.register(UINib(nibName: "ClassDetailViewCell", bundle: nil), forCellReuseIdentifier: "detailCell")
        tableView.register(UINib(nibName: "LocationInfoCell", bundle: nil), forCellReuseIdentifier: "locationDetail")
        tableView.register(UINib(nibName: "ClassAttendanceCell", bundle: nil), forCellReuseIdentifier: "classAttendanceCell")
        tableView.register(SummaryButtonCell.self, forCellReuseIdentifier: kSummaryCell)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 100
        tableView.separatorStyle = .none
        self.view.addSubview(tableView)
        self.getCells()
    }
}

extension ClassDetailViewController: SelectedCellDelegate {
    func selectedItem(_ item: Any) {
        if let summary = item as? String {
            let summaryView = SummaryViewController()
            summaryView.summary = summary
            self.navigationController?.present(UINavigationController(rootViewController: summaryView), animated: true)
        }
        if item as? MKCoordinateRegion != nil {
            if let subject = self.subject {
                let mapViewController = ClassroomLocationViewController()
                mapViewController.mapView.setMapRegion(with: subject)
                mapViewController.title = "Prédio \(subject.building?.formatTitle() ?? "")"
                self.navigationController?.pushViewController(mapViewController, animated: true)
            }
        }
    }
}
