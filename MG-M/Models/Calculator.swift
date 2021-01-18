//
//  Calculator.swift
//  MG-M
//
//  Created by Eugene St on 18.01.2021.
//

import Foundation

class Calculator {
    
    let settings: CalculationSettings
    let endCalculation: (([String : Double]) -> Void)
    
    var matrixes: [Matrix] = []
    var resultsArray: [String : Double] = [:]
    
    private var startCalculationTime = Date().timeIntervalSinceReferenceDate
    
    init(settings: CalculationSettings, endCalculation: @escaping (([String : Double]) -> Void)) {
        self.settings = settings
        self.endCalculation = endCalculation
        
        generateMatrixes()
    }
    
    private var calculationIndex = 0
    
    //MARK: - Semafor
    private var semaforValue = 0
    private var semafor: Int {
        set {
            semaforValue = newValue
            if newValue == 0 {
                let endCalculationTime = Date().timeIntervalSinceReferenceDate
                
                resultsArray[settings.optimizations[calculationIndex-1].rawValue] = endCalculationTime - startCalculationTime
                
                if calculationIndex < settings.optimizations.count {
                    countTime(for: settings.optimizations[calculationIndex])
                } else {
                    DispatchQueue.main.async {
                        self.endCalculation(self.resultsArray)
                    }
                }
                calculationIndex += 1
            }
        }
        get {
            return semaforValue
        }
    }
    
    //MARK: Start calculation
    func startCalculation() {
        countTime(for: settings.optimizations[calculationIndex])
        calculationIndex += 1
    }
    
    //MARK: - Count time
    private func countTime(for type: Optimizations){
        startCalculationTime = Date().timeIntervalSinceReferenceDate
        
        switch type {
        case .background:
            backgroundMultiplication()
        case .parallel:
            parallelMultiplication()
        case .priority:
            priorityCalculation()
        default:
            defualtCalculation()
        }
    }
    
    //MARK: - Generate Matrixes
    func generateMatrixes() {
        for _ in 0..<settings.numberOfMatrixes {
            matrixes.append(Matrix(matrixSize: settings.matrixSize, type: .random))
        }
    }
    
    //MARK: - Multiply matrixes methods
    private func parallelMultiplication() {
        for i in 0..<matrixes.count - 1 {
            
            semafor += 1
            DispatchQueue.global(qos: .userInitiated).async {
                self.matrixes[i].multiply(with: self.matrixes[i+1])
                self.semafor -= 1
            }
        }
    }
    
    private func backgroundMultiplication() {
        semafor += 1
        DispatchQueue.global(qos: .background).async {
            for i in 0..<self.matrixes.count - 1 {
                self.matrixes[i].multiply(with: self.matrixes[i+1])
            }
            self.semafor -= 1
        }
    }
    
    private func priorityCalculation() {
        semafor += 1
        DispatchQueue.global(qos: .userInitiated).async {
            for i in 0..<self.matrixes.count - 1 {
                self.matrixes[i].multiply(with: self.matrixes[i+1])
            }
            self.semafor -= 1
        }
    }
    
    private func defualtCalculation() {
        semafor += 1
        DispatchQueue.main.async {
            for i in 0..<self.matrixes.count - 1 {
                self.matrixes[i].multiply(with: self.matrixes[i+1])
            }
            self.semafor -= 1
        }
    }
}

























