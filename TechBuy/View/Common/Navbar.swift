//
//  Navbar.swift
//  TechBuy
//
//  Created by Aybars Acar on 25/5/2022.
//

import SwiftUI

struct Navbar: View {
  
  var body: some View {
    HStack {
      
      Button {
        
      } label: {
        
        menuButtonShape
      
      }
      .frame(width: 30, height: 25)
    
    
    Spacer()
    
    Button {
      
    } label: {
      Image(systemName: "magnifyingglass")
        .font(.title2)
    }
    
  }
    .foregroundColor(.black)
    .overlay(
      Image.logo
        .resizable()
        .frame(width: 30, height: 30)
        .scaledToFit()
    )
}
}

extension Navbar {
  
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

struct Navbar_Previews: PreviewProvider {
  static var previews: some View {
    Navbar()
      .previewLayout(.sizeThatFits)
  }
}
