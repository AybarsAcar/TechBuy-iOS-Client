//
//  OrderDTO.swift
//  TechBuy
//
//  Created by Aybars Acar on 13/6/2022.
//

import Foundation

// MARK: - OrderDTO
struct OrderDTO: Codable {
  let basketID: String
  let deliveryMethodID: Int
  let shipToAddress: AddressDTO
  
  enum CodingKeys: String, CodingKey {
    case basketID = "basket_id"
    case deliveryMethodID = "delivery_method_id"
    case shipToAddress = "ship_to_address"
  }
}

// MARK: - Address
struct AddressDTO: Codable {
  let firstName, lastName, street, city: String
  let state, postCode: String
  
  enum CodingKeys: String, CodingKey {
    case firstName = "first_name"
    case lastName = "last_name"
    case street, city, state
    case postCode = "post_code"
  }
}
