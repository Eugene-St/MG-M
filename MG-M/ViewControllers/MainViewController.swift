//
//  ViewController.swift
//  MG-M
//
//  Created by Eugene St on 16.12.2020.
//

import UIKit

class MainViewController: UIViewController {
        
        // MARK: - IBOutlets
        //fields
        @IBOutlet weak var matrixSizeTextField: UITextField!
        @IBOutlet weak var numberOfMatrixTextField: UITextField!
        //indicator
        @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
        //switchers
        @IBOutlet weak var backgroungThreadSwitch: UISwitch!
        @IBOutlet weak var priorityThreadSwitch: UISwitch!
        @IBOutlet weak var parallelCalculationSwitch: UISwitch!
        
    @IBOutlet weak var bluredView: UIView!
    
    // MARK: - Private Properties
        var matrix: Matrix?
        
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
            
            activityIndicator.isHidden = false
            activityIndicator.startAnimating()
            
            bluredView.alpha = 0.2
            
            DispatchQueue.global(qos: .background).async {
                self.matrix?.generateMatrixes()
                
                let time = self.matrix?.countTimeOfMultiplying()
                
                DataManager.shared.saveData(time, key: Keys.calculationResultKey)
                
                DispatchQueue.main.async {
                    self.performSegue(withIdentifier: "calculation", sender: time)
                }
            }
        }
        
        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            
            if segue.identifier == "calculation" {
                
                let destinationVC = segue.destination as! ResultsViewController
                
                destinationVC.calculationTime = sender as! Double
                destinationVC.backgroungThreadSwitch = self.backgroungThreadSwitch.isOn
                destinationVC.priorityThreadSwitch = self.priorityThreadSwitch.isOn
                destinationVC.parallelCalculationSwitch = self.parallelCalculationSwitch.isOn
                
                destinationVC.delegate = self
                
            }
        }
        
        @IBAction func switcherChanged(_ sender: UISwitch) {
            switch sender.tag {
            case 0:
                DataManager.shared.saveData(sender.isOn, key: Keys.backgroundThreadSwitcherKey)
            case 1:
                DataManager.shared.saveData(sender.isOn, key: Keys.priorityThreadSwitcherKey)
            case 2:
                DataManager.shared.saveData(sender.isOn, key: Keys.parallelCalculationSwitcherKey)
            default:
                return
            }
        }
        
        //MARK: - UpdateUI
        private func setupUI() {
            matrixSizeTextField.text = String(DataManager.shared.fetchInt(key: Keys.matrixSizeKey))
            numberOfMatrixTextField.text = String(DataManager.shared.fetchInt(key: Keys.numberOfMatrixKey))
            
            backgroungThreadSwitch.isOn = DataManager.shared.fetchBool(key: Keys.backgroundThreadSwitcherKey)
            priorityThreadSwitch.isOn = DataManager.shared.fetchBool(key: Keys.priorityThreadSwitcherKey)
            parallelCalculationSwitch.isOn = DataManager.shared.fetchBool(key: Keys.parallelCalculationSwitcherKey)
            
            matrix?.setMatrixSize(Int(matrixSizeTextField.text ?? ""))
            matrix?.setNumberOfMatrixe(Int(numberOfMatrixTextField.text ?? ""))
        }
        
    }

    extension MainViewController: RefreshViewProtocol{
        func refreshUI() {
            
            activityIndicator.isHidden = true
            activityIndicator.stopAnimating()
            
            bluredView.alpha = 0
        }
    }


