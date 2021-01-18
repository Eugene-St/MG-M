//
//  Matrix.swift
//  MG-M
//
//  Created by Eugene St on 16.12.2020.
//

import Foundation

class Matrix {
    
    private var matrixSize = 5
    private var numberOfMatrix = 3
    private var matrixes: [[[Int]]] = []
    
    weak var viewController: MainViewController?
    
    init(viewController: MainViewController) {
        self.viewController = viewController
    }
    
    private var startCalculationTime = Date().timeIntervalSinceNow
    
    func setMatrixSize(_ value: Int?) {
        if let safeData = value {
            self.matrixSize = safeData
        }
    }
    
    func setNumberOfMatrixes(_ value: Int?) {
        if let safeData = value {
            self.numberOfMatrix = safeData
        }
    }
    
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
        for _ in 0..<numberOfMatrix {
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
     
    private func multiplyManyMatrix(parallelEnabled: Bool) {

        if parallelEnabled {
            for i in 0..<matrixes.count - 1 {

                Semafor.shared.addOne()

                DispatchQueue.global(qos: .userInitiated).async {
                    self.multiplyMatrix(matrixA: self.matrixes[i], matrixB: self.matrixes[i+1])
                    Semafor.shared.minusOne()
                }
            }
        } else {
            for i in 0..<matrixes.count - 1 {
                self.multiplyMatrix(matrixA: self.matrixes[i], matrixB: self.matrixes[i+1])
            }
        }
    }
    
//    func startCalculation() {
//        if DataManager.shared.fetchBool(key: Keys.backgroundThreadSwitchKey) {
//            DispatchQueue.global(qos: .background).async(group: taskGroup) {
//                self.matrix?.countTimeOfMultiplying()
//            }
//        }
//
//        if DataManager.shared.fetchBool(key: Keys.priorityThreadSwitchKey) {
//            DispatchQueue.global(qos: .userInteractive).async(group: taskGroup) {
//                self.matrix?.countTimeOfMultiplying()
//            }
//        }
//
//        DispatchQueue.main.async(group: taskGroup) {
//            self.matrix?.countTimeOfMultiplying()
//        }
//    }
}
