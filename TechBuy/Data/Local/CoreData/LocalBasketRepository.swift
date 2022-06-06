//
//  LocalBasketRepository.swift
//  TechBuy
//
//  Created by Aybars Acar on 6/6/2022.
//

import Foundation
import CoreData

final class LocalBasketRepository: LocalBasketService {
  
  @Published private(set) var basketEntity: BasketEntity?
  
  private let container: NSPersistentContainer
  private let containerName = "BasketContainer"
  private let entityName = "BasketEntity"
  
  init() {
    container = NSPersistentContainer(name: containerName)
    
    container.loadPersistentStores { _, error in
      if let error = error {
        print("Error loading CoreData:\n\(error)")
      }
    }
  }
  
  
  func getBasket() {
    let request = NSFetchRequest<BasketEntity>(entityName: entityName)
  }
  
  func updateCreate(basket: String) {
    
  }
  
  func deleteBasket() {
    
  }
}
