//
//  Product.swift
//  TechBuy
//
//  Created by Aybars Acar on 25/5/2022.
//

import SwiftUI

struct Product: Identifiable, Codable {
  var id: Int
  var productImage: String
  var name: String
  var price: Double
  var isLiked: Bool = false
  var productRating: Int
  
  var priceDisplay: String {
    return price.asCurrencyWith2Decimals()
  }
  
  public var productBG: Color {
    
    let colors: [Color] = [.theme.paleBlue, .theme.paleGreen, .theme.palePink, .theme.paleYellow]
    
    return colors.randomElement() ?? .theme.palePink
  }
  
  var dummyText: String {
    return "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Dui accumsan sit amet nulla facilisi morbi. Viverra justo nec ultrices dui sapien eget mi proin. Amet justo donec enim diam vulputate ut. In hendrerit gravida rutrum quisque non tellus. Rhoncus urna neque viverra justo nec ultrices. Scelerisque viverra mauris in aliquam sem. Vitae elementum curabitur vitae nunc sed. Amet nisl suscipit adipiscing bibendum est ultricies integer quis auctor. Aliquam purus sit amet luctus. Rhoncus est pellentesque elit ullamcorper. Aliquam sem fringilla ut morbi. Ante metus dictum at tempor commodo ullamcorper a. Nulla aliquet enim tortor at. Mi proin sed libero enim sed faucibus turpis. Sodales ut eu sem integer vitae justo."
  }
  
  var image: Image? {
    return productImage == "laptop" ? nil : Image(productImage)
  }
}


extension Product {
  static let dummyData = [
    Product(id: 1, productImage: "electronics", name: "Raspberry-Pi", price: 240, productRating: 3),
    Product(id: 2, productImage: "phone", name: "iPhone 13 Pro Max", price: 1270, productRating: 3),
    Product(id: 3, productImage: "laptop", name: "Macbook Pro 16", price: 3420, isLiked: true, productRating: 3),
    Product(id: 4, productImage: "headphone", name: "Sony XM-4", price: 240, productRating: 3)
  ]
}

