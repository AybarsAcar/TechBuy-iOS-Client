//
//  BasketItem.swift
//  TechBuy
//
//  Created by Aybars Acar on 9/6/2022.
//

import Foundation

struct BasketItem: Identifiable, Hashable {
  let id: Int
  let productName: String
  let price: Double
  var quantity: Int
  let imageURL, brand, type: String
  
  var priceDisplay: String {
    return price.asCurrencyWith2Decimals()
  }
}
