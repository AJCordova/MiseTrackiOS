//
//  DependencyContainerProtocol.swift
//  MiseTrack
//
//  Created by Jireh Cordova on 11/12/2025.
//

protocol DependencyContainerProtocol {
    func resolve<T>() throws -> T
}

enum DependencyError: Error {
    case dependencyNotRegistered(String)
    case invalidDependencyType(String)
    
    public var errorDescription: String? {
        switch(self) {
        case .dependencyNotRegistered(let name):
            return "Dependency not registered: \(name)"
            
        case .invalidDependencyType(let name):
            return "Dependency not registered: \(name)"
        }
    }
}
