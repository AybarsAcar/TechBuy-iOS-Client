//
//  Product.swift
//  TechBuy
//
//  Created by Aybars Acar on 25/5/2022.
//

import SwiftUI

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
