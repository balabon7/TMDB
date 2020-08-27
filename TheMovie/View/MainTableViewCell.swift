//
//  Cell.swift
//  TheMovie
//
//  Created by mac on 26.08.2020.
//  Copyright © 2020 Aleksandr Balabon. All rights reserved.
//

import UIKit

class MainTableViewCell: UITableViewCell {
    
     lazy var posterImageView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        
        return image
    }()
    
    
     lazy var movieNameLabel: UILabel = {
        let label = UILabel ()
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.numberOfLines = 0
        label.lineBreakMode = .byTruncatingTail
        label.minimumScaleFactor = 0.8
        
        return label
    }()
    
    lazy var releaseDateLabel: UILabel = {
        let label = UILabel ()
        label.font = .boldSystemFont(ofSize: 12)
        label.textColor = .darkGray
        
        return label
    }()
    
     lazy var ratingLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 12)
        label.textColor = .darkGray
        
        return label
    }()
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.posterImageView.image = UIImage(named: "placeholder")
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubview(posterImageView)
        addSubview(movieNameLabel)
        addSubview(releaseDateLabel)
        addSubview(ratingLabel)
        
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    fileprivate func setupConstraints() {
        
        posterImageView.translatesAutoresizingMaskIntoConstraints = false
        posterImageView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        posterImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12).isActive = true
        posterImageView.heightAnchor.constraint(equalToConstant: 70).isActive = true
        posterImageView.widthAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.6).isActive = true
        
        movieNameLabel.translatesAutoresizingMaskIntoConstraints = false
        movieNameLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 0).isActive = true
        movieNameLabel.leadingAnchor.constraint(equalTo: posterImageView.trailingAnchor, constant: 12).isActive = true
        movieNameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12).isActive = true
        movieNameLabel.heightAnchor.constraint(equalToConstant: 34).isActive = true
        
        
        releaseDateLabel.translatesAutoresizingMaskIntoConstraints = false
        releaseDateLabel.topAnchor.constraint(equalTo: self.movieNameLabel.bottomAnchor, constant: 6).isActive = true
        releaseDateLabel.leadingAnchor.constraint(equalTo: posterImageView.trailingAnchor, constant: 12).isActive = true
        releaseDateLabel.heightAnchor.constraint(equalToConstant: 16).isActive = true
        releaseDateLabel.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        
        ratingLabel.translatesAutoresizingMaskIntoConstraints = false
        ratingLabel.topAnchor.constraint(equalTo: self.releaseDateLabel.bottomAnchor, constant: 6).isActive = true
        ratingLabel.leadingAnchor.constraint(equalTo: posterImageView.trailingAnchor, constant: 12).isActive = true
        ratingLabel.heightAnchor.constraint(equalToConstant: 16).isActive = true
        ratingLabel.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
    }
    
}
