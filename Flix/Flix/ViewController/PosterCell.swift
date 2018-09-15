//
//  PosterCell.swift
//  Flix
//
//  Created by Rajeev Ram on 9/15/18.
//  Copyright © 2018 Rajeev Ram. All rights reserved.
//

import UIKit

class PosterCell: UICollectionViewCell {
    
    @IBOutlet weak var posterImageView: UIImageView!
    
    var movie: Movie! {
        didSet {
            posterImageView.af_setImage(withURL: movie.posterURL!)
        }
    }
    
}
