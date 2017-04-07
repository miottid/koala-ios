//
//  StyleSheet.swift
//  Koala
//
//  Created by David Miotti on 07/04/2017.
//  Copyright © 2017 Muxu.Muxu. All rights reserved.
//

import UIKit
import SwiftHelpers

extension UIColor {
    static var koalaGreen: UIColor {
        return "50E3C2".UIColor
    }
}

extension UIFont {
    class func koalaFont(ofSize size: CGFloat, weight: CGFloat) -> UIFont? {
        switch weight {
        case UIFontWeightRegular:
            return UIFont(name: "Poppins-Regular", size: size)
        case UIFontWeightBold:
            return UIFont(name: "Poppins-Bold", size: size)
        case UIFontWeightSemibold:
            return UIFont(name: "Poppins-SemiBold", size: size)
        case UIFontWeightLight:
            return UIFont(name: "Poppins-Light", size: size)
        case UIFontWeightMedium:
            return UIFont(name: "Poppins-Medium", size: size)
        default:
            return nil
        }
    }
}
