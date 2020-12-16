//
//  ResultsViewController.swift
//  MG-M
//
//  Created by Eugene St on 16.12.2020.
//

import UIKit

class ResultsViewController: UIViewController {
    
    var calculationTime: Double?
    
    var backgroungThreadSwitch: Bool?
    var priorityThreadSwitch: Bool?
    var parallelCalculationSwitch: Bool?
    
    var delegate: RefreshViewProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(calculationTime ?? 0)
    }
    
    @IBAction func backButtonPressed() {
        delegate?.refreshUI()
        dismiss(animated: true)
    }
    
}
// MARK: - Table view data source
extension ResultsViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

       let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
       
        cell.textLabel?.text = "\(String(calculationTime ?? 0)) milliseconds"
        
        return cell
    }
}
