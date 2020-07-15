//
//  CapitalCitiesListViewController.swift
//  CapitalCities
//
//  Created by Lukasz Czechowicz on 13/07/2020.
//  Copyright © 2020 Lukasz Czechowicz. All rights reserved.
//

import UIKit

class CapitalCitiesListViewController: BaseViewController<CapitalCitiesListViewModel> {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activity: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupTableView()
        self.setupFavouriteButtonItem()
        
        
        //handles state/data flow from viewModel
        self.viewModel.uiRefresh = { [weak self] in
            self?.refreshView()
        }
        
        self.viewModel.errorHandler = { [weak self] description in
            self?.showAlert(information: description)
        }
        
        
        self.viewModel.activityStart = { [weak self] in
            guard let s = self else { return }
            s.tableView.isHidden = true
            s.activity.isHidden = false
            s.activity.startAnimating()
        }
        
        self.viewModel.activityCompleted = { [weak self] in
            guard let s = self else { return }
            s.activity.isHidden = true
            s.tableView.isHidden = false
            s.activity.stopAnimating()
        }
        
        self.viewModel.getCities()
    }
    
    
    /// refreshing and reloading tableView
    func refreshView() {
        self.tableView.reloadData()
        self.setupFavouriteButtonItem()
    }
    
    
    /// creates and decorates favourite button
    private func setupFavouriteButtonItem() {
        let favBarButtonItem = UIBarButtonItem(image: UIImage(named: "fav.fill")?.image(alpha: self.viewModel.isFiltered ? 1.0 : 0.4), style: .plain, target: self, action: #selector(favBarButtonTapHandler))
        self.navigationItem.rightBarButtonItem = favBarButtonItem
    }
    
    
    /// setups table view
    private func setupTableView() {
        tableView.register(CityTableViewCell.self)
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    
    @objc private func favBarButtonTapHandler() {
        self.viewModel.favouriteFilter()
    }
}

extension CapitalCitiesListViewController:UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.itemsNumber
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let model = self.viewModel.city(at: indexPath.row) else { return UITableViewCell() }
        
        let cell:CityTableViewCell = self.tableView.dequeueReusableCell(for: indexPath)
        cell.configure(model: model, isFavourite: self.viewModel.checkCityFavourite(cityId: model.id))
        if let url = model.imageURL {
            self.viewModel.downloadThumbnail(url: url, cityId: model.id) { data in
                cell.updateImage(data:data)
            }
        }
        
        return cell
    }
    
    
}


extension CapitalCitiesListViewController:UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.viewModel.select(at:indexPath.row)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CityTableViewCell.height
    }
}
