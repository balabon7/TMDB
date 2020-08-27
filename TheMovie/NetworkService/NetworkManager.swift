//
//  NetworkManager.swift
//  TheMovie
//
//  Created by mac on 26.08.2020.
//  Copyright © 2020 Aleksandr Balabon. All rights reserved.
//

import Foundation
import Alamofire

var page = 1

struct NetworkManager {
    
    static func getMovies(inCategory category: MovieCategory, pageStringNumber number: Int, completion: @escaping (_ movies: [Result]) -> ()) {
        
        var url = "https://api.themoviedb.org/3/movie/"
        let parameters = ["api_key": "dd5883c1a7250cfa0dd42a640afa1cac", "page": "\(number)"]
        
        switch category {
        case .popular:
            url.append("popular")
        case .upcoming:
            url.append("upcoming")
        case .topRated:
            url.append("top_rated")
        }
        
        AF.request(url, method: .get, parameters: parameters).validate().responseJSON { (responseJSON) in
            
            switch responseJSON.result {
                
            case .success(let value):
                
                guard let jsonObject = value as? [String : Any],
                    let movies = Movies(json: jsonObject)
                    else { return }
                completion(movies.results!)
                
            case .failure(let error):
                print(error.localizedDescription)
            }
            
        }
    }
    
    static func getMovieInfo(forId id: Int, completion: @escaping (_ movies: Movie) -> ()) {
        
        let url = "https://api.themoviedb.org/3/movie/\(id)"
        
        let parameters = ["api_key" : "dd5883c1a7250cfa0dd42a640afa1cac"]
        
        AF.request(url, method: .get, parameters: parameters).validate().responseJSON { (responseJSON) in
            
            switch responseJSON.result {
                
            case .success(let value):
                guard let jsonObject = value as? [String : Any],
                    let movieInfo = Movie(json: jsonObject) else { return }
                completion(movieInfo)
                
            case .failure(let error):
                print(error.localizedDescription)
            }
            
        }
    }
    
    static func downloadImage(backdropPath path: String, completion: @escaping (_ image: UIImage)->()) {
        
        let url = "https://image.tmdb.org/t/p/w500/\(path)"
        
        AF.request(url).responseData { (responseData) in
            
            switch responseData.result {
            case .success(let data):
                guard let image = UIImage(data: data) else { return }
                completion(image)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
}
