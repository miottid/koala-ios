//
//  SettingsVC.swift
//  Koala
//
//  Created by David Miotti on 07/04/2017.
//  Copyright © 2017 Muxu.Muxu. All rights reserved.
//

import UIKit
import SwiftHelpers

final class SettingsVC: UIViewController {
    
    private var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = L("settings")

        view.backgroundColor = .white
        
        let closeBtn = UIBarButtonItem(title: L("settings.close"), style: .plain, target: self, action: #selector(tappedCloseBtn(_:)))
        navigationItem.rightBarButtonItem = closeBtn
        
        tableView = UITableView(frame: .zero, style: .grouped)
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

}
