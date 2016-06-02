//
//  PostCellViewModel.swift
//  CoffeeHipster
//
//  Created by Dan Beaulieu on 5/30/16.
//  Copyright © 2016 Dan Beaulieu. All rights reserved.
//

import Foundation

class PostCellViewModel {
    
    let cellType : CellType
    let content : [String: AnyObject]
    
    init(cellType: CellType, content : [String:AnyObject]) {
        self.cellType = cellType
        self.content = content
    }
}