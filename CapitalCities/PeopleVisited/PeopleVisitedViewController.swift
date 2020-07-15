//
//  PeopleVisitedViewController.swift
//  CapitalCities
//
//  Created by Lukasz Czechowicz on 13/07/2020.
//  Copyright © 2020 Lukasz Czechowicz. All rights reserved.
//

import UIKit

class PeopleVisitedViewController: BaseViewController<PeopleVisitedViewModel> {

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.setupTableView()
    }
    
    private func setupTableView() {
        tableView.register(PeopleVisitedTableViewCell.self)
        tableView.dataSource = self
        tableView.rowHeight = 60.0
    }
    @IBAction func closeTapHandler(_ sender: Any) {
        self.viewModel.dismiss()
    }
    
}



extension PeopleVisitedViewController:UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.viewModel.peoplesCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let model = self.viewModel.person(at: indexPath.row) else { fatalError("person not found at given index") }
        let cell:PeopleVisitedTableViewCell = self.tableView.dequeueReusableCell(for: indexPath)
        cell.configure(name: model.name)
        return cell
    }
    
    
}
