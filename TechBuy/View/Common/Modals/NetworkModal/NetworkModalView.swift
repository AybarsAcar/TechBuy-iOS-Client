//
//  NetworkModalView.swift
//  TechBuy
//
//  Created by Aybars Acar on 22/9/2022.
//

import SwiftUI

struct NetworkModalView: View {
  
  let message: String
  let symbol: String
  
  var body: some View {
    HStack(spacing: 20) {
      Image(systemName: symbol)
        .font(.largeTitle)
      
      Text(message)
        .font(.callout)
    }
    .padding(.vertical, 60)
    .padding(.horizontal, 60)
    .overlay(alignment: .topTrailing) {
      Button {
      } label: {
        Image(systemName: "xmark")
          .foregroundColor(.primary)
          .padding()
      }

    }
    .background(.ultraThinMaterial)
    .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
  }
}

struct NetworkModalView_Previews: PreviewProvider {
  static var previews: some View {
    NetworkModalView(
      message: "It looks like you don't have internet connection",
      symbol: "wifi.slash"
    )
  }
}
