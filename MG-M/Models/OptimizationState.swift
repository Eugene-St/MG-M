//
//  OptimizationState.swift
//  MG-M
//
//  Created by Eugene St on 14.01.2021.
//

struct OptimizationState {
   
    private var noOptimization = true
    private var bacgroundOn = DataManager.shared.fetchBool(key: Keys.backgroundThreadSwitchKey)
    private var priorityOn = DataManager.shared.fetchBool(key: Keys.priorityThreadSwitchKey)
    private var parallelOn = DataManager.shared.fetchBool(key: Keys.parallelCalculationSwitchKey)

}
