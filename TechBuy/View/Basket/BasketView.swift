//
//  BasketView.swift
//  TechBuy
//
//  Created by Aybars Acar on 26/5/2022.
//

import SwiftUI

struct BasketView: View {
  
  @Environment(\.dismiss) private var dismiss
  
  var body: some View {
    VStack {
      navBar
      Spacer()
    }
    .padding()
  }
}

extension BasketView {
  
  private var navBar: some View {
    HStack {
      
      Button {
        dismiss()
      } label: {
        
        Image(systemName: "xmark")
          .font(.title2)
        
        
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

struct BasketView_Previews: PreviewProvider {
  static var previews: some View {
    BasketView()
  }
}
