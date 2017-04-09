//
//  SettingsFooterView.swift
//  Koala
//
//  Created by David Miotti on 09/04/2017.
//  Copyright © 2017 Muxu.Muxu. All rights reserved.
//

import UIKit
import SwiftHelpers

final class SettingsFooterView: SHCommonInitView {
    private var faceImageView = UIImageView(image: #imageLiteral(resourceName: "koala_face"))
    private var madeWithLoveLbl = UILabel()
    private var versionLbl = UILabel()

    override func commonInit() {
        super.commonInit()
        addSubview(faceImageView)
        madeWithLoveLbl.text = L("session.made_with_love")
        madeWithLoveLbl.textColor = .white
        madeWithLoveLbl.textAlignment = .center
        madeWithLoveLbl.font = .systemFont(ofSize: 11)
        addSubview(madeWithLoveLbl)
        versionLbl.text = "v\(appVersion())"
        versionLbl.textAlignment = .center
        versionLbl.textColor = UIColor.white.withAlphaComponent(0.6)
        versionLbl.font = .systemFont(ofSize: 11)
        addSubview(versionLbl)
        configureLayoutConstraints()
    }
    
    private func configureLayoutConstraints() {
        faceImageView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.centerX.equalToSuperview()
        }
        madeWithLoveLbl.snp.makeConstraints {
            $0.top.equalTo(faceImageView.snp.bottom).offset(3)
            $0.left.right.equalToSuperview()
        }
        versionLbl.snp.makeConstraints {
            $0.top.equalTo(madeWithLoveLbl.snp.bottom).offset(5)
            $0.centerX.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
    }
}
