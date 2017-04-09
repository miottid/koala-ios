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

final class MainVC: UIViewController, CAAnimationDelegate {
    
    private var titleLbl: UILabel!
    private var intensityCircleView: IntensityCircleView!
    private var settingsBtn: UIButton!
    private var helpBtn: UIButton!
    
    private var startBtn: UIButton!
    
    private var hasStarted = false
    private var previousBrightness: CGFloat?
    
    private var colorPickerImageView: UIImageView!
    private var colorPickerSlider: UISlider!
    
    private var actionSheetDimmingBtn: UIButton!
    private var actionSheet: KoalaActionSheet!
    
    private var sessionDimmingBtn: UIButton!
    private var choosenTime: TimeInterval = 8 * 60
    private var elapsedTime: TimeInterval = 0

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
        colorPickerSlider = UISlider()
        let emptyImasge = UIImage()
        colorPickerSlider.setMaximumTrackImage(emptyImasge, for: .normal)
        colorPickerSlider.setMinimumTrackImage(emptyImasge, for: .normal)
        view.addSubview(colorPickerSlider)
        colorPickerSlider.setThumbImage(#imageLiteral(resourceName: "progress_thumb"), for: .normal)
        colorPickerSlider.addTarget(self, action: #selector(sliderDidChange(_:)), for: .valueChanged)
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tappedSlider(_:)))
        colorPickerSlider.addGestureRecognizer(tapGesture)
        actionSheetDimmingBtn = UIButton(type: .system)
        actionSheetDimmingBtn.backgroundColor = UIColor.black.withAlphaComponent(0.4)
        actionSheetDimmingBtn.alpha = 0
        actionSheetDimmingBtn.addTarget(self, action: #selector(tappedActionSheetDismissBtn(_:)), for: .touchUpInside)
        view.addSubview(actionSheetDimmingBtn)
        actionSheet = KoalaActionSheet()
        view.addSubview(actionSheet)
        sessionDimmingBtn = UIButton(type: .system)
        sessionDimmingBtn.isUserInteractionEnabled = false
        sessionDimmingBtn.addTarget(self, action: #selector(tappedSessionDimmingBtn(_:)), for: .touchUpInside)
        view.addSubview(sessionDimmingBtn)
        configureLayoutConstraints()
        
        colorPickerSlider.value = 0.463768
    }
    
    func tappedSettingsBtn(_ sender: UIButton) {
        let settingsVC = SettingsVC()
        let nav = LightNC(rootViewController: settingsVC)
        present(nav, animated: true)
    }
    
    func tappedHelpBtn(_ sender: UIButton) {
        let nav = LightNC(rootViewController: InstructionVC())
        present(nav, animated: true)
    }
    
    func tappedStartBtn(_ sender: UIButton) {
        sessionDimmingBtn.isUserInteractionEnabled = false
        
        if !hasStarted {
            hasStarted = true
            
            UIApplication.shared.isIdleTimerDisabled = false
            
            titleLbl.snp.updateConstraints {
                $0.top.equalToSuperview().inset(-100)
            }
            
            colorPickerImageView.snp.updateConstraints {
                $0.bottom.equalToSuperview().offset(100)
            }
            
            actionSheet.title = L("session.type.title")
            actionSheet.leftBtnTitle = L("session.type.eight_mins")
            actionSheet.rightBtnTitle = L("session.type.twenty_mins")
            actionSheet.timeSelectedBlock = startSession(_:)
            actionSheet.snp.updateConstraints {
                $0.bottom.equalToSuperview().inset(20)
            }
            
            animatePulse()
            
            UIView.animate(withDuration: 0.35) {
                self.startBtn.alpha = 1
                self.actionSheetDimmingBtn.alpha = 1
                self.view.layoutIfNeeded()
            }
            
            startBtn.setTitle(nil, for: .normal)
        } else {
            hasStarted = false
            
            if let prev = previousBrightness {
                UIApplication.shared.isIdleTimerDisabled = true
                UIScreen.main.brightness = prev
                previousBrightness = nil
            }
            
            titleLbl.snp.updateConstraints {
                $0.top.equalToSuperview().offset(24)
            }
            
            colorPickerImageView.snp.updateConstraints {
                $0.bottom.equalToSuperview().inset(7)
            }
            
            actionSheet.snp.updateConstraints {
                $0.bottom.equalToSuperview().offset(150)
            }
            
            intensityCircleView.layer.removeAllAnimations()
            
            UIView.animate(withDuration: 0.35) {
                self.startBtn.alpha = 1
                self.intensityCircleView.transform = .identity
                self.actionSheetDimmingBtn.alpha = 0
                self.intensityCircleView.alpha = 1
                self.actionSheet.layoutIfNeeded()
                self.view.layoutIfNeeded()
            }
            
            startBtn.setTitle(L("session.start"), for: .normal)
        }
    }
    
    func tappedActionSheetDismissBtn(_ sender: UIButton) {
        tappedStartBtn(startBtn)
    }
    
    func tappedSessionDimmingBtn(_ sender: UIButton) {
        tappedStartBtn(startBtn)
    }
    
    func sliderDidChange(_ slider: UISlider) {
        updateColor(for: slider.value.toCGFloat)
    }
    
    func tappedSlider(_ sender: UITapGestureRecognizer) {
        guard let slider = sender.view as? UISlider, !slider.isHighlighted else {
            return
        }
        
        let pt = sender.location(in: slider)
        let percentage = pt.x / slider.bounds.width
        let delta = Float(percentage) * slider.maximumValue - slider.minimumValue
        let value = slider.minimumValue + delta
        slider.setValue(value, animated: true)
        updateColor(for: value.toCGFloat)
    }
    
    private func animatePulse() {
        UIView.animate(withDuration: 0.35, animations: { 
            self.intensityCircleView.transform = CGAffineTransform(scaleX: 0.7, y: 0.7)
        }) { finished in
            let scaleAnimation: CABasicAnimation = CABasicAnimation(keyPath: "transform.scale")
            scaleAnimation.duration = 1.5
            scaleAnimation.repeatCount = 100
            scaleAnimation.autoreverses = true
            scaleAnimation.fromValue = 0.7;
            scaleAnimation.toValue = 0.6;
            self.intensityCircleView.layer.add(scaleAnimation, forKey: "scale")
        }
    }
    
    private func startSession(_ minute: Int) {
        choosenTime = TimeInterval(minute) * 60
        previousBrightness = UIScreen.main.brightness
        UIScreen.main.brightness = 1
        
        sessionDimmingBtn.isUserInteractionEnabled = true
        
        actionSheet.snp.updateConstraints {
            $0.bottom.equalToSuperview().offset(150)
        }
        
        intensityCircleView.layer.removeAllAnimations()
        
        UIView.animate(withDuration: 1.0, animations: {
            self.actionSheetDimmingBtn.alpha = 0
            self.intensityCircleView.alpha = 0.2
            self.intensityCircleView.transform = CGAffineTransform(scaleX: 0.3, y: 0.3)
            self.startBtn.alpha = 0
        }, completion: { finished in
            self.launchCycle(seconds: 5)
        })
    }
    
    fileprivate func launchCycle(seconds: TimeInterval) {
        let breathIn = seconds * 0.40
        let breathOut = seconds - breathIn
        
        let inspirationAnim = CABasicAnimation(keyPath: "transform.scale")
        inspirationAnim.duration = breathIn
        inspirationAnim.fromValue = 0.3
        inspirationAnim.toValue = 1
        inspirationAnim.beginTime = 0
        inspirationAnim.isRemovedOnCompletion = false
        
        let fadeInAnim = CABasicAnimation(keyPath: "opacity")
        fadeInAnim.duration = breathIn
        fadeInAnim.fromValue = 0.2
        fadeInAnim.toValue = 1
        fadeInAnim.beginTime = 0
        fadeInAnim.isRemovedOnCompletion = false
        
        let expirationAnim = CABasicAnimation(keyPath: "transform.scale")
        expirationAnim.duration = breathOut
        expirationAnim.fromValue = 1
        expirationAnim.toValue = 0.3
        expirationAnim.beginTime = CFTimeInterval(breathIn)
        expirationAnim.isRemovedOnCompletion = false
        
        let fadeOutAnim = CABasicAnimation(keyPath: "opacity")
        fadeOutAnim.duration = breathOut
        fadeOutAnim.fromValue = 1
        fadeOutAnim.toValue = 0.2
        fadeOutAnim.beginTime = CFTimeInterval(breathIn)
        fadeOutAnim.isRemovedOnCompletion = false
        
        let group = CAAnimationGroup()
        group.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
        group.duration = seconds
        group.animations = [inspirationAnim, expirationAnim, fadeInAnim, fadeOutAnim]
        group.delegate = self
        intensityCircleView.layer.add(group, forKey: "breathes")
        
        elapsedTime += seconds
    }
    
    private func stopSession() {
        tappedStartBtn(startBtn)
    }
    
    private func updateColor(for progress: CGFloat) {
        let p = min(progress, 0.97)
        let point = CGPoint(x: colorPickerImageView.bounds.width * p,
                            y: colorPickerImageView.bounds.height / 2.0)
        let color = colorPickerImageView.pickColor(at: point)
        intensityCircleView.color = color
    }
    
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        /// Here calculate the next cycle or stop it
        if elapsedTime < choosenTime {
            let percent = elapsedTime / choosenTime
            let cycleLength: TimeInterval
            if percent < 0.25 {
                cycleLength = 5
            } else if percent < 0.50 {
                cycleLength = 8
            } else if percent < 0.75 {
                cycleLength = 11
            } else {
                cycleLength = 14
            }
            self.launchCycle(seconds: cycleLength)
        } else {
            elapsedTime = .infinity
        }
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
        actionSheetDimmingBtn.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        actionSheet.snp.makeConstraints {
            $0.left.equalToSuperview().offset(20)
            $0.right.equalToSuperview().inset(20)
            $0.bottom.equalToSuperview().offset(150)
        }
        colorPickerImageView.snp.makeConstraints {
            $0.left.equalToSuperview().offset(10)
            $0.right.equalToSuperview().inset(10)
            $0.height.equalTo(34)
            $0.bottom.equalToSuperview().inset(12)
        }
        colorPickerSlider.snp.makeConstraints {
            $0.left.equalTo(colorPickerImageView)
            $0.right.equalTo(colorPickerImageView)
            $0.centerY.equalTo(colorPickerImageView)
            $0.height.equalTo(40)
        }
        sessionDimmingBtn.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
