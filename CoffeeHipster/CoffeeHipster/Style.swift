//
//  Style.swift
//  Synth
//
//  Created by Dan Beaulieu on 2/13/16.
//  Copyright © 2016 Dan Beaulieu. All rights reserved.
//

import Foundation

struct StyleConfig {
    static let FONT = "Avenir Next Regular"
}


enum Palette {
    case Grey(CGFloat)
    case Black(CGFloat)
    case Red(CGFloat)
    case Blue(CGFloat)
    case White(CGFloat)
}

enum SizeClass : CGFloat {
    case Small = 12
    case Medium = 14
    case Large = 16
    case Ignore = 0
}

enum Property {
    case BackgroundColor
    case TextColor
}

// Fascade Pattern
final class Style<T> {
    private let views = ViewStyle()
    private let buttons = ButtonStyle()
    private let labels = LabelStyle()
    private let switches = SwitchStyle()
    
    class func color(object : T..., color: Palette, type: Property = .TextColor) {
        dispatch_async(BackgroundQueue, {
            for obj in object {
                
                if let button = obj as? UIButton {
                    ButtonStyle.color(button, color: color, property: type)
                    
                    continue
                }
                
                if let barButton = obj as? UIBarButtonItem  {
                    ButtonStyle.color(barButton, color: color, property: type)
                    continue
                }
                
                if let label = obj as? UILabel {
                    LabelStyle.color(label, color: color, property: type)
                    continue
                }
                
                if let lever = obj as? UISwitch {
                    print("lever \(lever)")
                    continue
                }
                
                if let view = obj as? UIView where view.isMemberOfClass(UIView.self) {
                    ViewStyle.color(view, color: color, property: type)
                    continue
                }
            }
        })
    }
}