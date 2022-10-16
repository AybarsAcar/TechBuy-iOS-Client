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
  @StateObject private var networkMonitor = NetworkMonitor()

  var body: some Scene {
    WindowGroup {
      ContentView()
        .environmentObject(accountViewModel)
        .environmentObject(networkMonitor)
        .preferredColorScheme(.light)
    }
  }
}
