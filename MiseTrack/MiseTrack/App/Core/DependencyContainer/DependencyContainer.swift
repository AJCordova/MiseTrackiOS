//
//  DependencyContainer.swift
//  MiseTrack
//
//  Created by Jireh Cordova on 11/12/2025.
//

import Foundation
import SauceServices
import RecipeServices
import ConfigService

public class DependencyContainer: DependencyContainerProtocol {
    
    private var singletons: [ObjectIdentifier: Any] = [:]
    
    private var factories: [ObjectIdentifier: () -> Any] = [:] // closure to create service when called
    
    public init() {
        registerFactories()
    }
    
    func resolve<T>() throws -> T {
        let key = ObjectIdentifier(T.self)
        let typeName = String(describing: T.self)
        
        // check if cached
        if let cached = singletons[key] as? T {
            print("Resolved \(typeName) from cache")
            return cached
        }
        
        print("\(typeName) dependency not cached")
        
        guard let factory = factories[key] else {
            throw DependencyError.dependencyNotRegistered("\(typeName)")
        }
        
        // create if not cached
        guard let instance = factory() as? T else {
            throw DependencyError.invalidDependencyType("\(typeName)")
        }
        
        // cache
        singletons[key] = instance
        print("Cached \(typeName) instance")
        
        return instance
    }
    
    private func registerFactories() {
        
        registerSingleton(SauceServicesProtocol.self) {
            // determine run env / run scheme
            return SauceService()
        }
        
        registerSingleton(RecipeServiceProtocol.self) {
            // determine run env / run scheme
            return RecipeService()
        }
        
        registerSingleton(ConfigProviderProtocol.self) {
            // determine run env / run scheme
            let configService = ConfigService.shared.initConfigService()
            return configService
        }
    }
    
    private func registerSingleton<T>(_ type: T.Type, factory: @escaping () -> T) {
        let key = ObjectIdentifier(T.self)
        factories[key] = factory //
        print("Registered dependency: \(String(describing: T.self))")
    }
}
