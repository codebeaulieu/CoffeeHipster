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
    @IBOutlet weak var tagsLabel: UILabel!
    @IBOutlet weak var votesLabel: UILabel!
    @IBOutlet weak var answersLabel: UILabel! 
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code

    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

extension PostTableViewCell: ConfigurableCell {
    func configureForObject(post: Post) {
        titleLabel.text = post.title
        tagsLabel.text = post.tags.joinAndTake("  ", take: 2)
        votesLabel.text = "\(post.score)"
        answersLabel.text = (post.answerCount == 0) ? "" : "\(post.answerCount)"
    }
}



