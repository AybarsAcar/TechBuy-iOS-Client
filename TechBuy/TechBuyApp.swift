//
//  TechBuyApp.swift
//  TechBuy
//
//  Created by Aybars Acar on 24/5/2022.
//

import SwiftUI

@main
struct TechBuyApp: App {
  
  @StateObject private var accountViewModel = AccountViewModel()
  
  var body: some Scene {
    WindowGroup {
      ContentView()
        .environmentObject(accountViewModel)
        .preferredColorScheme(.light)
    }
  }
}
