//
//  RepositoryManager.swift
//  YouTube Network2
//
//  Created by Viktor Pechersky on 23.10.2018.
//  Copyright © 2018 Viktor Pecherskyi. All rights reserved.
//

import Foundation

class RepositoryManager {

    static var shared = RepositoryManager()

    var storage: LocalStorage
    
    private init() {
        storage = DefaultsStorage()
    }
}
