//
//  Extension+UIWebView.swift
//  CoffeeHipster
//
//  Created by Dan Beaulieu on 5/30/16.
//  Copyright © 2016 Dan Beaulieu. All rights reserved.
//

import Foundation

extension UIWebView {
    struct PositionValue {
        static var pos = 0.0
    }
    
    var position : Double {
        get { 
            return PositionValue.pos
        }
        
        set(newValue) {
            PositionValue.pos = newValue
        }
    }
}