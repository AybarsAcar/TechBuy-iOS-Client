//
//  ImageService.swift
//  TechBuy
//
//  Created by Aybars Acar on 26/5/2022.
//

import UIKit

/// Service to retrieve images from a file storage solution
/// implementation is with Cloudinary
protocol ImageService {
  
  /// returns Image Data passed by the URL String
  func getImage(byURL url: String) async throws -> Data
}
