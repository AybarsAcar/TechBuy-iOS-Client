//
//  Product.swift
//  TechBuy
//
//  Created by Aybars Acar on 25/5/2022.
//

import SwiftUI

// MARK: - Product Model
struct Product: Identifiable, Codable {
  var id: Int
  var imageURL: String
  var name: String
  var description: String
  var price: Double
  var isLiked: Bool = false
  var productRating: Int
  let productType: String
  let productBrand: String
  
  var priceDisplay: String {
    return price.asCurrencyWith2Decimals()
  }
  
  public var productBG: Color {
    
    let colors: [Color] = [.theme.paleBlue, .theme.paleGreen, .theme.palePink, .theme.paleYellow]
    
    return colors.randomElement() ?? .theme.palePink
  }
}

// MARK: - ProductType Enum
enum ProductType: String, CaseIterable {
  case all = "All"
  case laptop = "Laptops"
  case phone = "Phones"
  case tablet = "Tablets"
  case watch = "Watches"
  case headphone = "Headphones"
  case other = "Other"
  
  var image: Image {
    switch self {
    case .all:
      return .all
    case .laptop:
      return Image.laptop
    case .phone:
      return Image.phone
    case .tablet:
      return Image.tablet
    case .watch:
      return Image.watch
    case .headphone:
      return Image.headphone
    case .other:
      return Image.electronics
    }
  }
  
  var identifier: String? {
    switch self {
    case .all:
      return nil
    case .laptop:
      return "4"
    case .phone:
      return "3"
    case .tablet:
      return "2"
    case .watch:
      return "1"
    case .headphone:
      return "5"
    case .other:
      return "6"
    }
  }
}
