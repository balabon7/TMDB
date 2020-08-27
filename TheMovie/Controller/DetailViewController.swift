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
    
    private let backdropImageView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        
        return image
    }()
    
    private let movieNameLabel: UILabel = {
        let label = UILabel ()
        label.font = UIFont.boldSystemFont(ofSize: 22)
        label.textColor = .black
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .center
        
        return label
    }()
    
    private let genresLabel: UILabel = {
        let label = UILabel ()
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textColor = .gray
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .left
        
        return label
    }()
    
    private let releaseDateLabel: UILabel = {
        let label = UILabel ()
        label.font = .boldSystemFont(ofSize: 14)
        label.textColor = .gray
        
        return label
    }()
    
    private let voteAverageLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 14)
        label.textColor = .gray
        
        return label
    }()
    
    let overviewTextView: UITextView = {
        let textView = UITextView()
        textView.font = UIFont.systemFont(ofSize: 14)
        textView.textColor = .gray
        textView.textAlignment = .left
        textView.isEditable = false
        textView.isScrollEnabled = false
        textView.isSelectable = false
        
        return textView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        showSpinner()
        guard let id = selectedMovie else { return }
        self.fetchDetailMovie(id: id)
    }
    
    private func setupViews() {
    
        self.navigationController!.navigationBar.tintColor = .black
        view.addSubview(backdropImageView)
        view.addSubview(movieNameLabel)
        view.addSubview(genresLabel)
        view.addSubview(overviewTextView)
        view.addSubview(releaseDateLabel)
        view.addSubview(voteAverageLabel)
        setupConstraints()
    }
    
    private func fetchDetailMovie(id: Int) {

        NetworkManager.getMovieInfo(forId: id) { [weak self] (movie) in
            
            self?.movie = movie
            self?.movieNameLabel.text = movie.title
            self?.overviewTextView.text = movie.overview
            
            if let genresOfFilm = movie.genres {
                
                var genres = String()
                genresOfFilm.forEach { genres.append($0.name! + ", ") }
                genres.removeLast()
                genres.removeLast()
                self?.genresLabel.text = "Ganres:  \(genres)"
            }
            
            if let releaseDate = movie.releaseDate {
                self?.releaseDateLabel.text = "Release Date: \(releaseDate)"
            }
            
            if let voteAverage = movie.voteAverage {
                self?.voteAverageLabel.text = "Rating: \(voteAverage)"
            }
            
            guard let backdropPath = movie.backdropPath else {return }
            self?.fetchDataImage(backdropPath: backdropPath)
            
            self?.removeSpinner()
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

// MARK: - Layout
extension DetailViewController {
    
    fileprivate func setupConstraints() {
        
        backdropImageView.translatesAutoresizingMaskIntoConstraints = false
        backdropImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        backdropImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        backdropImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
        backdropImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
        backdropImageView.heightAnchor.constraint(equalToConstant: 200).isActive = true
        
        movieNameLabel.translatesAutoresizingMaskIntoConstraints = false
        movieNameLabel.topAnchor.constraint(equalTo: backdropImageView.bottomAnchor, constant: 8).isActive = true
        movieNameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12).isActive = true
        movieNameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -12).isActive = true
        movieNameLabel.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        genresLabel.translatesAutoresizingMaskIntoConstraints = false
        genresLabel.topAnchor.constraint(equalTo: movieNameLabel.bottomAnchor).isActive = true
        genresLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12).isActive = true
        genresLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -12).isActive = true
        genresLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        releaseDateLabel.translatesAutoresizingMaskIntoConstraints = false
        releaseDateLabel.topAnchor.constraint(equalTo: genresLabel.bottomAnchor).isActive = true
        releaseDateLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12).isActive = true
        releaseDateLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -12).isActive = true
        releaseDateLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        voteAverageLabel.translatesAutoresizingMaskIntoConstraints = false
        voteAverageLabel.topAnchor.constraint(equalTo: releaseDateLabel.bottomAnchor).isActive = true
        voteAverageLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12).isActive = true
        voteAverageLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -12).isActive = true
        voteAverageLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        overviewTextView.translatesAutoresizingMaskIntoConstraints = false
        overviewTextView.topAnchor.constraint(equalTo: voteAverageLabel.bottomAnchor).isActive = true
        overviewTextView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10).isActive = true
        overviewTextView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10).isActive = true
        overviewTextView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -12).isActive = true
    }
}
