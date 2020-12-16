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
    
    // MARK: - Private Properties
     var matrix: Matrix!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        matrix = Matrix()
        addDoneButtonTo(matrixSizeTextLabel)
        addDoneButtonTo(numberOfMatrixTextLabel)
        
//        UserDefaults.value(forKey: "Matrix")
        
    // MARK: - IBActions
    }
    @IBAction func startCalculationPressed() {
    }
}


