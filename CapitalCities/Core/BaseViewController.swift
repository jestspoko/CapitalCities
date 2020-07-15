//
//  BaseViewController.swift
//  CapitalCities
//
//  Created by Lukasz Czechowicz on 13/07/2020.
//  Copyright © 2020 Lukasz Czechowicz. All rights reserved.
//

import Foundation
import UIKit


/// Base class for every app's view controller that implements viewModel concept
class BaseViewController<T:BaseViewModel>:UIViewController {
    let viewModel:T
    
    init(viewModel:T) {
        self.viewModel = viewModel
        super.init(nibName: String(describing: type(of: self)), bundle: Bundle.main)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = self.viewModel.title
    }
    
    /**
     
     Note: for demo purpose, this project uses only XIBs. Method below should be implemented for storyboards usage
     
     */
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    /// opens alert view with given info
    /// - Parameter information: information to show
    func showAlert(information:String) {
        let alert = UIAlertController(title: "Information", message: information, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: .destructive, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
        
    }
}
