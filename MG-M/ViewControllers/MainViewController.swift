//
//  ViewController.swift
//  MG-M
//
//  Created by Eugene St on 16.12.2020.
//

import UIKit

class MainViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var matrixSizeTextField: UITextField!
    @IBOutlet weak var numberOfMatrixTextField: UITextField!
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    @IBOutlet weak var backgroungThreadSwitch: UISwitch!
    @IBOutlet weak var priorityThreadSwitch: UISwitch!
    @IBOutlet weak var parallelCalculationSwitch: UISwitch!
    
    @IBOutlet weak var bluredView: UIView!
    
    // MARK: - Properties
    var calculationSettings = CalculationSettings()
    
    // MARK: - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        activityIndicator.isHidden = true
        
        matrixSizeTextField.delegate = self
        numberOfMatrixTextField.delegate = self
        
        addDoneButtonTo(matrixSizeTextField)
        addDoneButtonTo(numberOfMatrixTextField)
        
        setupUI()
    }
    
    //MARK: - End calcultion
    func endCalcultion(with result: [String:Double]){
        performSegue(withIdentifier: "calculation", sender: result)
    }
    
    // MARK: - IBActions
    @IBAction func startCalculationPressed(_ sender: UIButton) {
        updateCalculationSettings()
        
        let calculator = Calculator(settings: calculationSettings) {
            [weak self] resultArray in
            self?.endCalcultion(with: resultArray)
        }
        
        calculator.startCalculation()
        
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
        bluredView.alpha = 0.2
    }
    
    @IBAction func backgroundSwitchChanged(_ sender: UISwitch) {
        DataManager.shared.saveData(sender.isOn, key: Keys.backgroundThreadSwitchKey)
    }
    
    @IBAction func prioritySwitchChanged(_ sender: UISwitch) {
        DataManager.shared.saveData(sender.isOn, key: Keys.priorityThreadSwitchKey)
    }
    
    @IBAction func parallelSwitchChanged(_ sender: UISwitch) {
        DataManager.shared.saveData(sender.isOn, key: Keys.parallelCalculationSwitchKey)
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "calculation" {
            let destinationVC = segue.destination as! ResultsViewController
            destinationVC.resultsCalculation = sender as? [String : Double]
            destinationVC.delegate = self
        }
    }
    
    
    //MARK: - UpdateUI
    private func setupUI() {
        
        matrixSizeTextField.text = String(DataManager.shared.fetchInt(key: Keys.matrixSizeKey))
        numberOfMatrixTextField.text = String(DataManager.shared.fetchInt(key: Keys.numberOfMatrixKey))
        
        backgroungThreadSwitch.isOn = DataManager.shared.fetchBool(key: Keys.backgroundThreadSwitchKey)
        priorityThreadSwitch.isOn = DataManager.shared.fetchBool(key: Keys.priorityThreadSwitchKey)
        parallelCalculationSwitch.isOn = DataManager.shared.fetchBool(key: Keys.parallelCalculationSwitchKey)
    }
    
    //MARK: - Update settings
    private func updateCalculationSettings(){
        calculationSettings.optimizations = [.noOptimization]
        //background
        if DataManager.shared.fetchBool(key: Keys.backgroundThreadSwitchKey) {
            calculationSettings.optimizations.append(.background)
        }
        
        //priority
        if DataManager.shared.fetchBool(key: Keys.priorityThreadSwitchKey) {
            calculationSettings.optimizations.append(.priority)
        }
        
        //parallel
        if DataManager.shared.fetchBool(key: Keys.parallelCalculationSwitchKey) {
            calculationSettings.optimizations.append(.parallel)
        }
    }
}

// MARK: - MainViewController Extension
extension MainViewController: RefreshViewProtocol {
    func refreshUI() {
        activityIndicator.isHidden = true
        activityIndicator.stopAnimating()
        
        bluredView.alpha = 0
    }
}


