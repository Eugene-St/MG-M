//
//  ViewController.swift
//  MG-M
//
//  Created by Eugene St on 16.12.2020.
//

import UIKit

class MainViewController: UIViewController {

    // MARK: - IBOutlets
    @IBOutlet weak var matrixSizeTextLabel: UITextField!
    @IBOutlet weak var numberOfMatrixTextLabel: UITextField!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    // MARK: - Private Properties
     var matrix: Matrix!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        matrix = Matrix()
        matrixSizeTextLabel.delegate = self
        numberOfMatrixTextLabel.delegate = self
        addDoneButtonTo(matrixSizeTextLabel)
        addDoneButtonTo(numberOfMatrixTextLabel)
        
//        UserDefaults.value(forKey: "Matrix")
        
    // MARK: - IBActions
    }
    @IBAction func startCalculationPressed() {
        matrix.countTimeOfMultiplying()
        
    }
}


