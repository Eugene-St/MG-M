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
        
        return Double(end.uptimeNanoseconds - start.uptimeNanoseconds)
    }
    
    private func generateZeroMatrix(_ size: Int)->[[Int64]]{
        var matrix: [[Int64]] = []
        for _ in 0..<size{
            var row: [Int64] = []
            
            for _ in 0..<size{
                row.append(0)
            }
            
            matrix.append(row)
        }
        return matrix
    }
    
    private func generateRandomMatrix(size: Int, minElement: Int, maxElement: Int)->[[Int64]]{
        var matrix: [[Int64]] = []
        for _ in 0..<size{
            var row: [Int64] = []
            
            for _ in 0..<size{
                row.append(Int64(Int.random(in: minElement...maxElement)))
            }
            
            matrix.append(row)
        }
        return matrix
    }
    
    private func multiplyMatrix(matrixA: [[Int64]], matrixB: [[Int64]])->[[Int64]]{
        let size = matrixA.count
        var resultMatrix: [[Int64]] = generateZeroMatrix(size)
        
        for i in 0 ..< size {
            for j in 0 ..< size {
                for k in 0 ..< size {
                        resultMatrix[i][j] +=  matrixA[i][k] * matrixB[k][j]
                    
                }
            }
        }
        
        print(resultMatrix)
        
        return resultMatrix
    }
    
    private func multiplyManyMatrix(matrixSize: Int, matrixAmount: Int)->[[Int64]]{
        var matrix = generateRandomMatrix(size: matrixSize, minElement: 0, maxElement: 100)
        
        for _ in 0..<matrixAmount{
            matrix = multiplyMatrix(matrixA: matrix, matrixB: generateRandomMatrix(size: matrixSize, minElement: 0, maxElement: 100))
        }
        
        return matrix
    }
}
