//
//  ContentView.swift
//  TechBuy
//
//  Created by Aybars Acar on 24/5/2022.
//

import SwiftUI

struct ContentView: View {
  
  @StateObject private var baseData = BaseViewModel()
  @StateObject private var basketViewModel = BasketViewModel()
  
  var body: some View {
    ZStack {
      TabBar()
        .environmentObject(baseData)
        .environmentObject(basketViewModel)
      
      SidebarView(show: $baseData.showSideBar) {
        sidebarContent
          .frame(width: 2 * (UIScreen.main.bounds.width / 3))
          .frame(maxHeight: .infinity)
          .background(.white)
      }
    }
  }
}

extension ContentView {
  private var sidebarContent: some View {
    VStack(alignment: .leading) {
      HStack(spacing: 18) {
        Image.logo
          .resizable()
          .frame(width: 30, height: 30)
          .scaledToFit()
        
        Text("TechBuy")
          .font(.title)
          .fontWeight(.thin)
      }
      
      Spacer()
      
      // links
      VStack(spacing: 30) {
        Label("Help", systemImage: "questionmark.circle")
        Label("Help", systemImage: "questionmark.circle")
        Label("Help", systemImage: "questionmark.circle")
      }
      .font(.title2)
      
      Spacer()
      
      Label("Help", systemImage: "questionmark.circle")
        .font(.title3)
        
      Spacer()
      
      Text("""
Copyright © TechBuy
All Rights Reserved
"""
      )
      .font(.caption2)
      .foregroundColor(.secondary)
    }
    .frame(maxWidth: .infinity)
    .padding(.top, 20)
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
