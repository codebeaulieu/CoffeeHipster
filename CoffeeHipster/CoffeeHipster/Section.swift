//
//  PostSection.swift
//  CoffeeHipster
//
//  Created by Dan Beaulieu on 3/15/16.
//  Copyright © 2016 Dan Beaulieu. All rights reserved.
//

import Foundation

struct Section<T> {
    let header : String
    let items : [T]
    
    init(_ title: String, objects: [T]) {
        header = title
        items = objects
    }
}