//
//  MovieCell.swift
//  Flix
//
//  Created by Rajeev Ram on 7/25/18.
//  Copyright © 2018 Rajeev Ram. All rights reserved.
//

import UIKit

class MovieCell: UITableViewCell {

    // UI, UX Variables
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var posterImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
