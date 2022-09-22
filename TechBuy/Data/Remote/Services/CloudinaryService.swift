//
//  CloudinaryService.swift
//  TechBuy
//
//  Created by Aybars Acar on 26/5/2022.
//

import Foundation
import Cloudinary

final class CloudinaryService: ImageService {
  
  private let cloudinary: CLDCloudinary
  
  init() {
    let config = CLDConfiguration(cloudName: "ddngwhjkk", secure: true)
    cloudinary = CLDCloudinary(configuration: config)
  }
  
  func getImage(byURL urlString: String) async throws -> Data {
    
    guard let url = URL(string: urlString) else {
      throw NetworkError.invalidURL
    }
    
    do {
      
      let (data, _) = try await URLSession.shared.data(from: url)
      
      return data
      
    } catch {
      throw NetworkError.notFound
    }
  }
}
