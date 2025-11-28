//
//  SwinjectContainer.swift
//  DidiSwinject
//
//  Created by Antonio Pantaleo on 27/11/25.
//

import Didi
import Swinject

/// A `Container` adapter backed by a Swinject `Container`.
public final class SwinjectContainer: Didi.Container {
    
    private let container: Swinject.Container
    
    /// Creates a new adapter around an existing or fresh Swinject container.
    /// - Parameter container: The underlying Swinject container to use. Defaults to a new container.
    public init(container: Swinject.Container = Swinject.Container()) {
        self.container = container
    }
    
    /// Stores a registration in the underlying Swinject container.
    /// - Parameter component: A closure producing the registration to store.
    public func register<P>(_ component: () -> Registration<P>) {
        let (service, factory) = component()
        container.register(service, factory: { _ in factory() })
    }
    
    /// Resolves a service from the underlying container, translating missing services into `ResolutionError`.
    /// - Parameter type: The type to resolve.
    /// - Returns: An instance of the requested type.
    public func resolve<P>(_ type: P.Type) throws(ResolutionError<P>) -> P {
        guard let resolved = container.resolve(type) else {
            throw ResolutionError(type: type)
        }
        return resolved
    }
}
