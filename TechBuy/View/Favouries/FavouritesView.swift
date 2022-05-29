//
//  FavouritesView.swift
//  TechBuy
//
//  Created by Aybars Acar on 26/5/2022.
//

import SwiftUI

struct FavouritesView: View {
  
  var body: some View {
    VStack {
      CachedImage(withURL: "https://res.cloudinary.com/ddngwhjkk/image/upload/v1653778246/imac-pro_sxtx2w.png", animation: .spring(), transition: .scale.combined(with: .opacity)) { state in
        switch state {
        case .empty:
          ProgressView()
            .frame(width: 100, height: 100)
            .background(.blue, in: RoundedRectangle(cornerRadius: 8, style: .continuous))
          
        case .success(let image):
          image
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: 100, height: 100)
        
        case .failure:
          Image(systemName: "photo.on.rectangle.angled")
            .font(.largeTitle)
            .foregroundColor(.white)
            .padding()
            .background(.blue, in: RoundedRectangle(cornerRadius: 8, style: .continuous))
          
        @unknown default:
          fatalError()
        }
      }
    }
  }
}

struct FavouritesView_Previews: PreviewProvider {
  static var previews: some View {
    FavouritesView()
  }
}
