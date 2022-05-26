//
//  FavouritesView.swift
//  TechBuy
//
//  Created by Aybars Acar on 26/5/2022.
//

import SwiftUI

struct FavouritesView: View {
  
  @StateObject private var viewModel = FavouritesViewModel()
  
  var body: some View {
    Group {
      if let image = viewModel.image {
        Image(uiImage: image)
          .resizable()
          .aspectRatio(contentMode: .fill)
          .frame(width: 400, height: 400)
      }
      else {
        Image(systemName: "person")
      }
      
    }
    .task {
      await viewModel.getImage()
    }
  }
}

struct FavouritesView_Previews: PreviewProvider {
  static var previews: some View {
    FavouritesView()
  }
}
