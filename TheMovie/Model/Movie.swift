//
//  Movie.swift
//  TheMovie
//
//  Created by mac on 27.08.2020.
//  Copyright © 2020 Aleksandr Balabon. All rights reserved.
//

import Foundation

// MARK: - Movie

struct Movie {
    let adult: Bool?
    let backdropPath: String?
    let belongsToCollection: NSNull?
    let budget: Int?
    let homepage: String?
    let id: Int?
    let imdbID, originalLanguage, originalTitle, overview: String?
    let popularity: Double?
    let posterPath: String?
    let releaseDate: String?
    let revenue, runtime: Int?
    let status, tagline, title: String?
    let video: Bool?
    let voteAverage: Double?
    let voteCount: Int?
    
    init?(json: [String: Any]) {
        let adult = json["adult"] as? Bool
        let backdropPath = json["backdrop_path"] as? String
        let belongsToCollection = json["belongs_to_collection"] as? NSNull
        let budget = json["budget"] as? Int
        let homepage = json["homepage"] as? String
        let id = json["id"] as? Int
        let imdbID = json["imdb_id"] as? String
        let originalLanguage = json["original_language"] as? String
        let originalTitle = json["original_title"] as? String
        let overview = json["overview"] as? String
        let popularity = json["popularity"] as? Double
        let posterPath = json["poster_path"] as? String
        let releaseDate = json["release_date"] as? String
        let revenue = json["revenue"] as? Int
        let runtime = json["runtime"] as? Int
        let status = json["status"] as? String
        let tagline = json["tagline"] as? String
        let title = json["title"] as? String
        let video = json["video"] as? Bool
        let voteAverage = json["vote_average"] as? Double
        let voteCount = json["vote_count"] as? Int
        
        self.adult = adult
        self.backdropPath = backdropPath
        self.belongsToCollection = belongsToCollection
        self.budget = budget
        self.homepage = homepage
        self.id = id
        self.imdbID = imdbID
        self.originalLanguage = originalLanguage
        self.originalTitle = originalTitle
        self.overview = overview
        self.popularity = popularity
        self.posterPath = posterPath
        self.releaseDate = releaseDate
        self.revenue = revenue
        self.runtime = runtime
        self.status = status
        self.tagline = tagline
        self.title = title
        self.video = video
        self.voteAverage = voteAverage
        self.voteCount = voteCount
    }
}
