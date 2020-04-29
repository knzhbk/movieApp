//
//  MovieDetailViewController.swift
//  movieApp
//
//  Created by Adina Kenzhebekova on 4/28/20.
//  Copyright © 2020 Adina Kenzhebekova. All rights reserved.
//

import UIKit

class MovieDetailViewController: UIViewController {
    
    @IBOutlet weak var detailMovieTitle: UILabel!
    @IBOutlet weak var detailImage: UIImageView!
    @IBOutlet weak var detailMovieDate: UILabel!
    @IBOutlet weak var movieDescription: UILabel!
    @IBOutlet weak var detailMovieRating: UILabel!
    
    var movie: Movie?
    var genre = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let movie = movie {
            detailMovieTitle.text = movie.title
            detailMovieDate.text = movie.release_date
            movieDescription.text = movie.overview
            detailMovieRating.text = "Rating: \(movie.vote_average)"
            self.title = movie.title
            
            if movie.poster_path != nil {
                let moviePosterUrl = MovieProvider.getMoviePosterUrl(posterUrl: movie.poster_path!)
                detailImage.sd_setImage(with: URL(string:moviePosterUrl), placeholderImage:nil)
            }
            //getting genre
            for item in movie.genre_ids {
                genre = item
            }
            //            detailMovieRating.text =
        }
    }
}
