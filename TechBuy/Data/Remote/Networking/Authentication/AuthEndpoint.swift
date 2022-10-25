//
//  AuthEndpoint.swift
//  TechBuy
//
//  Created by Aybars Acar on 25/10/2022.
//

import Foundation

// MARK: - Endpoints
/// endpoints available for our application in the backend
enum AuthEndpoint: Endpoint {
  
  case login(data: Data?)
  case register(data: Data?)
  case currentUser
  case emailExists(_ email: String)
}

// MARK: - Host and Paths
extension AuthEndpoint {
  var host: String {
    return Bundle.main.object(forInfoDictionaryKey: "BASE_URL") as! String
  }
  
  var path: String {
    switch self {
    case .login:
      return "/api/account/login"
    case .register:
      return "/api/account/register"
    case .currentUser:
      return "/api/account/"
    case .emailExists:
      return "/api/email-exists"
    }
  }
}

// MARK: - MethodType and URL Building
extension AuthEndpoint {
  
  var methodType: MethodType {
    switch self {
    case .currentUser,
        .emailExists:
      return .GET
    
    case .login(let data),
        .register(let data):
      return .POST(data: data)
    }
  }
  
  var queryItems: [URLQueryItem]? {
    switch self {

    case .emailExists(let email):
      return [URLQueryItem(name: "email", value: email)]

    default:
      return nil
    }
  }
  
  var url: URL? {
    var urlComponents = URLComponents()
    urlComponents.scheme = "https"
    urlComponents.host = host
    urlComponents.path = path
    
    // build query items
    var requestQueryItems = [URLQueryItem]()
    queryItems?.forEach { item in
      requestQueryItems.append(item)
    }
    
    urlComponents.queryItems = requestQueryItems
    
    return urlComponents.url
  }
}
