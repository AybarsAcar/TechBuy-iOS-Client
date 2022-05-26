//
//  CloudinaryService.swift
//  TechBuy
//
//  Created by Aybars Acar on 26/5/2022.
//

import Foundation
import Cloudinary
import UIKit

final class CloudinaryService: ImageService {
  
  private let cloudinary: CLDCloudinary
  
  init() {
    let config = CLDConfiguration(cloudName: "ddngwhjkk", secure: true)
    cloudinary = CLDCloudinary(configuration: config)
  }
  
  func getImage(byURL urlString: String) async throws -> UIImage {
    
    guard let url = URL(string: urlString) else {
      throw APIError.invalidURL
    }
    
    do {
      
      let (data, _) = try await URLSession.shared.data(from: url)
      
      guard let image = UIImage(data: data) else {
        throw APIError.corruptData
      }
      
      return image
      
    } catch {
      throw APIError.notFound
    }
  }
}
