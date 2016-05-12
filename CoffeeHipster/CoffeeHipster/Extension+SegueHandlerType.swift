//
//  Extension+SegueHandlerType.swift
//  CoffeeHipster
//
//  Created by Dan Beaulieu on 5/11/16.
//  Copyright © 2016 Dan Beaulieu. All rights reserved.
//

import Foundation

extension SegueHandlerType where Self: UIViewController, SegueIdentifier.RawValue == String {
    public func segueIdenfifierForSegue(segue: UIStoryboardSegue) -> SegueIdentifier {
        guard let identifier = segue.identifier,
            let segueIdentifier = SegueIdentifier(rawValue: identifier)
            else { fatalError("Unknown Segue: \(segue)") }
        return segueIdentifier
    }
    
    public func performSegue(identifier: SegueIdentifier) {
        performSegueWithIdentifier(identifier.rawValue, sender: nil)
    }
    
}