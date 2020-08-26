//
//  ViewController.swift
//  TheMovie
//
//  Created by mac on 26.08.2020.
//  Copyright © 2020 Aleksandr Balabon. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    private lazy var movies = [Movie]()
    
    private let segmentedControl: UISegmentedControl = {
        let sc = UISegmentedControl(items: ["Popular", "Upcomming", "Top Rated"])
        sc.selectedSegmentIndex = 0
        sc.addTarget(self, action: #selector(handleSegmentChange), for: .valueChanged)
        
        return sc
    }()
    
    private var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        
        return tableView
    }()
    
    let activityIndicator: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView()
        spinner.startAnimating()
        spinner.isHidden = true
        return spinner
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        setupViews()
        
        self.activityIndicator.isHidden = false
        fetchPopularMovies()
    }
    
    private func setupViews() {
        
        navigationItem.title = "Movies"
        
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
        
        self.view.addSubview(activityIndicator)
        activityIndicator.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
        activityIndicator.center = view.center
        activityIndicator.isHidden = true
    }
    
    private func startIndicator() {
        self.activityIndicator.startAnimating()
        self.activityIndicator.isHidden = false
    }
    
    
    private func endIndicator() {
        self.activityIndicator.stopAnimating()
        self.activityIndicator.isHidden = true
    }
    
    
    private func fetchPopularMovies() {
        NetworkManager.getMovies(inCategory: .popular) { [weak self](movies) in
            self?.endIndicator()
            self?.movies = movies
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
    }
    
    private func fetchUpcomingMovies() {
        NetworkManager.getMovies(inCategory: .upcoming) { [weak self] (movies) in
            self?.endIndicator()
            self?.movies = movies
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
    }
    
    private func fetchTopRatedMovies() {
        NetworkManager.getMovies(inCategory: .topRated) { [weak self](movies) in
            self?.endIndicator()
            self?.movies = movies
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
    }
    
    @objc private func handleSegmentChange() {
        
        startIndicator()
        
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
    
}

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = movies[indexPath.row].title
        return cell
    }
}
