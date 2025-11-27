//
//  DidiSwinjectTests.swift
//  DidiSwinject
//
//  Created by Antonio Pantaleo on 27/11/25.
//

import Testing
import Didi
import DidiSwinject
import Swinject

@Suite
struct DidiSwinjectTests {
    @Test func resolvesRegisteredService() throws {
        let sut = SwinjectContainer()
        sut.register {
            Int.self ~> 2
        }
        
        let resolved = try sut.resolve(Int.self)
        #expect(resolved == 2)
    }
    
    @Test func writesIntoProvidedUnderlyingContainer() throws {
        let expected = "Hello world!"
        let underlying = Swinject.Container()
        let sut = SwinjectContainer(container: underlying)
        
        sut.register { String.self ~> expected }
        
        let resolvedFromUnderlying = underlying.resolve(String.self)
        #expect(resolvedFromUnderlying == expected)
        #expect(try sut.resolve(String.self) == expected)
    }
    
    @Test func throwsResolutionErrorWhenServiceMissing() {
        let sut = SwinjectContainer()
        
        #expect(throws: ResolutionError<String>.self) {
            _ = try sut.resolve(String.self)
        }
    }
    
    @Test func propertyWrapperResolvesThroughAdapter() {
        let sut = SwinjectContainer()
        sut.register { Double.self ~> 4.5 }
        
        @Injected(in: sut) var value: Double?
        #expect(value == 4.5)
    }
}
