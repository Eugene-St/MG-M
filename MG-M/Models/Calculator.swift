//
//  Calculator.swift
//  MG-M
//
//  Created by Eugene St on 18.01.2021.
//

import Foundation

class Calculator {
    
    var calculationSettings = CalculationSettings()
    
    private var matrixes: [[[Int]]] = []
    private var resultsArray: [String : Double] = [:]
    private var startCalculationTime = Date().timeIntervalSinceNow
    
    // MARK: - Start Calculation
    func countTimeOfMultiplying() {
        
        startCalculationTime = Date().timeIntervalSinceReferenceDate
        multiplyManyMatrix(parallelEnabled: DataManager.shared.fetchBool(key: Keys.parallelCalculationSwitchKey ))
        
        //        var start = DispatchTime.now()
        //
        //        multiplyManyMatrix()
        //        let end = DispatchTime.now()
        //
        //        return Double(end.uptimeNanoseconds - start.uptimeNanoseconds)/pow(10, 6)
    }
    
    // MARK: - End Calculation
    func endCalculation() {
        
        let endCalculationTime = Date().timeIntervalSinceReferenceDate
        
        let result = endCalculationTime - startCalculationTime
        
        guard let viewController = self.viewController else { return }
        
        viewController.endCalculation(time: result)
        print(result)
    }
    
    func generateMatrixes() {
        matrixes = []
        for _ in 0..<calculationSettings?.numberOfMatrixes {
            matrixes.append(generateRandomMatrix(size: matrixSize, minElement: 0, maxElement: 100))
        }
    }
    
    private func generateZeroMatrix(_ size: Int) ->[[Int]] {
        var matrix: [[Int]] = []
        for _ in 0..<size {
            var row: [Int] = []
            
            for _ in 0..<size {
                row.append(0)
            }
            
            matrix.append(row)
        }
        return matrix
    }
    
    private func generateRandomMatrix(size: Int, minElement: Int, maxElement: Int) ->[[Int]] {
        var matrix: [[Int]] = []
        for _ in 0..<size {
            var row: [Int] = []
            
            for _ in 0..<size {
                row.append(Int(Int.random(in: minElement...maxElement)))
            }
            
            matrix.append(row)
        }
        return matrix
    }
    
    private func multiplyMatrix(matrixA: [[Int]], matrixB: [[Int]]) {
        
        let size = matrixA.count
        var resultMatrix: [[Int]] = generateZeroMatrix(size)
        
        for i in 0 ..< size {
            for j in 0 ..< size {
                for k in 0 ..< size {
                    resultMatrix[i][j] +=  matrixA[i][k] * matrixB[k][j]
                }
            }
        }
    }
    
    
}

























