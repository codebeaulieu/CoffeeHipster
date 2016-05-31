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
        static var height = 0.0
    }
    
    var position : Double {
        get {
            print("get : \(PositionValue.height)")
            return PositionValue.height
        }
        
        set(newValue) {
            
            PositionValue.height = newValue
            print("set : \(PositionValue.height)")
        }
    }
    }