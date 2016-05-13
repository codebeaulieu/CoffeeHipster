//
//  Extension+NSDate.swift
//  CoffeeHipster
//
//  Created by Dan Beaulieu on 5/12/16.
//  Copyright © 2016 Dan Beaulieu. All rights reserved.
//

import Foundation

extension NSDate {
    public convenience init?(jsonDate: String) {
        
        let prefix = "/Date("
        let suffix = ")/"
        // Check for correct format:
        if jsonDate.hasPrefix(prefix) && jsonDate.hasSuffix(suffix) {
            // Extract the number as a string:
            let from = jsonDate.startIndex.advancedBy(prefix.characters.count)
            let to = jsonDate.endIndex.advancedBy(-suffix.characters.count)
            // Convert milleseconds to double
            guard let milliSeconds = Double(jsonDate[from ..< to]) else {
                return nil
            }
            // Create NSDate with this UNIX timestamp
            self.init(timeIntervalSince1970: milliSeconds/1000.0)
        } else {
            return nil
        }
    }
}

extension NSDate {
    func readable() -> String {
        let formatter = NSDateFormatter()
        formatter.dateStyle = NSDateFormatterStyle.LongStyle
        formatter.timeStyle = .MediumStyle
        return formatter.stringFromDate(self)
    }
}
