//
//  HomeView.swift
//  TechBuy
//
//  Created by Aybars Acar on 24/5/2022.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        
      ScrollView(.vertical, showsIndicators: false) {
        
        VStack(spacing: 15) {
          
          HStack {
             
            Button {
              
            } label: {
              menuButtonShape
                .frame(width: 30, height: 25)
                .foregroundColor(.black)
            }
            
            Spacer()
            
            Button {
              
            } label: {
              Image(systemName: "magnifyingglass")
                .font(.title2)
                .foregroundColor(.black)
            }

          }
          
        }
        .padding()
      }
    }
}

extension HomeView {
  
  private var menuButtonShape: some View {
    
    VStack(alignment: .trailing, spacing: 4) {
      RoundedRectangle(cornerRadius: 2, style: .continuous)
        .frame(height: 3)
      
      RoundedRectangle(cornerRadius: 2, style: .continuous)
        .frame(height: 3)
      
      RoundedRectangle(cornerRadius: 2, style: .continuous)
        .frame(width: 16, height: 3)
    }
  }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
