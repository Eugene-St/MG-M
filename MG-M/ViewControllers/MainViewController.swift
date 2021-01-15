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
    var matrix: Matrix?
    private var resultsArray: [String : Double] = [:]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        activityIndicator.isHidden = true
        
//        matrix = Matrix()
        matrix = Matrix(viewController: self)
        Semafor.shared.matrixClass = matrix
        
        matrixSizeTextField.delegate = self
        numberOfMatrixTextField.delegate = self
        
        addDoneButtonTo(matrixSizeTextField)
        addDoneButtonTo(numberOfMatrixTextField)
        
        setupUI()
    }
    
    func endCalculation(time: Double) {
//        print(time)
    }
    
    // MARK: - IBActions
    @IBAction func startCalculationPressed(_ sender: UIButton) {
        
        let taskGroup = DispatchGroup()
        
        matrix?.generateMatrixes()
        
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
        bluredView.alpha = 0.2
        
        
        if DataManager.shared.fetchBool(key: Keys.backgroundThreadSwitchKey) {
            DispatchQueue.global(qos: .background).async(group: taskGroup) {
                self.matrix?.countTimeOfMultiplying()
            }
        }
        
        if DataManager.shared.fetchBool(key: Keys.priorityThreadSwitchKey) {
            DispatchQueue.global(qos: .userInteractive).async(group: taskGroup) {
                self.matrix?.countTimeOfMultiplying()
            }
        }
        
        // Matrix calculation on main queue
//        DispatchQueue.main.async(group: taskGroup) {
//            if let time = self.matrix?.countTimeOfMultiplying() {
//                self.resultsArray["No optimization"] = time
//            }
//        }
        
        DispatchQueue.main.async(group: taskGroup) {
            self.matrix?.countTimeOfMultiplying()
        }
        
        // Navigation to Results Controller
        taskGroup.notify(queue: DispatchQueue.main) {
            self.performSegue(withIdentifier: "calculation", sender: self.resultsArray)
        }
    }
    
    @IBAction func switcherChanged(_ sender: UISwitch) {
        switch sender.tag {
        case 0:
            DataManager.shared.saveData(sender.isOn, key: Keys.backgroundThreadSwitchKey);
        case 1:
            DataManager.shared.saveData(sender.isOn, key: Keys.priorityThreadSwitchKey);
        case 2:
            DataManager.shared.saveData(sender.isOn, key: Keys.parallelCalculationSwitchKey)
        default:
            return
        }
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "calculation" {
            let destinationVC = segue.destination as! ResultsViewController
            destinationVC.resultsCalculation = sender as? [String : Double]
            destinationVC.delegate = self
        }
    }
    
    // MARK: - Private Methods
//    private func backgroundCalculation(for group: DispatchGroup) {
//        DispatchQueue.global(qos: .background).async(group: group) {
//            if let backgroundThreadTime = self.matrix?.countTimeOfMultiplying() {
//                self.resultsArray["Background Thread"] = backgroundThreadTime
//            }
//        }
//    }
//
//    private func priorityCalculation(for group: DispatchGroup) {
//        DispatchQueue.global(qos: .userInteractive).async(group: group) {
//            if let priorityThreadTime = self.matrix?.countTimeOfMultiplying() {
//                self.resultsArray["Priority Thread"] = priorityThreadTime
//            }
//        }
//    }
    
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

// MARK: - MainViewController Extension
extension MainViewController: RefreshViewProtocol {
    func refreshUI() {
        
        activityIndicator.isHidden = true
        activityIndicator.stopAnimating()
        
        bluredView.alpha = 0
        resultsArray = [:]
    }
}


