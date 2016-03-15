//
//  PostTableViewCell.swift
//  CoffeeHipster
//
//  Created by Dan Beaulieu on 3/15/16.
//  Copyright © 2016 Dan Beaulieu. All rights reserved.
//

import UIKit

class PostTableViewCell: UITableViewCell {

    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var askedOnLabel: UILabel!
    @IBOutlet weak var votesLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        Style.color(titleLabel, votesLabel, askedOnLabel, color: .White(1))
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
