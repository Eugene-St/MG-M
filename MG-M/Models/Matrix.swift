//
//  Matrix.swift
//  MG-M
//
//  Created by Eugene St on 16.12.2020.
//

import Foundation

struct Matrix {
    
    var matrixSize: Int
    var values: [[Int]] = []
    
    init(matrixSize: Int, type: MatrixType) {
        self.matrixSize = matrixSize
        
        if type == .zero {
            values = generateZeroMatrix(matrixSize)
        } else {
            values = generateRandomMatrix(size: matrixSize, minElement: 0, maxElement: 100)
        }
    }
    
    ///Generate matrix with 0 as values
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
    
    ///Generate matrix with random elements in range from minElement to maxElement
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
    
    ///Return result of multiplying 2 matrixes
    func multiply(with matrix: Matrix) -> [[Int]] {

        var resultMatrix: [[Int]] = generateZeroMatrix(matrixSize)
        
        for i in 0 ..< matrixSize {
            for j in 0 ..< matrixSize {
                for k in 0 ..< matrixSize {
                    resultMatrix[i][j] +=  matrix.values[i][k] * values[k][j]
                }
            }
        }
        
        return resultMatrix
    }
}

enum MatrixType {
    case zero
    case random
}
