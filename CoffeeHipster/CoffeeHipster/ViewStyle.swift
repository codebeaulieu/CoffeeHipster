//
//  ViewStyle.swift
//  Synth
//
//  Created by Dan Beaulieu on 2/13/16.
//  Copyright © 2016 Dan Beaulieu. All rights reserved.
//

import Foundation

final class ViewStyle {
    class func color(view: UIView, color: Palette, property: Property) {
   
        let selectedColor = Color.get(color)
        
        dispatch_async(dispatch_get_main_queue(), {
            switch property {
            case .BackgroundColor:
                view.backgroundColor = selectedColor
            case .TextColor:
                print("View does not contain a text property: \(property)")
            }
        })
    }
}