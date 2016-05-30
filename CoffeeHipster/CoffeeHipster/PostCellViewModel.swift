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
    let content : [String: String]
    
    init(cellType: CellType, content : [String:String]) {
        self.cellType = cellType
        self.content = content
    }
}