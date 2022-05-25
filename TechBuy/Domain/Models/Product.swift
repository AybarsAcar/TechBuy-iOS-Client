//
//  Product.swift
//  TechBuy
//
//  Created by Aybars Acar on 25/5/2022.
//

import SwiftUI

struct Product: Identifiable, Codable {
  var id = UUID().uuidString
  var productImage: String
  var productTitle: String
  var productPrice: String
  var isLiked: Bool = false
  var productRating: Int
  
  public var productBG: Color {
    
    let colors: [Color] = [.theme.paleBlue, .theme.paleGreen, .theme.palePink, .theme.paleYellow]
    
    return colors.randomElement() ?? .theme.palePink
  }
  
  var dummyText: String {
    return "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Dui accumsan sit amet nulla facilisi morbi. Viverra justo nec ultrices dui sapien eget mi proin. Amet justo donec enim diam vulputate ut. In hendrerit gravida rutrum quisque non tellus. Rhoncus urna neque viverra justo nec ultrices. Scelerisque viverra mauris in aliquam sem. Vitae elementum curabitur vitae nunc sed. Amet nisl suscipit adipiscing bibendum est ultricies integer quis auctor. Aliquam purus sit amet luctus. Rhoncus est pellentesque elit ullamcorper. Aliquam sem fringilla ut morbi. Ante metus dictum at tempor commodo ullamcorper a. Nulla aliquet enim tortor at. Mi proin sed libero enim sed faucibus turpis. Sodales ut eu sem integer vitae justo."
  }
}


extension Product {
  static let dummyData = [
    Product(productImage: "electronics", productTitle: "Raspberry-Pi", productPrice: "$240.0", productRating: 3),
    Product(productImage: "phone", productTitle: "iPhone 13 Pro Max", productPrice: "$1,240.0", productRating: 3),
    Product(productImage: "laptop", productTitle: "Macbook Pro 16", productPrice: "$3,420.0", isLiked: true, productRating: 3),
    Product(productImage: "headphone", productTitle: "Sony XM-4", productPrice: "$240.0", productRating: 3)
  ]
}

