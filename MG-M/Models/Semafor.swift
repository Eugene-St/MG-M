//
//  Semafor.swift
//  MG-M
//
//  Created by Eugene St on 15.01.2021.
//

import Foundation

struct Semafor {
    
    static var shared = Semafor()
    private init(){}
    
    var counter = 0
    var matrixClass: Matrix?
    
    mutating func addOne() {
        counter += 1
    }
    
    mutating func minusOne() {
        counter -= 1
        
        if counter == 0 {
            matrixClass?.endCalculation()
        }
    }
}





