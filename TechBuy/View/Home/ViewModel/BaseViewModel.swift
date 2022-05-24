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
}

// tab items
enum Tab: String {
case home = "house"
case heart = "heart.fill"
case clipboard = "rectangle.grid.3x2.fill"
case person = "person.fill"
}
