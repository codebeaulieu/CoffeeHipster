//
//  Extension+NSString.swift
//  CoffeeHipster
//
//  Created by Dan Beaulieu on 5/12/16.
//  Copyright © 2016 Dan Beaulieu. All rights reserved.
//

import Foundation

extension SequenceType where Generator.Element == NSString {
    func joinWithSeparator(separator: String) -> String {
        var string = ""
        self.forEach { item in
            string += (item as String) + separator
        }
        return string
    }
    // TODO: Needs some work!
    func joinAndTake(separator: String, take: Int) -> String {
     
        var string = ""
        var count = 0
        self.forEach { item in
            if count <= take {
                string += (item as String) + separator
            }
            count += 1
        }
        return string
    
    }

}