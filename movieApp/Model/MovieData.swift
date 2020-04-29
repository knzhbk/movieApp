//
//  MovieData.swift
//  movieApp
//
//  Created by Adina Kenzhebekova on 4/27/20.
//  Copyright © 2020 Adina Kenzhebekova. All rights reserved.
//

import Foundation

struct Movie: Decodable {
    var poster_path: String?
    var genre_ids: Array<Int>
    var title: String
    var vote_average: Double
    var overview: String
    var release_date: String
}
