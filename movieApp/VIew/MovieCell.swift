//
//  MovieCell.swift
//  movieApp
//
//  Created by Adina Kenzhebekova on 4/27/20.
//  Copyright © 2020 Adina Kenzhebekova. All rights reserved.
//

import UIKit

class MovieCell: UITableViewCell {
    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var movieDate: UILabel!
    @IBOutlet weak var movieTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        movieImage?.layer.cornerRadius = 5.0;
        movieImage?.clipsToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        movieDate.backgroundColor = UIColor(white: 1, alpha: 0.5)
        movieTitle.backgroundColor = UIColor(white: 1, alpha: 0.5)
    }
}
