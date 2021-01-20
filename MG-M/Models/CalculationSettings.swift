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
            return DataManager.shared.saveData(newValue, key: Keys.numberOfMatrixKey.rawValue)
        }
    }
    
    var matrixSize: Int {
        willSet {
            return DataManager.shared.saveData(newValue, key: Keys.matrixSizeKey.rawValue)
        }
    }
    
    var backgroundOptimization: Bool {
        willSet {
            return DataManager.shared.saveData(newValue, key: Keys.backgroundThreadSwitchKey.rawValue)
        }
    }
    
    var priorityOptimization: Bool {
        willSet {
            return DataManager.shared.saveData(newValue, key: Keys.priorityThreadSwitchKey.rawValue)
        }
    }
    
    var parallelOptimization: Bool {
        willSet {
            return DataManager.shared.saveData(newValue, key: Keys.parallelCalculationSwitchKey.rawValue)
        }
    }
    
    var optimizations: [Optimizations] = [.noOptimization]
    
    init() {
        let numberOfMatrixes = DataManager.shared.fetchInt(key: Keys.numberOfMatrixKey.rawValue)
        self.numberOfMatrixes = numberOfMatrixes == 0 ? 3 : numberOfMatrixes
        DataManager.shared.saveData(self.numberOfMatrixes, key: Keys.numberOfMatrixKey.rawValue)
        
        let matrixSize = DataManager.shared.fetchInt(key: Keys.matrixSizeKey.rawValue)
        self.matrixSize = matrixSize == 0 ? 5 : matrixSize
        DataManager.shared.saveData(self.matrixSize, key: Keys.matrixSizeKey.rawValue)
        
        let backgroundOptimization = DataManager.shared.fetchBool(key: Keys.backgroundThreadSwitchKey.rawValue)
        self.backgroundOptimization = backgroundOptimization == false ? false : backgroundOptimization
        DataManager.shared.saveData(self.backgroundOptimization, key: Keys.backgroundThreadSwitchKey.rawValue)
        
        let priorityOptimization = DataManager.shared.fetchBool(key: Keys.priorityThreadSwitchKey.rawValue)
        self.priorityOptimization = priorityOptimization == false ? false : priorityOptimization
        DataManager.shared.saveData(self.priorityOptimization, key: Keys.priorityThreadSwitchKey.rawValue)
        
        let parallelOptimization = DataManager.shared.fetchBool(key: Keys.parallelCalculationSwitchKey.rawValue)
        self.parallelOptimization = parallelOptimization == false ? false : parallelOptimization
        DataManager.shared.saveData(self.parallelOptimization, key: Keys.parallelCalculationSwitchKey.rawValue)
    }
}

enum Optimizations: String {
    case background = "Background"
    case priority = "Priority"
    case parallel = "Parallel"
    case noOptimization = "Default"
}















