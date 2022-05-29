//
//  ImageCache.swift
//  TechBuy
//
//  Created by Aybars Acar on 26/5/2022.
//

import SwiftUI

/// Declares in-memory image cache
protocol ImageCacheType: AnyObject {
  /// Returns the image associated with a given url
  func image(for url: URL) -> UIImage?
  /// Inserts the image of the specified url in the cache
  func insertImage(_ image: UIImage?, for url: URL)
  /// Removes the image of the specified url in the cache
  func removeImage(for url: URL)
  /// Removes all images from the cache
  func removeAllImages()
  /// Accesses the value associated with the given key for reading and writing
  subscript(_ url: URL) -> UIImage? { get set }
}

/// Responsible for caching images
final class ImageCache {
  
  // 1st level cache, that contains encoded images
  private lazy var imageCache: NSCache<AnyObject, AnyObject> = {
    let cache = NSCache<AnyObject, AnyObject>()
    cache.countLimit = config.countLimit
    return cache
  }()
  
  // 2nd level cache, that contains decoded images
  private lazy var decodedImageCache: NSCache<AnyObject, AnyObject> = {
    let cache = NSCache<AnyObject, AnyObject>()
    cache.totalCostLimit = config.memoryLimit
    return cache
  }()
  
  private let lock = NSLock()
  private let config: Config
  
  struct Config {
    let countLimit: Int
    let memoryLimit: Int
    
    static let defaultConfig = Config(countLimit: 100, memoryLimit: 1024 * 1024 * 100) // 100 MB
  }
  
  init(config: Config = Config.defaultConfig) {
    self.config = config
  }
}
/*
extension ImageCache: ImageCacheType {
  func image(for url: URL) -> UIImage? {
    <#code#>
  }
  
  func insertImage(_ image: UIImage?, for url: URL) {
    <#code#>
  }
  
  func removeImage(for url: URL) {
    <#code#>
  }
  
  func removeAllImages() {
    <#code#>
  }
  
  subscript(url: URL) -> UIImage? {
    get {
      <#code#>
    }
    set {
      <#code#>
    }
  }
  
  
}
*/
