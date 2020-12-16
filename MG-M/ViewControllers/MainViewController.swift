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
        @IBOutlet weak var matrixSizeTextLabel: UITextField!
        @IBOutlet weak var numberOfMatrixTextLabel: UITextField!
        //indicator
        @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
        //switchers
        @IBOutlet weak var backgroungThreadSwitcher: UISwitch!
        @IBOutlet weak var priorityThreadSwitcher: UISwitch!
        @IBOutlet weak var parallelCalculationSwitcher: UISwitch!
        
        // MARK: - Private Properties
        var matrix: Matrix!
        
        override func viewDidLoad() {
            super.viewDidLoad()
            activityIndicator.isHidden = true
            
            matrix = Matrix()
            
            matrixSizeTextLabel.delegate = self
            numberOfMatrixTextLabel.delegate = self
            
            addDoneButtonTo(matrixSizeTextLabel)
            addDoneButtonTo(numberOfMatrixTextLabel)
            
            updateUI()
        }
        
        // MARK: - IBActions
        @IBAction func startCalculationPressed(_ sender: UIButton) {
            
            activityIndicator.isHidden = false
            activityIndicator.startAnimating()
            sender.isEnabled = false

            let time = matrix.countTimeOfMultiplying()
            DataManager.shared.saveData(time, key: Keys.calculationResultKey)
            
            print(time)
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
        private func updateUI() {
            matrixSizeTextLabel.text = String(DataManager.shared.fetchInt(key: Keys.matrixSizeKey))
            numberOfMatrixTextLabel.text = String(DataManager.shared.fetchInt(key: Keys.numberOfMatrixKey))
            
            backgroungThreadSwitcher.isOn = DataManager.shared.fetchBool(key: Keys.backgroundThreadSwitcherKey)
            priorityThreadSwitcher.isOn = DataManager.shared.fetchBool(key: Keys.priorityThreadSwitcherKey)
            parallelCalculationSwitcher.isOn = DataManager.shared.fetchBool(key: Keys.parallelCalculationSwitcherKey)
            
            matrix.setMatrixSize(Int(matrixSizeTextLabel.text ?? ""))
            matrix.setNumberOfMatrixe(Int(numberOfMatrixTextLabel.text ?? ""))
        }
        
    }


