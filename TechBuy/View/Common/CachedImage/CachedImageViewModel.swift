//
//  CachedImageViewModel.swift
//  TechBuy
//
//  Created by Aybars Acar on 26/5/2022.
//

import UIKit

final class CachedImageViewModel: ObservableObject {
  
  @Published private(set) var state: CurrentState?
  
  @Inject private var imageService: ImageService
  
  @MainActor
  func load(with url: String, cache: ImageCache = .shared) async {
    
    state = .loading
    
    // check if the image already exists in Cache
    if let imageData = cache.object(forKey: url as NSString) {
      state = .success(imageData)
      return
    }
    
    // if no image in the cache execute the request
    do {
      let data = try await imageService.getImage(byURL: url)
      
      state = .success(data)
      
      // save the image data to cache
      cache.set(object: data as NSData, forKey: url as NSString)
      
    } catch {
      state = .failed(error)
    }
  }
}

extension CachedImageViewModel {

  enum CurrentState: Equatable {
    case loading
    case failed(_ error: Error)
    case success(_ data: Data)
    
    static func == (lhs: CachedImageViewModel.CurrentState, rhs: CachedImageViewModel.CurrentState) -> Bool {
      switch (lhs, rhs) {
      case (.loading, .loading):
        return true
      case (let .failed(lhsError), let .failed(rhsError)):
        return lhsError.localizedDescription == rhsError.localizedDescription
      case (let .success(lhsData), let .success(rhsData)):
        return lhsData == rhsData
      default:
        return false
      }
    }
  }
}
