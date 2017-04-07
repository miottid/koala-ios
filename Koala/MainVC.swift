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
    
    private var hasStarted = false
    private var previousBrightness: CGFloat?
    
    private var colorPickerImageView: UIImageView!
    private var colorPickerSlider: UISlider!

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        titleLbl = UILabel()
        titleLbl.textColor = .white
        titleLbl.font = .koalaFont(ofSize: 20, weight: UIFontWeightSemibold)
        titleLbl.text = "koala"
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
        colorPickerImageView = UIImageView(image: #imageLiteral(resourceName: "color_picker"))
        view.addSubview(colorPickerImageView)
        colorPickerImageView.snp.makeConstraints {
            $0.left.equalToSuperview().offset(10)
            $0.right.equalToSuperview().inset(10)
            $0.height.equalTo(40)
            $0.bottom.equalToSuperview().inset(7)
        }
        colorPickerSlider = UISlider()
        let emptyImasge = UIImage()
        colorPickerSlider.setMaximumTrackImage(emptyImasge, for: .normal)
        colorPickerSlider.setMinimumTrackImage(emptyImasge, for: .normal)
        view.addSubview(colorPickerSlider)
        colorPickerSlider.snp.makeConstraints {
            $0.edges.equalTo(colorPickerImageView)
        }
        colorPickerSlider.setThumbImage(#imageLiteral(resourceName: "progress_thumb"), for: .normal)
        colorPickerSlider.addTarget(self, action: #selector(sliderDidChange(_:)), for: .valueChanged)
        configureLayoutConstraints()
        
        colorPickerSlider.value = 0.463768
    }
    
    func tappedSettingsBtn(_ sender: UIButton) {
        let settingsVC = SettingsVC()
        let nav = SettingsNC(rootViewController: settingsVC)
        present(nav, animated: true)
    }
    
    func tappedHelpBtn(_ sender: UIButton) {
        
    }
    
    func tappedStartBtn(_ sender: UIButton) {
        if !hasStarted {
            hasStarted = true
            
            previousBrightness = UIScreen.main.brightness
            UIScreen.main.brightness = 1
            
            titleLbl.snp.updateConstraints {
                $0.top.equalToSuperview().inset(-100)
            }
            
            colorPickerImageView.snp.updateConstraints {
                $0.bottom.equalToSuperview().offset(100)
            }
            
            UIView.animate(withDuration: 0.35) {
                self.view.layoutIfNeeded()
            }
            
            startBtn.setTitle(L("session.stop"), for: .normal)
        } else {
            hasStarted = false
            
            if let prev = previousBrightness {
                UIScreen.main.brightness = prev
                previousBrightness = nil
            }
            
            titleLbl.snp.updateConstraints {
                $0.top.equalToSuperview().offset(24)
            }
            
            colorPickerImageView.snp.updateConstraints {
                $0.bottom.equalToSuperview().inset(7)
            }
            
            UIView.animate(withDuration: 0.35) {
                self.view.layoutIfNeeded()
            }
            
            startBtn.setTitle(L("session.start"), for: .normal)
        }
    }
    
    func sliderDidChange(_ slider: UISlider) {
        updateColor(for: slider.value.toCGFloat)
    }
    
    private func updateColor(for progress: CGFloat) {
        let point = CGPoint(x: colorPickerImageView.bounds.width * progress,
                            y: colorPickerImageView.bounds.height / 2.0)
        let color = colorPickerImageView.pickColor(at: point)
        intensityCircleView.color = color
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
            $0.top.equalToSuperview().offset(24)
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
            $0.width.height.equalTo(view.snp.width).multipliedBy(0.70)
        }
    }
}

