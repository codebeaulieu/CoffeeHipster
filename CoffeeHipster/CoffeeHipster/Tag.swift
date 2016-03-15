//
//  Tag.swift
//  CoffeeHipster
//
//  Created by Dan Beaulieu on 3/15/16.
//  Copyright © 2016 Dan Beaulieu. All rights reserved.
//

import Foundation

struct Tag {
    var tag :  String
    
    init?(_ json: AnyObject) {
        guard let json = json as? String else { return nil }
        tag = json
    }
}