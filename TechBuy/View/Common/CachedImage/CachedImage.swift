//
//  CachedImage.swift
//  TechBuy
//
//  Created by Aybars Acar on 29/5/2022.
//

import SwiftUI

/// Component that retrieves the Cached Image if the image exists in the cache
/// Fetched the Image and caches if it doesn't exist in the cache
struct CachedImage<Content: View>: View {
  
  @StateObject private var viewModel = CachedImageViewModel()
  
  let url: String
  let animation: Animation?
  let transition: AnyTransition
  let content: (AsyncImagePhase) -> Content
  
  init(
    withURL url: String,
    animation: Animation? = nil,
    transition: AnyTransition = .identity,
    @ViewBuilder content: @escaping (AsyncImagePhase) -> Content
  ) {
    self.url = url
    self.animation = animation
    self.transition = transition
    self.content = content
  }
  
  var body: some View {
    ZStack {
      switch viewModel.state {
      case .loading:
        content(.empty)
          .transition(transition)
        
      case .success(let data):
        
        if let image = UIImage(data: data) {
          content(.success(Image(uiImage: image)))
            .transition(transition)
        }
        else {
          content(.failure(CachedImageError.invalidData))
            .transition(transition)
        }
        
      case .failed(let error):
        content(.failure(error))
          .transition(transition)
        
      default:
        content(.empty)
          .transition(transition)
      }
    }
    .animation(animation, value: viewModel.state)
    .task {
      await viewModel.load(with: url)
    }
  }
}

extension CachedImage {
  
  enum CachedImageError: Error {
    case invalidData
  }
}

struct CachedImage_Previews: PreviewProvider {
  static var previews: some View {
    CachedImage(withURL: "https://res.cloudinary.com/ddngwhjkk/image/upload/v1653778246/imac-pro_sxtx2w.png") { _ in
      EmptyView()
    }
  }
}
