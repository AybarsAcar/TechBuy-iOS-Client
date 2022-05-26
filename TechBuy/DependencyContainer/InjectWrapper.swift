//
//  InjectWrapper.swift
//  TechBuy
//
//  Created by Aybars Acar on 26/5/2022.
//

import Foundation

/// property wrapper to automatically inject dependencies through initialiser
/// ```
/// @Inject myDependency: DependencyProtocol
/// ```
@propertyWrapper
struct Inject<T> {
  let wrappedValue: T
  
  init() {
    // resolve the interface to an implementation
    self.wrappedValue = Resolver.shared.resolve(T.self)
  }
}
