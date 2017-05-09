//
//  SequenceLogic.swift
//  InfraTest
//
//  Created by Васильев Андрей on 09.05.17.
//  Copyright © 2017 Васильев Андрей. All rights reserved.
//

import Foundation

class SequenceLogicImpl: SequenceLogic {
    let separatorsSet: CharacterSet = CharacterSet([",", " "])
    
    
    func inferenceSequenceType(fromString string: String) -> SequenceType? {
        print(string.components(separatedBy: separatorsSet))
        let components = string.components(separatedBy: separatorsSet)
            .filter {
                !$0.isEmpty
            }
        
        guard let doubleValues = transform(strings: components), doubleValues.count > 2 else {
            return nil
        }
        
        return checkPatterns(doubleValues: doubleValues)
    }
    
    private func checkPatterns(doubleValues: [Double]) -> SequenceType {
        var actualDifference: Double? = doubleValues[1] - doubleValues[0]
        var actualMultiplier: Double? = doubleValues[1] / doubleValues[0]

        for index in 1..<doubleValues.count {
            if actualDifference != nil {
                if !(doubleValues[index] - doubleValues[index - 1] == actualDifference) {
                    if actualMultiplier == nil {
                        return .random
                    }
                    
                    actualDifference = nil
                }
            }
            
            if actualMultiplier != nil {
                if !(doubleValues[index] / doubleValues[index - 1] == actualMultiplier) {
                    if actualDifference == nil {
                        return .random
                    }
                    
                    actualMultiplier = nil
                    
                }
            }
        }
        
        if actualDifference != nil {
            return actualDifference == 0 ? .constant : .arithmetic
        } else {
            return .geometric
        }
    }
    
    private func transform(strings: [String]) -> [Double]? {
        var result = [Double]()
        for string in strings {
            guard let double = Double(string) else {
                return nil
            }
            result.append(double)
        }
        return result
    }
}



protocol SequenceLogic {
    func inferenceSequenceType(fromString string: String) -> SequenceType?
}

enum SequenceType: String {
    case arithmetic = "Арифметическая"
    case geometric = "Геометрическая"
    case constant = "Постоянная"
    case random = "Произвольная"
}
