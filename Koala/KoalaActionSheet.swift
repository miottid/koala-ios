//
//  KoalaActionSheet.swift
//  Koala
//
//  Created by David Miotti on 08/04/2017.
//  Copyright © 2017 Muxu.Muxu. All rights reserved.
//

import UIKit
import SwiftHelpers

final class KoalaActionSheet: SHCommonInitView {
    
    var leftBtnTitle: String? {
        didSet {
            leftBtn.setTitle(leftBtnTitle, for: .normal)
        }
    }
    var rightBtnTitle: String? {
        didSet {
            rightBtn.setTitle(rightBtnTitle, for: .normal)
        }
    }
    var title: String? {
        didSet {
            titleLbl.text = title
        }
    }
    
    var leftBtnBlock: ((Void) -> Void)?
    var rightBtnBlock: ((Void) -> Void)?

    private var titleLbl = UILabel()
    private var leftBtn = UIButton(type: .system)
    private var rightBtn = UIButton(type: .system)
    private var btnStackView = UIStackView()
    
    override func commonInit() {
        super.commonInit()
        titleLbl.textColor = .white
        titleLbl.font = .systemFont(ofSize: 17)
        titleLbl.numberOfLines = 0
        titleLbl.textAlignment = .center
        addSubview(titleLbl)
        [leftBtn, rightBtn].forEach {
            $0.setTitleColor(.white, for: .normal)
            $0.titleLabel?.font = .systemFont(ofSize: 22)
            $0.layer.borderColor = UIColor.white.cgColor
            $0.layer.borderWidth = 1
            $0.layer.cornerRadius = 29
        }
        leftBtn.addTarget(self, action: #selector(tappedLeftBtn(_:)), for: .touchUpInside)
        rightBtn.addTarget(self, action: #selector(tappedRightBtn(_:)), for: .touchUpInside)
        btnStackView.axis = .horizontal
        btnStackView.distribution = .fillEqually
        btnStackView.addArrangedSubview(leftBtn)
        btnStackView.addArrangedSubview(rightBtn)
        btnStackView.spacing = 17
        addSubview(btnStackView)
        titleLbl.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.left.right.equalToSuperview()
        }
        btnStackView.snp.makeConstraints {
            $0.top.equalTo(titleLbl.snp.bottom).offset(20)
            $0.left.right.bottom.equalToSuperview()
            $0.height.equalTo(58)
        }
    }
    
    func tappedLeftBtn(_ sender: UIButton) {
        leftBtnBlock?()
    }
    
    func tappedRightBtn(_ sender: UIButton) {
        rightBtnBlock?()
    }
}
