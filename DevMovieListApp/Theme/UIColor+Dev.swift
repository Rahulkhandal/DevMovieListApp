//
//  UIColor+Dev.swift
//  DevMovieListApp
//
//  Created by Rahul on 16/06/24.
//

import Foundation
import UIKit

extension UIColor {
    
    static func ambience(_ step: Int) -> UIColor! {
        return UIColor(hue: 250, saturation: 0.10, brightness: lightLightnessFromStep(step), alpha: 1.0)
    }
    
    private static func lightLightnessFromStep(_ step: Int) -> CGFloat {
        return CGFloat((4 + (4 * CGFloat(step)))/100)
    }
}
