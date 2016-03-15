//
//  ButtonStyle.swift
//  Synth
//
//  Created by Dan Beaulieu on 2/13/16.
//  Copyright © 2016 Dan Beaulieu. All rights reserved.
// 

import Foundation

final class ButtonStyle {
    class func color(button: UIButton, color: Palette, property: Property) {
        
        let selectedColor = Color.get(color)
        
        dispatch_async(dispatch_get_main_queue(), {
            switch property {
            case .BackgroundColor:
                button.backgroundColor = selectedColor
            case .TextColor:
                button.setTitleColor(selectedColor, forState: .Normal)
            }
        })
    }
    
    class func color(button: UIBarButtonItem, color: Palette, property: Property) {
       
        let selectedColor = Color.get(color)
        
        dispatch_async(dispatch_get_main_queue(), {
            switch property {
            case .BackgroundColor:
                button.tintColor = selectedColor
            case .TextColor:
                let titleDict: [String:AnyObject] = [NSForegroundColorAttributeName: selectedColor]
                button.setTitleTextAttributes(titleDict, forState: .Normal)
            }
        })
    }
    
    class func size(button: UIButton, size: SizeClass) {
        dispatch_async(dispatch_get_main_queue(), {
                button.titleLabel?.font = UIFont(name: StyleConfig.FONT, size: size.rawValue)
        })
    }
}