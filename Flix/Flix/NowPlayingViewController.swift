//
//  NowPlayingViewController.swift
//  Flix
//
//  Created by Rajeev Ram on 7/25/18.
//  Copyright © 2018 Rajeev Ram. All rights reserved.
//

import UIKit

class NowPlayingViewController: UIViewController, UITableViewDataSource {
    
    // UI, UX Variables
    @IBOutlet weak var movieTableView: UITableView!
    
    var movies: [[String: Any]] = []
    
    override func viewDidLoad() {
        // Superclass initializer
        super.viewDidLoad()
        
        movieTableView.dataSource = self as UITableViewDataSource
        movieTableView.rowHeight = 170
        
        // Making a network request
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
            }
        }
        task.resume()
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath) as! MovieCell
        
        let movie = movies[indexPath.row]
        let title = movie["title"] as! String
        let overview = movie["overview"] as! String
        
        cell.titleLabel.text = title
        cell.descriptionLabel.text = overview
        return cell
    }

}
