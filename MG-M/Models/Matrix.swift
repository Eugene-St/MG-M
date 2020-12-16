//
//  Matrix.swift
//  MG-M
//
//  Created by Eugene St on 16.12.2020.
//

import Foundation

struct Matrix {
    var matrixSize: Int
    var numberOfMatrix: Int
    
    init(matrixSize: Int = 5, numberOfMatrix: Int = 2) {
        self.matrixSize = matrixSize
        self.numberOfMatrix = numberOfMatrix
    }
    
    func countTimeOfMultiplying()-> Double {
            let start = DispatchTime.now()
            
            multiplyManyMatrix(matrixSize: self.matrixSize, matrixAmount: self.numberOfMatrix)
            
            let end = DispatchTime.now()

            return Double(end.uptimeNanoseconds - start.uptimeNanoseconds)
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
                    row.append(Int.random(in: minElement...maxElement))
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
                        resultMatrix[i][j] += matrixA[i][k] * matrixB[k][j]
                    }
                }
            }
            
            return resultMatrix
        }

        private func multiplyManyMatrix(matrixSize: Int, matrixAmount: Int)->[[Int]]{
            var matrix = generateRandomMatrix(size: matrixSize, minElement: 0, maxElement: 100)
            
            for _ in 0..<matrixAmount{
                matrix = multiplyMatrix(matrixA: matrix, matrixB: generateRandomMatrix(size: matrixSize, minElement: 0, maxElement: 100))
            }
            
            return matrix
        }
        
    }
