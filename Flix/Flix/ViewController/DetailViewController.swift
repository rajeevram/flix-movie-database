//
//  DetailViewController.swift
//  Flix
//
//  Created by Rajeev Ram on 7/27/18.
//  Copyright © 2018 Rajeev Ram. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    // UI, UX Variables
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var backdropImageView: UIImageView!
    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    var movie: Movie?
    
    override func viewDidLoad() {
        // Superclass initializer
        super.viewDidLoad()
        
        // Set view parameters for particular movie
        if let movie = movie {
            // The labels
            movieTitleLabel.text = movie.title as String
            releaseDateLabel.text = movie.releaseDate as String
            descriptionLabel.text = movie.overview as String
            // The images
            backdropImageView.af_setImage(withURL: movie.backdropURL!)
            posterImageView.af_setImage(withURL: movie.posterURL!)
        }
        
    }

    // Superclass Methods
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}
