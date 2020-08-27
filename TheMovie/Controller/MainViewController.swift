//
//  ViewController.swift
//  TheMovie
//
//  Created by mac on 26.08.2020.
//  Copyright © 2020 Aleksandr Balabon. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    private lazy var movies = [Result]()
    private var selectedId: Int?
    
    private let segmentedControl: UISegmentedControl = {
        let sc = UISegmentedControl(items: ["Popular", "Upcomming", "Top Rated"])
        sc.selectedSegmentIndex = 0
        sc.addTarget(self, action: #selector(handleSegmentChange), for: .valueChanged)
        
        return sc
    }()
    
    private var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.rowHeight = 80
        tableView.register(MainTableViewCell.self, forCellReuseIdentifier: "MainTableViewCell")
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        setupViews()
        showSpinner()
        fetchPopularMovies()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationItem.title = "Movies"
    }
    
    private func setupViews() {
        
        let indentedStackView = UIStackView(arrangedSubviews: [segmentedControl])
        indentedStackView.layoutMargins = .init(top: 12, left: 12, bottom: 12, right: 12)
        indentedStackView.isLayoutMarginsRelativeArrangement = true
        
        let stackView = UIStackView(arrangedSubviews: [indentedStackView, tableView])
        stackView.axis = .vertical
        
        self.view.addSubview(stackView)
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func fetchPopularMovies() {
        NetworkManager.getMovies(inCategory: .popular) { [weak self](movies) in

            self?.movies = movies
            DispatchQueue.main.async {
            
                self?.tableView.reloadData()
                self?.removeSpinner()
            }
        }
    }
    
    private func fetchUpcomingMovies() {
        NetworkManager.getMovies(inCategory: .upcoming) { [weak self] (movies) in
       
            self?.movies = movies
            DispatchQueue.main.async {
                self?.tableView.reloadData()
                 self?.removeSpinner()
            }
        }
    }
    
    private func fetchTopRatedMovies() {
        NetworkManager.getMovies(inCategory: .topRated) { [weak self](movies) in

            self?.movies = movies
            DispatchQueue.main.async {
                self?.tableView.reloadData()
                self?.removeSpinner()
            }
        }
    }
    
    @objc private func handleSegmentChange() {
        
       showSpinner()
        
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            fetchPopularMovies()
        case 1:
            fetchUpcomingMovies()
        case 2:
            fetchTopRatedMovies()
        default:
            break
        }
        tableView.reloadData()
    }
    
    private func configureCell(cell: MainTableViewCell, for indexPath: IndexPath) {
        
        let movie = movies[indexPath.row]
        cell.movieNameLabel.text = movie.title
        
        if let releaseDate = movie.releaseDate {
            cell.releaseDateLabel.text = "Release Date: \(releaseDate)"
        }
        
        if let voteAverage = movie.voteAverage {
            cell.ratingLabel.text = "Rating: \(voteAverage)"
        }
        
        DispatchQueue.global().async {
            
            let url = "https://image.tmdb.org/t/p/w500/"
            guard let imageUrl = URL(string: url + movie.posterPath!) else { return }
            guard let imageData = try? Data(contentsOf: imageUrl) else { return }
            
            DispatchQueue.main.async {
               cell.posterImageView.image = UIImage(data: imageData)
            }
        }
    }
    
}

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "MainTableViewCell", for: indexPath) as! MainTableViewCell
        
        configureCell(cell: cell, for: indexPath)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        guard let id = movies[indexPath.row].id else { return }
        self.selectedId = id
        
        if let detailVC = storyboard?.instantiateViewController(withIdentifier: "DetailedInfoVC") as? DetailViewController {
        
            detailVC.selectedMovie = selectedId
            navigationController?.pushViewController(detailVC, animated: true)
        }
    }
}
