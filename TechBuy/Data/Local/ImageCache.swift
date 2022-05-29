//
//  ImageCache.swift
//  TechBuy
//
//  Created by Aybars Acar on 26/5/2022.
//

import SwiftUI

/// Manager that handles Image Caching in NSCache
final class ImageCache {
  
  let COUNT_LIMIT = 100
  let TOTAL_COST_LIMIT = 50 * 1024 * 1024 // 50MB, only caches images that are less than or equal to 50MB
  
  /// Image Data is stored with NSString Key which will be the URL string of the image
  typealias CacheType = NSCache<NSString, NSData>
  
  static let shared = ImageCache()
  private init() { }
  
  private lazy var cache: CacheType = {
    let cache = CacheType()
    
    cache.countLimit = COUNT_LIMIT
    cache.totalCostLimit = TOTAL_COST_LIMIT
    
    return cache
  }()
  
  /// Returns optional image data passed by the image URL String
  func object(forKey key: NSString) -> Data? {
    return cache.object(forKey: key) as? Data
  }
  
  /// Sets image data in the cache given its image URL String
  func set(object: NSData, forKey key: NSString) {
    cache.setObject(object, forKey: key)
  }
}
