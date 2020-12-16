//
//  DataManager.swift
//  MG-M
//
//  Created by Eugene St on 16.12.2020.
//

import Foundation

struct DataManager {
    static let shared = DataManager()
    
    private let userDefaults = UserDefaults.standard

    func saveData(_ value: Any?, key: String){
        userDefaults.set(value, forKey: key)
    }
    
    func fetchInt(key: String) -> Int{
        return userDefaults.integer(forKey: key)
    }
    
    func fetchDouble(key: String) -> Double{
        return userDefaults.double(forKey: key)
    }
    
    func fetchBool(key: String) -> Bool{
        return userDefaults.bool(forKey: key)
    }
    
    private init(){}
}
