//
//  BasketViewModel.swift
//  TechBuy
//
//  Created by Aybars Acar on 9/6/2022.
//

import Foundation

final class BasketViewModel: ObservableObject {
  @Published private(set) var items = [BasketItem]()
  
  let shippingCost = 9.99
  
  var total: Double {
    subTotal + shippingCost
  }
  
  var subTotal: Double {
    items.reduce(into: 0) { partialResult, item in
      partialResult += (item.price * Double(item.quantity))
    }
  }
  
  @Inject private var localBasketService: LocalBasketService
  
  init() {
    loadBasketItems()
  }
  
  func add(item: BasketItem) {
    if !items.contains(where: { $0.id == item.id }) {
      items.append(item)
      localBasketService.add(item: item)
    }
    else {
      increaseQuantity(for: item)
    }
  }
  
  func delete(item: BasketItem) {
    if let index = items.firstIndex(of: item) {
      items.remove(at: index)
      localBasketService.delete(item: item)
    }
  }
  
  func increaseQuantity(for item: BasketItem) {
    let index = items.firstIndex(where: { $0.id == item.id })
    
    if let index = index {
      items[index].quantity += 1
      localBasketService.add(item: item)
    }
  }
  
  func decreaseQuantity(for item: BasketItem) {
    let index = items.firstIndex(where: { $0.id == item.id })
    
    if let index = index {
      items[index].quantity -= 1
      
      if items[index].quantity <= 0 {
        remove(item: item)
      }
      
      localBasketService.decreaseQuantity(forItem: item)
    }
  }
  
  private func loadBasketItems() {
    items = localBasketService.getItems()
  }
  
  func remove(item: BasketItem) {
    items.removeAll(where: { $0.id == item.id })
  }
}
