//
//  InstructionVC.swift
//  Koala
//
//  Created by David Miotti on 09/04/2017.
//  Copyright © 2017 Muxu.Muxu. All rights reserved.
//

import UIKit
import SwiftHelpers

final class InstructionVC: UIViewController {
    
    private var scrollView: UIScrollView!
    private var containerScrollView: UIView!
    private var heroImageView: UIImageView!
    private var lightImageView: UIImageView!
    private var screenImageView: UIImageView!
    private var blurImageView: UIImageView!
    
    private var headlineLbl: UILabel!
    private var instructionContentLbl: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .black

        title = L("instruction.title")

        let closeBtn = UIBarButtonItem(title: L("settings.close"), style: .done, target: self, action: #selector(tappedCloseBtn(_:)))
        navigationItem.rightBarButtonItem = closeBtn
        
        scrollView = UIScrollView()
        containerScrollView = UIView()

        heroImageView = UIImageView(image: #imageLiteral(resourceName: "instructions_illus"))
        blurImageView = UIImageView(image: #imageLiteral(resourceName: "instructions_illus-blur"))
        screenImageView = UIImageView(image: #imageLiteral(resourceName: "instructions_illus-screen"))
        lightImageView = UIImageView(image: #imageLiteral(resourceName: "instructions_illus-light"))

        view.addSubview(scrollView)
        scrollView.addSubview(containerScrollView)
        containerScrollView.addSubview(heroImageView)
        containerScrollView.addSubview(blurImageView)
        containerScrollView.addSubview(screenImageView)
        containerScrollView.addSubview(lightImageView)

        headlineLbl = UILabel()
        headlineLbl.numberOfLines = 0
        configureHeadlineText()
        containerScrollView.addSubview(headlineLbl)

        instructionContentLbl = UILabel()
        instructionContentLbl.numberOfLines = 0
        configureContentText()
        containerScrollView.addSubview(instructionContentLbl)

        configureLayoutConstraints()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        animateImages()
    }

    func tappedCloseBtn(_ sender: UIButton) {
        dismiss(animated: true)
    }
    
    private func configureHeadlineText() {
        let attr = NSMutableAttributedString(string: L("instruction.headline"))
        let range = NSRange(location: 0, length: attr.length)
        attr.addAttribute(NSFontAttributeName, value: UIFont.systemFont(ofSize: 24, weight: UIFontWeightBold), range: range)
        attr.addAttribute(NSForegroundColorAttributeName, value: UIColor.white, range: range)
        let paragraph = NSMutableParagraphStyle()
        paragraph.lineHeightMultiple = 1.2
        attr.addAttribute(NSParagraphStyleAttributeName, value: paragraph, range: range)
        headlineLbl.attributedText = attr
    }
    
    private func configureContentText() {
        let attr = NSMutableAttributedString(string: L("instruction.content"))
        let range = NSRange(location: 0, length: attr.length)
        attr.addAttribute(NSFontAttributeName, value: UIFont.systemFont(ofSize: 16), range: range)
        attr.addAttribute(NSForegroundColorAttributeName, value: UIColor.white, range: range)
        let paragraph = NSMutableParagraphStyle()
        paragraph.lineHeightMultiple = 1.15
        attr.addAttribute(NSParagraphStyleAttributeName, value: paragraph, range: range)
        instructionContentLbl.attributedText = attr
    }
    
    private func animateImages() {
        let blurAnim = CABasicAnimation(keyPath: "opacity")
        blurAnim.duration = 2
        blurAnim.fromValue = 1
        blurAnim.toValue = 0.4
        blurAnim.repeatCount = .infinity
        blurAnim.autoreverses = true
        blurImageView.layer.add(blurAnim, forKey: "blurOpacity")
        
        let lightAnim = CABasicAnimation(keyPath: "opacity")
        lightAnim.duration = 2
        lightAnim.fromValue = 1
        lightAnim.toValue = 0.4
        lightAnim.repeatCount = .infinity
        lightAnim.autoreverses = true
        lightImageView.layer.add(blurAnim, forKey: "lightOpacity")
    }
    
    private func configureLayoutConstraints() {
        scrollView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        containerScrollView.snp.makeConstraints {
            $0.edges.equalTo(scrollView)
            $0.width.equalTo(view)
        }
        heroImageView.snp.makeConstraints {
            $0.left.top.right.equalToSuperview()
            $0.height.equalTo(heroImageView.snp.width).multipliedBy(0.9)
        }
        blurImageView.snp.makeConstraints {
            $0.edges.equalTo(heroImageView)
        }
        screenImageView.snp.makeConstraints {
            $0.edges.equalTo(heroImageView)
        }
        lightImageView.snp.makeConstraints {
            $0.edges.equalTo(heroImageView)
        }
        headlineLbl.snp.makeConstraints {
            $0.top.equalTo(heroImageView.snp.bottom).inset(10)
            $0.left.equalToSuperview().offset(20)
            $0.right.equalToSuperview().inset(20)
        }
        instructionContentLbl.snp.makeConstraints {
            $0.top.equalTo(headlineLbl.snp.bottom).offset(9)
            $0.left.equalToSuperview().offset(20)
            $0.right.equalToSuperview().inset(20)
            $0.bottom.equalToSuperview().inset(20)
        }
    }
}
