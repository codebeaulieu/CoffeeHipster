//
//  Extension+Double.swift
//  CoffeeHipster
//
//  Created by Dan Beaulieu on 5/30/16.
//  Copyright © 2016 Dan Beaulieu. All rights reserved.
//

import Foundation

// used for table view stuff
extension Double {
    func getSection() -> Int {
        return Int(self)
    }
    func getRow() -> Int {
        
        let numberOfPlaces:Double = 4.0
        let powerOfTen:Double = pow(10.0, numberOfPlaces)
        let targetedDecimalPlaces:Double = round((self % 1.0) * powerOfTen) / powerOfTen
        return Int(targetedDecimalPlaces * 10)
    }
}