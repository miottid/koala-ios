//
//  ViewController.swift
//  Koala
//
//  Created by David Miotti on 07/04/2017.
//  Copyright © 2017 Muxu.Muxu. All rights reserved.
//

import UIKit
import SnapKit

final class ViewController: UIViewController {
    
    var intensityCircleView: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()
        intensityCircleView = UIView()
        intensityCircleView.backgroundColor = "50E3C2".UIColor
        view.addSubview(intensityCircleView)
        intensityCircleView.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
            $0.width.height.equalTo(view.snp.width).multipliedBy(0.80)
        }
    }

}

