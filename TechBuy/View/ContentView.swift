//
//  ContentView.swift
//  TechBuy
//
//  Created by Aybars Acar on 24/5/2022.
//

import SwiftUI

struct ContentView: View {
  
  @StateObject private var baseData = BaseViewModel()
  
  var body: some View {
    TabBar()
      .environmentObject(baseData)
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
