//
//  SettingsCell.swift
//  Koala
//
//  Created by David Miotti on 07/04/2017.
//  Copyright © 2017 Muxu.Muxu. All rights reserved.
//

import UIKit
import SwiftHelpers

final class SettingsCell: SHCommonInitTableViewCell {
    let titleLbl = UILabel()
    override func commonInit() {
        super.commonInit()
        
        backgroundColor = "131313".UIColor
        accessoryType = .disclosureIndicator
        
        titleLbl.font = UIFont.systemFont(ofSize: 17)
        titleLbl.textColor = .white
        contentView.addSubview(titleLbl)
        titleLbl.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16))
        }
    }
}
