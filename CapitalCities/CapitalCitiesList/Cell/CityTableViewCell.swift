//
//  CityTableViewCell.swift
//  CapitalCities
//
//  Created by Lukasz Czechowicz on 13/07/2020.
//  Copyright © 2020 Lukasz Czechowicz. All rights reserved.
//

import UIKit

class CityTableViewCell: UITableViewCell {
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }
    @IBOutlet weak var favImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var cityImageView: UIImageView!
    
    func configure(model:CityModel, isFavourite:Bool) {
        self.titleLabel.text = model.name
        if isFavourite {
             self.favImageView.image = UIImage(named: "fav.fill")
        } else {
            self.favImageView.image = nil
        }
    }
    
    func updateImage(data:Data) {
        self.cityImageView.image = UIImage(data: data)
    }
}

extension CityTableViewCell {
    static let height:CGFloat = 60.0
}
