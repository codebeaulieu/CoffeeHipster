//
//  TitleTableViewCell.swift
//  CoffeeHipster
//
//  Created by Dan Beaulieu on 5/30/16.
//  Copyright © 2016 Dan Beaulieu. All rights reserved.
//

import UIKit


class TitleTableViewCell: UITableViewCell { 
    
    enum SegueIdentifier : String {
        case none = ""
    }
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var voteCount: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
