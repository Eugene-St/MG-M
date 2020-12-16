//
//  Matrix.swift
//  MG-M
//
//  Created by Eugene St on 16.12.2020.
//

import Foundation

struct Matrix {
    
    private var matrixSize = 5
    private var numberOfMatrix = 3
    private var matrixes: [[[Int]]] = []

    mutating func setMatrixSize(_ value: Int?){
        if let safeData = value{
            self.matrixSize = safeData
        }
    }
    
    mutating func setNumberOfMatrixe(_ value: Int?){
        if let safeData = value{
            self.numberOfMatrix = safeData
        }
    }
    
    func countTimeOfMultiplying() -> Double {
        let start = DispatchTime.now()
        
        multiplyManyMatrix(matrixSize: self.matrixSize, matrixAmount: self.numberOfMatrix)
    
        let end = DispatchTime.now()
        
        return Double(end.uptimeNanoseconds - start.uptimeNanoseconds)/pow(10, 6)
    }
    
    mutating func generateMatrixes() {
        for _ in 0..<numberOfMatrix {
            matrixes.append(generateRandomMatrix(size: matrixSize, minElement: 0, maxElement: 100))
        }
    }
    
    private func generateZeroMatrix(_ size: Int)->[[Int]]{
        var matrix: [[Int]] = []
        for _ in 0..<size{
            var row: [Int] = []
            
            for _ in 0..<size{
                row.append(0)
            }
            
            matrix.append(row)
        }
        return matrix
    }
    
    private func generateRandomMatrix(size: Int, minElement: Int, maxElement: Int)->[[Int]]{
        var matrix: [[Int]] = []
        for _ in 0..<size{
            var row: [Int] = []
            
            for _ in 0..<size{
                row.append(Int(Int.random(in: minElement...maxElement)))
            }
            
            matrix.append(row)
        }
        return matrix
    }
    
    private func multiplyMatrix(matrixA: [[Int]], matrixB: [[Int]])->[[Int]]{
        let size = matrixA.count
        var resultMatrix: [[Int]] = generateZeroMatrix(size)
        
        for i in 0 ..< size {
            for j in 0 ..< size {
                for k in 0 ..< size {
                        resultMatrix[i][j] +=  matrixA[i][k] * matrixB[k][j]
                    
                }
            }
        }
        
        return resultMatrix
    }
    
    private func multiplyManyMatrix(matrixSize: Int, matrixAmount: Int){
        for i in 0..<matrixes.count-1{
            multiplyMatrix(matrixA: matrixes[i], matrixB: matrixes[i+1])
        }
    }
}
