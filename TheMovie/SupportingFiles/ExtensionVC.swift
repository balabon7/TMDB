//
//  Extension.swift
//  TheMovie
//
//  Created by mac on 27.08.2020.
//  Copyright © 2020 Aleksandr Balabon. All rights reserved.
//

import UIKit

fileprivate var backgroundView: UIView?

extension UIViewController {
    
    func showSpinner() {
        backgroundView = UIView(frame: self.view.bounds)
        backgroundView?.backgroundColor = UIColor.init(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.5)
        
        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.center = backgroundView!.center
        activityIndicator.startAnimating()
        backgroundView?.addSubview(activityIndicator)
        self.view.addSubview(backgroundView!)
    }
    
    func removeSpinner() {
        backgroundView?.removeFromSuperview()
        backgroundView = nil
    }
}
