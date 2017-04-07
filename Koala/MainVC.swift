//
//  ViewController.swift
//  Koala
//
//  Created by David Miotti on 07/04/2017.
//  Copyright © 2017 Muxu.Muxu. All rights reserved.
//

import UIKit
import SnapKit
import SwiftHelpers

final class MainVC: UIViewController {
    
    private var titleLbl: UILabel!
    private var intensityCircleView: IntensityCircleView!
    private var settingsBtn: UIButton!
    private var helpBtn: UIButton!
    
    private var startBtn: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        titleLbl = UILabel()
        titleLbl.textColor = .white
        titleLbl.font = .koalaFont(ofSize: 20, weight: UIFontWeightSemibold)
        titleLbl.text = "Koala"
        view.addSubview(titleLbl)
        intensityCircleView = IntensityCircleView()
        view.addSubview(intensityCircleView)
        settingsBtn = UIButton(type: .system)
        settingsBtn.setTitle(L("settings"), for: .normal)
        settingsBtn.setTitleColor(.white, for: .normal)
        settingsBtn.titleLabel?.font = .systemFont(ofSize: 16)
        settingsBtn.addTarget(self, action: #selector(tappedSettingsBtn(_:)), for: .touchUpInside)
        view.addSubview(settingsBtn)
        helpBtn = UIButton(type: .system)
        helpBtn.setTitle(L("help"), for: .normal)
        helpBtn.setTitleColor(.white, for: .normal)
        helpBtn.titleLabel?.font = .systemFont(ofSize: 16)
        helpBtn.addTarget(self, action: #selector(tappedHelpBtn(_:)), for: .touchUpInside)
        view.addSubview(helpBtn)
        startBtn = UIButton(type: .system)
        startBtn.setTitle(L("session.start"), for: .normal)
        startBtn.setTitleColor(.white, for: .normal)
        startBtn.titleLabel?.font = .systemFont(ofSize: 22)
        startBtn.addTarget(self, action: #selector(tappedStartBtn(_:)), for: .touchUpInside)
        view.addSubview(startBtn)
        configureLayoutConstraints()
    }
    
    func tappedSettingsBtn(_ sender: UIButton) {
        let settingsVC = SettingsVC()
        let nav = UINavigationController(rootViewController: settingsVC)
        present(nav, animated: true)
    }
    
    func tappedHelpBtn(_ sender: UIButton) {
        
    }
    
    func tappedStartBtn(_ sender: UIButton) {
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    private func configureLayoutConstraints() {
        titleLbl.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(33)
        }
        settingsBtn.snp.makeConstraints {
            $0.centerY.equalTo(titleLbl)
            $0.left.equalToSuperview().offset(30)
        }
        helpBtn.snp.makeConstraints {
            $0.centerY.equalTo(titleLbl)
            $0.right.equalToSuperview().inset(30)
        }
        startBtn.snp.makeConstraints {
            $0.edges.equalTo(intensityCircleView)
        }
        intensityCircleView.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
            $0.width.height.equalTo(view.snp.width).multipliedBy(0.80)
        }
    }
}

