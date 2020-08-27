//
//  DetailViewController.swift
//  TheMovie
//
//  Created by mac on 27.08.2020.
//  Copyright © 2020 Aleksandr Balabon. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    var selectedMovie: Int?
    var movie: Movie?
    
    
    lazy var backdropImageView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        // image.backgroundColor = .yellow
        return image
    }()
    
    
    lazy var movieNameLabel: UILabel = {
        let label = UILabel ()
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .center
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController!.navigationBar.topItem?.title = ""
        setupViews()
        
        guard let id = selectedMovie else { return }
        self.fetchDetailMovie(id: id)
    }
    
    private func setupViews() {
        
        view.addSubview(backdropImageView)
        view.addSubview(movieNameLabel)
        setupConstraints()
    }
    
    fileprivate func setupConstraints() {
        
        backdropImageView.translatesAutoresizingMaskIntoConstraints = false
        backdropImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        backdropImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        backdropImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
        backdropImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
        backdropImageView.heightAnchor.constraint(equalToConstant: 200).isActive = true
        
        
        movieNameLabel.translatesAutoresizingMaskIntoConstraints = false
        movieNameLabel.topAnchor.constraint(equalTo: backdropImageView.bottomAnchor, constant: 6).isActive = true
        movieNameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12).isActive = true
        movieNameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -12).isActive = true
        movieNameLabel.heightAnchor.constraint(equalToConstant: 16).isActive = true

    }
    
    
    private func fetchDetailMovie(id: Int) {
        
        NetworkManager.getMovieInfo(forId: id) { [weak self] (movie) in
            
            self?.navigationItem.title = movie.title
            
            self?.movie = movie
            self?.movieNameLabel.text = movie.title
            
            guard let backdropPath = movie.backdropPath else {return }
            self?.fetchDataImage(backdropPath: backdropPath)
        }
    }
    
    
    
    private func fetchDataImage(backdropPath: String) {
        
        let url = "https://image.tmdb.org/t/p/w500/\(backdropPath)"
        
        NetworkManager.downloadImage(url: url) { (image) in
            
            DispatchQueue.main.async {
                self.backdropImageView.image = image
            }
            
        }
    }
}
