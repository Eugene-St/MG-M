//
//  CalculationSettings.swift
//  MG-M
//
//  Created by Eugene St on 18.01.2021.
//

import Foundation

struct CalculationSettings {
    
    var numberOfMatrixes: Int {
        willSet {
            return DataManager.shared.saveData(newValue, key: Keys.numberOfMatrixKey)
        }
    }
    
    var matrixSize: Int {
        willSet {
            return DataManager.shared.saveData(newValue, key: Keys.matrixSizeKey)
        }
    }
    
    var optimizations: [Optimizations] = [.noOptimization]
    
    init() {
        let numberOfMatrixes = DataManager.shared.fetchInt(key: Keys.numberOfMatrixKey)
        self.numberOfMatrixes = numberOfMatrixes == 0 ? 3 : numberOfMatrixes
        DataManager.shared.saveData(self.numberOfMatrixes, key: Keys.numberOfMatrixKey)
        
        let matrixSize = DataManager.shared.fetchInt(key: Keys.matrixSizeKey)
        self.matrixSize = matrixSize == 0 ? 5 : matrixSize
        DataManager.shared.saveData(self.matrixSize, key: Keys.matrixSizeKey)
    }
}

enum Optimizations: String {
    case background = "Background"
    case priority = "Priority"
    case parallel = "Parallel"
    case noOptimization = "Default"
}















