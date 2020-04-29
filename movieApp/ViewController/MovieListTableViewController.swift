//
//  MovieListTableViewController.swift
//  movieApp
//
//  Created by Adina Kenzhebekova on 4/27/20.
//  Copyright © 2020 Adina Kenzhebekova. All rights reserved.
//

import UIKit
import SDWebImage

class MovieListTableViewController: UITableViewController {
    
    var moviesList: [Movie] = []
    var movieProvider: MovieProvider?
    let imageAdress = "https://image.tmdb.org/t/p/w1280/"
    var page: Int = 1
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        NotificationCenter.default.addObserver(self ,
                                               selector: #selector(onResponseMoviesList),
                                               name: .responseMoviesListNotification,
                                               object: nil)
        
        self.title = "Movies"
    }
    
    @objc func onResponseMoviesList(notification: Notification) {
        let response = notification.object as! ResponseMoviesListNotification
        page = response.page
        moviesList.append(contentsOf: response.movies)
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getMovies(page: page)
    }
    
    func getMovies(page: Int = 1) {
        let request = RequestMoviesListNotification(page: page)
        NotificationCenter.default.post(name: .requestMoviesListNotification, object: request)
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return moviesList.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 500.0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "movieCell", for: indexPath) as! MovieCell
        
        let movie = moviesList[indexPath.row]
        cell.movieTitle.text = movie.title
        cell.movieDate.text = movie.release_date
        if movie.poster_path != nil {
            let imageUrl = "\(imageAdress)\(movie.poster_path!)"
            cell.movieImage.sd_setImage(with: URL(string:imageUrl), placeholderImage:nil)
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == moviesList.count - 1 {
            getMovies(page: page + 1)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? MovieDetailViewController,
            let cell = sender as? MovieCell,
            let indexPath = tableView.indexPath(for: cell) {
            let movie = moviesList[indexPath.row]
            destination.movie = movie
        }
    }
}
