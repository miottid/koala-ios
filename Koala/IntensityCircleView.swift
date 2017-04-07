//
//  IntensityCircleView.swift
//  Koala
//
//  Created by David Miotti on 07/04/2017.
//  Copyright © 2017 Muxu.Muxu. All rights reserved.
//

import UIKit
import SwiftHelpers

final class IntensityCircleView: SHCommonInitView {
    
    private var circleShapeLayer = CAShapeLayer()
    
    override func commonInit() {
        super.commonInit()
        backgroundColor = .clear
        circleShapeLayer.fillColor = UIColor.koalaGreen.cgColor
        layer.addSublayer(circleShapeLayer)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        circleShapeLayer.frame = bounds
        let path = UIBezierPath(ovalIn: bounds).cgPath
        circleShapeLayer.path = path
    }
}
