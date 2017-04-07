//
//  SettingsVC.swift
//  Koala
//
//  Created by David Miotti on 07/04/2017.
//  Copyright © 2017 Muxu.Muxu. All rights reserved.
//

import UIKit
import SwiftHelpers

final class SettingsVC: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    enum Row {
        case contactUs
        case rate
        case share
        
        var title: String {
            switch self {
            case .contactUs:
                return L("settings.contact_us")
            case .rate:
                return L("settings.rate")
            case .share:
                return L("settings.share")
            }
        }
    }
    
    private var rows: [Row] = [ .contactUs, .rate, .share ]
    private var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = L("settings")
        
        let closeBtn = UIBarButtonItem(title: L("settings.close"), style: .done, target: self, action: #selector(tappedCloseBtn(_:)))
        navigationItem.rightBarButtonItem = closeBtn
        
        tableView = UITableView(frame: .zero, style: .grouped)
        tableView.backgroundColor = .black
        tableView.separatorColor = "494949".UIColor
        tableView.register(SettingsCell.self, forCellReuseIdentifier: SettingsCell.classReuseIdentifier)
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 0)
        tableView.dataSource = self
        tableView.delegate = self
        view.addSubview(tableView)
        tableView.snp.makeConstraints { $0.edges.equalToSuperview() }
    }
    
    func tappedCloseBtn(_ sender: UIButton) {
        dismiss(animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    // MARK: - UITableViewDataSource
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rows.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SettingsCell.classReuseIdentifier, for: indexPath) as! SettingsCell
        let row = rows[indexPath.row]
        cell.titleLbl.text = row.title
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }

}
