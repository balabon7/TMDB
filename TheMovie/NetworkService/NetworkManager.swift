//
//  NetworkManager.swift
//  TheMovie
//
//  Created by mac on 26.08.2020.
//  Copyright © 2020 Aleksandr Balabon. All rights reserved.
//

import Foundation
import Alamofire

struct NetworkManager {
    
    static func getMovies(inCategory category: MovieCategory, completion: @escaping (_ movies: [Movie]) -> ()) {
        
        var url = "https://api.themoviedb.org/3/movie/"
        let parameters = ["api_key": "dd5883c1a7250cfa0dd42a640afa1cac"]
        
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
}
