//
//  LocalBasketRepository.swift
//  TechBuy
//
//  Created by Aybars Acar on 6/6/2022.
//

import Foundation
import CoreData

final class LocalBasketRepository: LocalBasketService {
  
  private let container: NSPersistentContainer
  private let containerName = "BasketContainer"
  private let entityName = "BasketItemEntity"
  
  init() {
    container = NSPersistentContainer(name: containerName)
    
    container.loadPersistentStores { _, error in
      if let error = error {
        print("Error loading CoreData:\n\(error)")
      }
    }
  }
  
  func add(item: BasketItem) {
    let entity = BasketItemEntity(context: container.viewContext)
    
    entity.id = Int64(item.id)
    entity.productName = item.productName
    entity.type = item.type
    entity.brand = item.brand
    entity.imageURL = item.imageURL
    entity.price = item.price
    entity.quantity = Int64(item.quantity)
    
    save()
  }
  
  func getItems() -> [BasketItem] {

    do {
      let entities = try getEntities()
      return entities.compactMap { entity in
        BasketItem(
          id: Int(entity.id),
          productName: entity.productName ?? "",
          price: entity.price,
          quantity: Int(entity.quantity),
          imageURL: entity.imageURL ?? "",
          brand: entity.brand ?? "",
          type: entity.type ?? ""
        )
      }
 
    } catch {
      print("Error fetching \(error)")
      return []
    }
  }
  
  func delete(item: BasketItem) {
    let entities = try? getEntities()
    
    let entityToDelete = entities?.first(where: { entity in
      return entity.id == item.id
    })
    
    if let entityToDelete = entityToDelete {
      container.viewContext.delete(entityToDelete)
    }
  }
  
  private func getEntities() throws -> [BasketItemEntity] {
    let request = NSFetchRequest<BasketItemEntity>(entityName: entityName)
    return try container.viewContext.fetch(request);
  }
  
  private func save() {
    do {
      try container.viewContext.save()
    } catch {
      print("Error saving changes to Core Data:\n\(error)")
    }
  }
}
