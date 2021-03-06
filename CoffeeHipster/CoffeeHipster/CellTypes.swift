//
//  CellTypes.swift
//  CoffeeHipster
//
//  Created by Dan Beaulieu on 5/30/16.
//  Copyright © 2016 Dan Beaulieu. All rights reserved.
//

import Foundation

// the associated type represents the cells tag
enum CellType {
    case Title
    case Question(PostSort) 
    case Answer(PostSort)
}

enum PostSort {
    case Body
    case Comment
    case Author
}