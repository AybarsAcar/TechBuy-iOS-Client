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
    ZStack {
      TabBar()
      
      SidebarView(show: $baseData.showSideBar) {
       sidebarContent
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.white)
      }
    }
    .environmentObject(baseData)
  }
}

extension ContentView {
  private var sidebarContent: some View {
    VStack {
      Text("Hello, World")
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
