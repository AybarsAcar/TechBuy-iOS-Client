//
//  LocalBasketRepository.swift
//  TechBuy
//
//  Created by Aybars Acar on 6/6/2022.
//

import Foundation
import CoreData

final class LocalBasketRepository: LocalBasketService {
  
  @Published var itemEntities: [BasketItemEntity] = []
  
  private let container: NSPersistentContainer
  private let containerName = "Basket"
  private let entityName = "BasketItemEntity"
  
  init() {
    container = NSPersistentContainer(name: containerName)
    
    container.loadPersistentStores { _, error in
      if let error = error {
        print("Error loading CoreData:\n\(error)")
      }
      
      if let entities = try? self.getEntities() {
        self.itemEntities = entities
      }
    }
  }
  
  func add(item: BasketItem) {
    let entityToAdd = itemEntities.first(where: { entity in
      return entity.id == item.id
    })
    
    if let entityToAdd = entityToAdd {
      // increment the quantity by 1 if the item already exists
      entityToAdd.quantity += 1
      
      save {
        self.itemEntities.append(entityToAdd)
      }
    }
    else {
      // create new entity
      let entity = BasketItemEntity(context: container.viewContext)
      
      entity.id = Int64(item.id)
      entity.productName = item.productName
      entity.type = item.type
      entity.brand = item.brand
      entity.imageURL = item.imageURL
      entity.price = item.price
      entity.quantity = Int64(item.quantity)
      
      save {
        self.itemEntities.append(entity)
      }
    }
  }
  
  func decreaseQuantity(forItem item: BasketItem) {
    let entity = itemEntities.first(where: { $0.id == item.id })
    
    if let entity = entity {
      if entity.quantity > 1 {
        entity.quantity -= 1
        
        save {

        }
      }
      else {
        delete(item: item)
      }
    }
  }
  
  func getItems() -> [BasketItem] {
    
    do {
      itemEntities = try getEntities()
      
      return itemEntities.compactMap { entity in
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
    let entityToDelete = itemEntities.first(where: { entity in
      return entity.id == item.id
    })
    
    if let entityToDelete = entityToDelete {
      container.viewContext.delete(entityToDelete)
    }
    
    save {
      self.itemEntities = self.itemEntities.filter({ $0.id != entityToDelete?.id })
    }
  }
  
  private func getEntities() throws -> [BasketItemEntity] {
    let request = NSFetchRequest<BasketItemEntity>(entityName: entityName)
    return try container.viewContext.fetch(request);
  }
  
  private func save(didSave: () -> Void) {
    do {
      try container.viewContext.save()
      didSave()
    } catch {
      print("Error saving changes to Core Data:\n\(error)")
    }
  }
}
