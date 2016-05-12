//
//  Extension+UITableViewCell.swift
//  CoffeeHipster
//
//  Created by Dan Beaulieu on 5/11/16.
//  Copyright © 2016 Dan Beaulieu. All rights reserved.
//

import Foundation

extension UITableViewCell {
    func removeMargins() {
        if self.respondsToSelector(Selector("setSeparatorInset:")) {
            self.separatorInset = UIEdgeInsetsZero
        }
        if self.respondsToSelector(Selector("setPreservesSuperviewLayoutMargins:")) {
            self.preservesSuperviewLayoutMargins = false
        }
        if self.respondsToSelector(Selector("setLayoutMargins:")) {
            self.layoutMargins = UIEdgeInsetsZero
        }
    }
}