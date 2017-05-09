//
//  SequenceDataManager.swift
//  InfraTest
//
//  Created by Васильев Андрей on 09.05.17.
//  Copyright © 2017 Васильев Андрей. All rights reserved.
//

import Foundation

class SequenceDataManager: SequenceDataManagerProtocol {
    
    fileprivate init() {}
    
    lazy var currentSequence: String = {
        return UserDefaults.standard.string(forKey: "lastSequence") ?? ""
    }()
    
    func update(string: String) {
        self.currentSequence = string
    }
    
    func save() {
        UserDefaults.standard.set(currentSequence, forKey: "lastSequence")
    }
    
    func read() -> String {
        return currentSequence
    }
}

struct SequenceDataManagerInjector {
    static var sequenceDataManager: SequenceDataManagerProtocol = SequenceDataManager()
}

protocol SequenceDataManagerProtocol {
    func update(string: String)
    func save()
    func read() -> String
}
