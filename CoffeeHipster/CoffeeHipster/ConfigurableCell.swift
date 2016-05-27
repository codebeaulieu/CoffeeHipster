//
//  ConfigurableCell.swift
//  CoffeeHipster
//
//  Created by Dan Beaulieu on 5/12/16.
//  Credit to Florian Kugler | objc.io
//

protocol ConfigurableCell {
    associatedtype DataSource
    func configureForObject(object: DataSource)
}
