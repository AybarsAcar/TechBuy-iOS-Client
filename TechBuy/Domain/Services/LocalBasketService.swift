//
//  LocalBasketService.swift
//  TechBuy
//
//  Created by Aybars Acar on 6/6/2022.
//

import Foundation

/// Protocol Stub that retrieves Shopping Basket from devices local database - CoreDate
protocol LocalBasketService {
  
  /// returns the basket stored in local Device database
  func getBasket()
  
  /// updates the basket if it exists
  /// if a basket does not exist creates a new one
  func updateCreate(basket: String)
  
  /// removes all the items in the basket and clears it
  func deleteBasket()
}
