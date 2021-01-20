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
    func onCalculationEnded(with result: [String:Double]){
        performSegue(withIdentifier: "calculation", sender: result)
    }
    
    // MARK: - IBActions
    @IBAction func startCalculationPressed(_ sender: UIButton) {
        updateCalculationSettings()
        
        let calculator = Calculator(settings: calculationSettings) {
            [weak self] resultArray in
            self?.onCalculationEnded(with: resultArray)
        }
        
        calculator.startCalculation()
        
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
        bluredView.alpha = 0.2
    }
    
    @IBAction func backgroundSwitchChanged(_ sender: UISwitch) {
        calculationSettings.backgroundOptimization = sender.isOn
        
    }
    
    @IBAction func prioritySwitchChanged(_ sender: UISwitch) {
        calculationSettings.priorityOptimization = sender.isOn
    }
    
    @IBAction func parallelSwitchChanged(_ sender: UISwitch) {
        calculationSettings.parallelOptimization = sender.isOn
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
        
        matrixSizeTextField.text = String(calculationSettings.matrixSize)
        numberOfMatrixTextField.text = String(calculationSettings.numberOfMatrixes)
        
        backgroungThreadSwitch.isOn = calculationSettings.backgroundOptimization
        priorityThreadSwitch.isOn = calculationSettings.priorityOptimization
        parallelCalculationSwitch.isOn = calculationSettings.parallelOptimization
    }
    
    //MARK: - Update settings
    private func updateCalculationSettings(){
        calculationSettings.optimizations = [.noOptimization]
        
        if calculationSettings.backgroundOptimization {
            calculationSettings.optimizations.append(.background)
        }
        
        if calculationSettings.priorityOptimization {
            calculationSettings.optimizations.append(.priority)
        }
        
        if calculationSettings.parallelOptimization {
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


