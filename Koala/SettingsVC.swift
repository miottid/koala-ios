//
//  SettingsVC.swift
//  Koala
//
//  Created by David Miotti on 07/04/2017.
//  Copyright © 2017 Muxu.Muxu. All rights reserved.
//

import UIKit
import SwiftHelpers
import MessageUI

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
        
        let row = rows[indexPath.row]
        switch row {
        case .contactUs:
            contactUs()
        case .rate:
            rateApp()
        case .share:
            shareApp()
        }
    }
    
    private func contactUs() {
        UINavigationBar.appearance().barTintColor = .white
        UINavigationBar.appearance().isTranslucent = false
        UINavigationBar.appearance().titleTextAttributes = [
            NSFontAttributeName: UIFont.systemFont(ofSize: 17, weight: UIFontWeightSemibold),
            NSForegroundColorAttributeName: UIColor.black
        ]
        
        let mail = MFMailComposeViewController()
        mail.mailComposeDelegate = self
        mail.setToRecipients(["koala@muxumuxu.com"])
        mail.setSubject(L("contactus.subject"))
        present(mail, animated: true)
    }
    
    private func rateApp() {
        let alert = UIAlertController(title: L("settings.rate"), message: nil, preferredStyle: .alert)
        let yesAction = UIAlertAction(title: L("yes"), style: .default) { action in
            let innerAlert = UIAlertController(title: L("rate.go_appstore"), message: nil, preferredStyle: .alert)
            let yesAction = UIAlertAction(title: L("yes"), style: .default) { action in
                if let url = URL(string: "http://appstore.com/muxumuxu/koala") {
                    UIApplication.shared.open(url, options: [:])
                }
            }
            let noAction = UIAlertAction(title: L("no"), style: .default) { action in
                self.contactUs()
            }
            innerAlert.addAction(noAction)
            innerAlert.addAction(yesAction)
            self.present(innerAlert, animated: true, completion: nil)
        }
        let noAction = UIAlertAction(title: L("no"), style: .cancel) { action in
            self.contactUs()
        }
        alert.addAction(noAction)
        alert.addAction(yesAction)
        present(alert, animated: true, completion: nil)
    }
    
    private func shareApp() {
        var activities: [Any] = [L("share.message")]
        if let link = URL(string: "http://appstore.com/muxumuxu/koala") {
            activities.append(link)
        }
        let activity = UIActivityViewController(activityItems: activities, applicationActivities: nil)
        present(activity, animated: true)
    }
}

extension SettingsVC: MFMailComposeViewControllerDelegate {
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        UINavigationBar.appearance().barTintColor = "131313".UIColor
        UINavigationBar.appearance().isTranslucent = false
        UINavigationBar.appearance().titleTextAttributes = [
            NSFontAttributeName: UIFont.systemFont(ofSize: 17, weight: UIFontWeightSemibold),
            NSForegroundColorAttributeName: UIColor.white
        ]
        controller.dismiss(animated: true)
    }
}
