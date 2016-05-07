//
//  REST.swift
//  CoffeeHipster
//
//  Created by Dan Beaulieu on 4/23/16.
//  Copyright © 2016 Dan Beaulieu. All rights reserved.
//

import Foundation

enum Operation {
    case Post
    case Put
    case Delete
    case GetUsers(Int)
    case GetPosts(Int)
}
