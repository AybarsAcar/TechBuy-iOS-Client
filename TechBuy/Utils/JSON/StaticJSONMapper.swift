//
//  StaticJSONMapper.swift
//  TechBuy
//
//  Created by Aybars Acar on 13/10/2022.
//

import Foundation

/// Quickly prototype the app using our JSON file in the ./Resources
struct StaticJSONMapper {
  
  public static var shared = StaticJSONMapper()
  
  private init() { }
  
  func decode<T: Codable>(file: String, type: T.Type) throws -> T {
    
    // ge the json data within the file
    guard !file.isEmpty,
          let path = Bundle.main.path(forResource: file, ofType: "json"),
          let data = FileManager.default.contents(atPath: path) else {
      print("Error getting JSON data from file \(file)")
      throw MappingError.failedToGetContents
    }
    
    let decoder = JSONDecoder()
    
    return try decoder.decode(T.self, from: data)
  }
}

extension StaticJSONMapper {
  enum MappingError: Error {
    case failedToGetContents
  }
}
