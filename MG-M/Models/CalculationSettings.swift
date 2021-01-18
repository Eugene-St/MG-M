//
//  CalculationSettings.swift
//  MG-M
//
//  Created by Eugene St on 18.01.2021.
//

import Foundation

struct CalculationSettings {
    
    var numberOfMatrixes: Int = 3 {
        willSet {
            return DataManager.shared.saveData(newValue, key: Keys.numberOfMatrixKey)
        }
    }
    
    var matrixSize: Int = 5 {
        willSet {
            return DataManager.shared.saveData(newValue, key: Keys.matrixSizeKey)
        }
    }
    
    var optimizations: [Optimizations] = [
        .noOptimization,
        .background,
        .priority,
        .parallel
    ]
    init() {
        self.numberOfMatrixes = DataManager.shared.fetchInt(key: Keys.numberOfMatrixKey)
        self.matrixSize = DataManager.shared.fetchInt(key: Keys.matrixSizeKey)
    }
}

enum Optimizations {
    case noOptimization
    case background
    case priority
    case parallel
}















