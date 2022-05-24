//
//  BaseView.swift
//  TechBuy
//
//  Created by Aybars Acar on 24/5/2022.
//

import SwiftUI

struct BaseView: View {
  
  @StateObject private var baseData = BaseViewModel()
  
  init() {
    // hide the default tab view
    UITabBar.appearance().isHidden = true
  }
  
  var body: some View {
    TabView(selection: $baseData.currentTab) {
      
      HomeView()
        .environmentObject(baseData)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.black.opacity(0.04))
        .tag(Tab.home)
      
      Text("Heart")
        .tag(Tab.heart)
      
      Text("Clipboard")
        .tag(Tab.clipboard)
      
      Text("Person")
        .tag(Tab.person)
    }
    .overlay(
      // custom Tab Bar
      HStack(spacing: 0) {
        TabButton(tab: .home)
        
        TabButton(tab: .heart)
          .offset(x: -10)
        
        // center curved button
        Button {
          
        } label: {
          Image(systemName: "cart.fill")
            .resizable()
            .renderingMode(.template)
            .aspectRatio(contentMode: .fit)
            .frame(width: 26, height: 26)
            .foregroundColor(.white)
            .padding(18)
            .background(Color.theme.main)
            .clipShape(Circle())
            .shadow(color: .black.opacity(0.04), radius: 5, x: -5, y: -5)
        }
        .offset(y: -30)
        
        TabButton(tab: .clipboard)
          .offset(x: 10)
        
        TabButton(tab: .person)
      }
        .withCurvedBackground()
      , alignment: .bottom
    )
  }
  
  @ViewBuilder
  func TabButton(tab: Tab) -> some View {
    Button {
      withAnimation {
        baseData.currentTab = tab
      }
    } label: {
      Image(systemName: tab.rawValue)
        .resizable()
        .renderingMode(.template)
        .aspectRatio(contentMode: .fit)
        .frame(width: 25, height: 25)
        .foregroundColor(baseData.currentTab == tab ? .theme.main : .secondary.opacity(0.5))
        .frame(maxWidth: .infinity)
    }

  }
}

struct BaseView_Previews: PreviewProvider {
  static var previews: some View {
    BaseView()
  }
}
