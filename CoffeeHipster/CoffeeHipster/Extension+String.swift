//
//  Extension+String.swift
//  CoffeeHipster
//
//  Created by Dan Beaulieu on 5/27/16.
//  Copyright © 2016 Dan Beaulieu. All rights reserved.
//

import Foundation

extension String {
    func attrStr() -> NSAttributedString {
        return try! NSAttributedString(
            data: self.dataUsingEncoding(NSUnicodeStringEncoding, allowLossyConversion: true)!,
            options: [ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType],
            documentAttributes: nil) 
    }
}