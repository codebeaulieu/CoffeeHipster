//
//  DataSourceDelegate.swift
//  CoffeeHipster
//
//  Created by Dan Beaulieu on 5/12/16.
//  Credit to Florian Kugler | objc.io
//

import Foundation

protocol DataSourceDelegate: class {
    associatedtype Object
    func cellIdentifierForObject(object: Object) -> String
}

