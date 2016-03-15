//
//  LabelStyle.swift
//  Synth
//
//  Created by Dan Beaulieu on 2/13/16.
//  Copyright © 2016 Dan Beaulieu. All rights reserved.
//

import Foundation

final class LabelStyle {
    class func color(label: UILabel, color: Palette, property: Property) {
 
        let selectedColor = Color.get(color)
        
        dispatch_async(dispatch_get_main_queue(), {
            switch property {
            case .BackgroundColor:
                label.backgroundColor = selectedColor
            case .TextColor:
                label.textColor = selectedColor
            }
        })
    }
    
    class func size(label: UILabel, size: SizeClass) {
        dispatch_async(dispatch_get_main_queue(), {
            label.font = UIFont(name: StyleConfig.FONT, size: size.rawValue)
        })
    }
}