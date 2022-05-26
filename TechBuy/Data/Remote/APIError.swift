//
//  APIError.swift
//  TechBuy
//
//  Created by Aybars Acar on 26/5/2022.
//

import Foundation

/// Custom error returned from the requests
enum APIError: Error, LocalizedError {
  case invalidURL
  case invalidResponseStatus
  case dataTaskError(String)
  case corruptData
  case decodingError(String)
  case unauthorised
  case notFound
  case internalServerError
  
  var errorDescription: String? {
    switch self {
    case .invalidURL:
      return NSLocalizedString("THe endpoint URL is invalid", comment: "")
    case .invalidResponseStatus:
      return NSLocalizedString("The API failed to issue a valid response", comment: "")
    case .dataTaskError(let string):
      return string
    case .corruptData:
      return NSLocalizedString("The data provided appears to be corrupt", comment: "")
    case .decodingError(let string):
      return string
    case .unauthorised:
      return NSLocalizedString("Invalid credentials", comment: "")
    case .notFound:
      return NSLocalizedString("404 Not Found", comment: "")
    case .internalServerError:
      return NSLocalizedString("Internal Server Error", comment: "")
    }
  }
}
