//
//  Resolver.swift
//  TechBuy
//
//  Created by Aybars Acar on 26/5/2022.
//

import Foundation
import Swinject

/// Utility Resolver class to resolve dependencies from the container
final class Resolver {
  static let shared = Resolver()
  
  private var container = buildContainer()
  
  func resolve<T>(_ type: T.Type) -> T {
    container.resolve(T.self)!
  }
}

/// Builds the Swinject Dependency Container
fileprivate func buildContainer() -> Container {
  let container = Container()
  
  container.register(ImageService.self) { _ in
    return CloudinaryService()
  }
  .inObjectScope(.container)
  
  container.register(ProductService.self) { _ in
    return ProductRepository()
  }
  .inObjectScope(.container)
  
  container.register(LocalBasketService.self) { _ in
    return LocalBasketRepository()
  }
  .inObjectScope(.container)
  
  container.register(AccountService.self) { _ in
    return AccountRepository()
  }
  .inObjectScope(.container)
  
  return container
}
