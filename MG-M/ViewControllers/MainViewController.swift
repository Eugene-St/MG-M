//
//  ViewController.swift
//  MG-M
//
//  Created by Eugene St on 16.12.2020.
//

import UIKit

class MainViewController: UIViewController {
    
    // MARK: - IBOutlets
    // Fields
    @IBOutlet weak var matrixSizeTextField: UITextField!
    @IBOutlet weak var numberOfMatrixTextField: UITextField!
    
    // Indicator
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    // Switches
    @IBOutlet weak var backgroungThreadSwitch: UISwitch!
    @IBOutlet weak var priorityThreadSwitch: UISwitch!
    @IBOutlet weak var parallelCalculationSwitch: UISwitch!
    
    // View
    @IBOutlet weak var bluredView: UIView!
    
    // MARK: - Private Properties
    var matrix: Matrix?
    var resultsArray: [String : Double?] = [:]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        activityIndicator.isHidden = true
        
        matrix = Matrix()
        
        matrixSizeTextField.delegate = self
        numberOfMatrixTextField.delegate = self
        
        addDoneButtonTo(matrixSizeTextField)
        addDoneButtonTo(numberOfMatrixTextField)
        
        setupUI()
    }
    
    // MARK: - IBActions
    @IBAction func startCalculationPressed(_ sender: UIButton) {
        
        matrix?.generateMatrixes()
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
        
        bluredView.alpha = 0.2
        
        if DataManager.shared.fetchBool(key: Keys.backgroundThreadSwitchKey) {
            DispatchQueue.global(qos: .background).async {
                
                let backgroundThreadTime = self.matrix?.countTimeOfMultiplying()
                self.resultsArray["Background Thread"] = backgroundThreadTime
//              DataManager.shared.saveData(time, key: Keys.calculationResultKey)
            }
        }
        
        let time = self.matrix?.countTimeOfMultiplying()
        
        self.resultsArray["No optimization"] = time
        
//        DataManager.shared.saveData(time, key: Keys.calculationResultKey)
        
        DispatchQueue.main.async {
            self.performSegue(withIdentifier: "calculation", sender: self.resultsArray)
        }
        
//        DataManager.shared.saveData(resultsArray, key: Keys.resultArrayKey)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "calculation" {
            
            let destinationVC = segue.destination as! ResultsViewController
            
//            destinationVC.calculationTime = sender as? Double
            destinationVC.resultsCalculation = sender as? [String : Double?]
            destinationVC.backgroungThreadSwitch = self.backgroungThreadSwitch.isOn
            destinationVC.priorityThreadSwitch = self.priorityThreadSwitch.isOn
            destinationVC.parallelCalculationSwitch = self.parallelCalculationSwitch.isOn
            
            destinationVC.delegate = self
            
        }
    }
    
    @IBAction func switcherChanged(_ sender: UISwitch) {
        switch sender.tag {
        case 0:
            DataManager.shared.saveData(sender.isOn, key: Keys.backgroundThreadSwitchKey)
        case 1:
            DataManager.shared.saveData(sender.isOn, key: Keys.priorityThreadSwitchKey)
        case 2:
            DataManager.shared.saveData(sender.isOn, key: Keys.parallelCalculationSwitchKey)
        default:
            return
        }
    }
    
    //MARK: - UpdateUI
    private func setupUI() {
        
        matrixSizeTextField.text = String(DataManager.shared.fetchInt(key: Keys.matrixSizeKey))
        numberOfMatrixTextField.text = String(DataManager.shared.fetchInt(key: Keys.numberOfMatrixKey))
        
        backgroungThreadSwitch.isOn = DataManager.shared.fetchBool(key: Keys.backgroundThreadSwitchKey)
        priorityThreadSwitch.isOn = DataManager.shared.fetchBool(key: Keys.priorityThreadSwitchKey)
        parallelCalculationSwitch.isOn = DataManager.shared.fetchBool(key: Keys.parallelCalculationSwitchKey)
        
        matrix?.setMatrixSize(Int(matrixSizeTextField.text ?? ""))
        matrix?.setNumberOfMatrixes(Int(numberOfMatrixTextField.text ?? ""))
    }
}

extension MainViewController: RefreshViewProtocol {
    func refreshUI() {
        
        activityIndicator.isHidden = true
        activityIndicator.stopAnimating()
        
        bluredView.alpha = 0
    }
}


