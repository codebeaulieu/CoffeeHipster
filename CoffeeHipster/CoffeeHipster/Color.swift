//
//  Color.swift
//  Synth
//
//  Created by Dan Beaulieu on 2/13/16.
//  Copyright © 2016 Dan Beaulieu. All rights reserved.
//

import Foundation

final class Color {
    class func get(color: Palette) -> UIColor {
        switch color {
        case .Black(let alpha):
            return UIColor(red: 0.0/255, green: 0.0/255, blue: 0.0/255, alpha: alpha)
        case .Blue(let alpha):
            return UIColor(red: 50.0/255, green: 50.0/255, blue: 50.0/255, alpha: alpha)
        case .Grey(let alpha):
            return UIColor(red: 50.0/255, green: 50.0/255, blue: 50.0/255, alpha: alpha)
        case .White(let alpha):
            return UIColor(red: 255.0/255, green: 255.0/255, blue: 255.0/255, alpha: alpha)
        case .Red(let alpha):
            return UIColor(red: 227.0/255, green: 9.0/255, blue: 9.0/255, alpha: alpha)
        }
    }
}