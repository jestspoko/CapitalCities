//
//  CapitalCityDetailViewController.swift
//  CapitalCities
//
//  Created by Lukasz Czechowicz on 13/07/2020.
//  Copyright © 2020 Lukasz Czechowicz. All rights reserved.
//

import UIKit

class CapitalCityDetailViewController: BaseViewController<CapitalCityDetailViewModel> {
    @IBOutlet weak var cityImageView: UIImageView!
    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var favButton: UIButton!
    @IBOutlet weak var visitedButton: UIButton!
    @IBOutlet weak var ratingLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        /// checks if image data previously downloaded
        if let data = self.viewModel.cityImageData, let image = UIImage(data: data) {
            self.cityImageView.image = image
        }
    
        self.cityNameLabel.text = self.viewModel.cityName

        //since info about people visited and rating is received asynchronously, hide corresponding UI
        self.ratingLabel.isHidden = true
        self.visitedButton.isHidden = true
        self.favouriteButtonSetup(for: self.viewModel.isFavourite)
        
        
        /**
         Since rating and number people visited are marked as "additional data", decided to not wait till concurrent requests are completed. Information are presented with animation "when request completed" instead.
         */
        self.viewModel.ratingHandler = { [weak self] in
            guard let s = self else { return }
            if s.viewModel.rating > 0 {
                s.ratingLabel.text = "Rating: \(s.viewModel.rating)"
                s.animateFadeIn(view: s.ratingLabel)
            }
        }
        
        // update UI for people visited
        self.viewModel.peopleVisitedHandler = { [weak self] in
            guard let s = self else { return }
            if s.viewModel.people.count > 0 {
                
                s.visitedButton.setTitle("People visited: \(s.viewModel.people.count)", for: .normal)
                s.animateFadeIn(view: s.visitedButton)
            }
        }
        
        // handles errors
        self.viewModel.errorHandler = { [weak self] description in
            self?.showAlert(information: description)
        }
    }
    
    /// decorates favurite button for given state
    /// - Parameter state: bool
    private func favouriteButtonSetup(for state:Bool) {
        self.favButton.setImage(UIImage(named: state ? "fav.fill" : "fav"), for: .normal)
    }
    
    
    /// perform fade in animation on view
    /// - Parameter view: UIView
    private func animateFadeIn(view:UIView) {
        view.isHidden = false
        view.alpha = 0.0
        UIView.animate(withDuration: 0.3) {
            view.alpha = 1.0
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        //run concurrent task on start
        self.viewModel.cityRating()
        self.viewModel.peopleVisited()
    }
    
    
    // User tap handlers
    
    @IBAction func favButtonTapHandler(_ sender: Any) {
        self.viewModel.changeFavouriteState { state in
            self.favouriteButtonSetup(for: state)
        }
    }
    @IBAction func visitedButtonTapHandler(_ sender: Any) {
        self.viewModel.showPeopleVisited()
    }
}
