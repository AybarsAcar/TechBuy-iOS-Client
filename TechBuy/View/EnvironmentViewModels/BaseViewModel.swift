//
//  BaseViewModel.swift
//  TechBuy
//
//  Created by Aybars Acar on 24/5/2022.
//

import SwiftUI

final class BaseViewModel: ObservableObject {
  
  // Tab bar
  @Published var currentTab: Tab = .home
  
  // basket sheet
  @Published var showBasket = false
  
  @Published var showSideBar = false
  
  // Detail View properties
  @Published private(set) var currentProduct: Product?
  @Published private(set) var showDetail = false
  
  public func dismissDetailView() {
    currentProduct = nil
    showDetail = false
  }
  
  public func navigate(to product: Product) {
    currentProduct = product
    showDetail = true
  }
}

// tab items
enum Tab: String {
  case home = "house"
  case heart = "heart.fill"
  case clipboard = "rectangle.grid.3x2.fill"
  case person = "person.fill"
}
