//
//  ViewController.swift
//  TheMovie
//
//  Created by mac on 26.08.2020.
//  Copyright © 2020 Aleksandr Balabon. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
     
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        setupViews()
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
    }
    
    @objc private func handleSegmentChange() {
        
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            print("PopularMovies")
        case 1:
            print("UpcomingMovies")
        case 2:
            print("TopRatedMovies")
        default:
            break
        }
        tableView.reloadData()
    }
    
}

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell()
        cell.textLabel?.text = "Movie\(indexPath.row)"
        
        return cell
    }
}
