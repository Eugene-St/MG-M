//
//  Matrix.swift
//  MG-M
//
//  Created by Eugene St on 16.12.2020.
//

import Foundation

struct Matrix {
    let matrixSize: Int
    let numberOfMatrix: Int
    
    init(matrixSize: Int = 5, numberOfMatrix: Int = 2) {
        self.matrixSize = matrixSize
        self.numberOfMatrix = numberOfMatrix
    }
    
    func myltiplyMatrix(size: Int, numberOfMatrix: Int) {
        print("\(size) \(numberOfMatrix)")
    }
    

    
}
