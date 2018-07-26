//
//  NowPlayingViewController.swift
//  Flix
//
//  Created by Rajeev Ram on 7/25/18.
//  Copyright © 2018 Rajeev Ram. All rights reserved.
//

import UIKit
import AlamofireImage

class NowPlayingViewController: UIViewController, UITableViewDataSource {
    
    // UI, UX Variables
    @IBOutlet weak var movieTableView: UITableView!
    
    // Backend Variables
    var movies: [[String: Any]] = []
    var refreshControl: UIRefreshControl!
    
    override func viewDidLoad() {
        // Superclass initializer
        super.viewDidLoad()
        
        // Setup pull-to-refresh functionality
        refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(NowPlayingViewController.pullToRefresh(_:)), for: .valueChanged)
        movieTableView.insertSubview(refreshControl, at: 0)
        
        // Properly source and align table view
        movieTableView.dataSource = self as UITableViewDataSource
        movieTableView.rowHeight = 170
        
        // Make a network request
        getNowPlayingMovies()
    }
    
    // Make a network request to fetch movies
    func getNowPlayingMovies() {
        let url = URL(string: "https://api.themoviedb.org/3/movie/now_playing?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed&language=en-US")!
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: .main)
        let task = session.dataTask(with: request) { (data, respond, error) in
            // This will run when the network request returns
            if let error = error {
                print(error.localizedDescription)
            }
            else if let data = data {
                let dictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                self.movies = dictionary["results"] as! [[String: Any]]
                self.movieTableView.reloadData()
                self.refreshControl.endRefreshing()
            }
        }
        task.resume()
    }
    
    // Resend the network request upon pull
    @objc func pullToRefresh(_ refreshControl: UIRefreshControl) {
        getNowPlayingMovies()
    }
    
    // Superclass methods
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // Protocol methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Retrieve JSON information
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath) as! MovieCell
        let movie = movies[indexPath.row]
        
        // Title and description of movie
        let title = movie["title"] as! String
        let overview = movie["overview"] as! String
        cell.titleLabel.text = title
        cell.descriptionLabel.text = overview
        
        // Poster image with AlamoFire
        let poster = movie["poster_path"] as! String
        let baseURL = "https://image.tmdb.org/t/p/w500"
        let posterURL = URL(string: baseURL + poster)!
        cell.posterImageView.af_setImage(withURL: posterURL)
        
        return cell
    }

}
