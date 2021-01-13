//
//  ResultsViewController.swift
//  MG-M
//
//  Created by Eugene St on 16.12.2020.
//

import UIKit

class ResultsViewController: UIViewController {
    
    // MARK: - Properties
    var calculationTime: Double?
    
    var resultsCalculation: [String : Double]?
    
    var delegate: RefreshViewProtocol?
    
    // MARK: - IBAction
    @IBAction func backButtonPressed() {
        delegate?.refreshUI()
        dismiss(animated: true)
    }
}

// MARK: - Table view data source
extension ResultsViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return resultsCalculation?.count ?? 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let sortedResults = (Array(resultsCalculation ?? ["0":0]).sorted{$0.1 < $1.1})
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        cell.textLabel?.text = "\(sortedResults[indexPath.row].key) : \(sortedResults[indexPath.row].value) ms"
        
        return cell
    }
}
