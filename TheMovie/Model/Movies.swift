//
//  Movies.swift
//  TheMovie
//
//  Created by mac on 26.08.2020.
//  Copyright © 2020 Aleksandr Balabon. All rights reserved.
//

import Foundation

// MARK: - Movies
struct Movies: Decodable {
    let page, totalResults, totalPages: Int?
    let results: [Movie]?
    
    init?(json: [String: Any]) {
        let page = json["page"] as? Int
        let totalResults = json["total_results"] as? Int
        let totalPages = json["total_pages"] as? Int
        let results = (json["results"] as? [[String: Any]])?.compactMap { Movie(json: $0) }
        
        self.page = page
        self.totalResults = totalResults
        self.totalPages = totalPages
        self.results = results
    }
}

// MARK: - Result
struct Movie: Decodable {
    let popularity: Double?
    let voteCount: Int?
    let video: Bool?
    let posterPath: String?
    let id: Int?
    let adult: Bool?
    let backdropPath: String?
    let originalTitle: String?
    let genreIDS: [Int]?
    let title: String?
    
    init?(json: [String: Any]) {
        let popularity = json["popularity"] as? Double
        let voteCount = json["vote_count"] as? Int
        let video = json["video"] as? Bool
        let posterPath = json["poster_path"] as? String
        let id = json["id"] as? Int
        let adult = json["adult"] as? Bool
        let backdropPath = json["backdrop_path"] as? String
        let originalTitle = json["original_title"] as? String
        let genreIDS = json["genre_ids"] as? [Int]
        let title = json["title"] as? String
        
        self.popularity = popularity
        self.voteCount = voteCount
        self.video = video
        self.posterPath = posterPath
        self.id = id
        self.adult = adult
        self.backdropPath = backdropPath
        self.originalTitle = originalTitle
        self.genreIDS = genreIDS
        self.title = title
    }
}
