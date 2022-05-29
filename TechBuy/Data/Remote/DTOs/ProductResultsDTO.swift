//
//  ProductResultsDTO.swift
//  TechBuy
//
//  Created by Aybars Acar on 29/5/2022.
//

import Foundation

// MARK: - ProductResultsDTO
struct ProductResultsDTO: Codable {
  let pageIndex, pageSize, pageCount: Int
  let data: [ProductDTO]
  
  enum CodingKeys: String, CodingKey {
    case pageIndex = "page_index"
    case pageSize = "page_size"
    case pageCount = "page_count"
    case data
  }
}

// MARK: - ProductDTO
struct ProductDTO: Codable {
  let id: Int
  let name, description: String
  let price: Double
  let imageURL: String
  let productType, productBrand: String
  
  enum CodingKeys: String, CodingKey {
    case id, name, description, price
    case imageURL = "image_url"
    case productType = "product_type"
    case productBrand = "product_brand"
  }
}

// MARK: - Mappers
extension ProductDTO {
  
  /// Maps the Product DTO into a Product Model for UI use
  func toProduct() -> Product {
    return Product(id: self.id, productImage: "", name: "", price: 0, productRating: 1)
  }
}
