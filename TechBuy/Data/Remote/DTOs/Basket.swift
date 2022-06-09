//
//  Basket.swift
//  TechBuy
//
//  Created by Aybars Acar on 9/6/2022.
//

import Foundation

// MARK: - BasketDTO
struct BasketDTO: Codable {
  let id: String
  let items: [BasketItemDTO]
  let deliveryMethodID: Int
  let clientSecret, paymentIntentID: String
  
  enum CodingKeys: String, CodingKey {
    case id, items
    case deliveryMethodID = "delivery_method_id"
    case clientSecret = "client_secret"
    case paymentIntentID = "payment_intent_id"
  }
}

// MARK: - BasketItemDTO
struct BasketItemDTO: Codable {
  let id: Int
  let productName: String
  let price: Double
  let quantity: Int
  let imageURL, brand, type: String
  
  enum CodingKeys: String, CodingKey {
    case id
    case productName = "product_name"
    case price, quantity
    case imageURL = "image_url"
    case brand, type
  }
}
