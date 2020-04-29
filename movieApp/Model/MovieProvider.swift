//
//  MovieManager.swift
//  movieApp
//
//  Created by Adina Kenzhebekova on 4/27/20.
//  Copyright © 2020 Adina Kenzhebekova. All rights reserved.
//

import Foundation

class MovieProvider {

    func start() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(onRequestMoviesList),
                                               name: .requestMoviesListNotification,
                                               object: nil)
    }
    
    @objc func onRequestMoviesList(notification: Notification) {
        let request = notification.object as! RequestMoviesListNotification
        let moviesListUrl = getMoviesListUrl(page: request.page)
        
        if let url = URL(string: moviesListUrl) {
            let quoteLoadTask =
                URLSession.shared.dataTask(with: url) {
                    [weak self]
                    (data, response, error)
                    in
                    guard let self = self else {
                        return
                    }
                    if let data = data {
                        do {
                            print(moviesListUrl)
                            let moviesList = try JSONDecoder().decode(MoviesListResponse.self,
                                                                      from: data)

                            DispatchQueue.main.async {
                                self.sendMovies(page: request.page, movies: moviesList.results)
                            }
                        } catch {
                            print("Decoding JSON failure: \(error)")
                        }
                    }
            }
            quoteLoadTask.resume()
        }
    }
    
    func getMoviesListUrl(page: Int = 1) -> String {
        let baseApiUrl = "https://api.themoviedb.org/3/movie/upcoming"
        let apiKey = "7846191498003a62d2789be2acc64e91"
        return "\(baseApiUrl)?api_key=\(apiKey)&page=\(page)"
    }
    
    func sendMovies(page: Int, movies: [Movie]) {
        let response = ResponseMoviesListNotification(page: page, movies: movies)
        NotificationCenter.default.post(name: .responseMoviesListNotification, object: response)
    }
    
    static func getMoviePosterUrl(posterUrl: String) -> String {
        let baseImageUrl = "https://image.tmdb.org/t/p/w500"
        return "\(baseImageUrl)\(posterUrl)"
    }
}

struct MoviesListResponse: Decodable {
    var results: [Movie] = []
}

struct RequestMoviesListNotification {
    let page: Int
}

struct ResponseMoviesListNotification {
    let page: Int
    let movies: [Movie]
}

extension Notification.Name {
    static let requestMoviesListNotification = NSNotification.Name("request_movies_list")
    static let responseMoviesListNotification = NSNotification.Name("response_movies_list")
}
