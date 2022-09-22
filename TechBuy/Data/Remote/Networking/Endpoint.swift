//
//  Endpoint.swift
//  TechBuy
//
//  Created by Aybars Acar on 22/9/2022.
//

import Foundation

// MARK: - Endpoints
/// endpoints available for our application in the backend
enum Endpoint {
  case products(page: PageParams, sortDescriptor: SortDescriptor?, type: String?, brand: String?)
  case search(query: String)
  
  case brands
  case types

  case login(data: Data?)
  case register(data: Data?)
  case currentUser
  case emailExists(_ email: String)
  
}

// MARK: - Host and Paths
extension Endpoint {
  var host: String {
    return Bundle.main.object(forInfoDictionaryKey: "BASE_URL") as! String
  }
  
  var path: String {
    switch self {
    case .products,
        .search:
      return "/api/products"
    case .brands:
      return "/api/products/brands"
    case .types:
      return "/api/products/types"
      
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
extension Endpoint {
  
  enum MethodType: Equatable {
    case GET
    case POST(data: Data?)
    case DELETE
  }
  
  var methodType: MethodType {
    switch self {
    case .products,
        .search,
        .brands,
        .types:
      return .GET

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
    case .products(page: let pageParams, sortDescriptor: let sort, type: let type, brand: let brand):
      return [
        URLQueryItem(name: "pageIndex", value: String(pageParams.pageIndex)),
        URLQueryItem(name: "pageSize", value: String(pageParams.pageSize)),
        URLQueryItem(name: "sort", value: sort?.rawValue),
        URLQueryItem(name: "typeId", value: type),
        URLQueryItem(name: "brandId", value: brand)
      ]
      
    case .search(query: let query):
      return [URLQueryItem(name: "search", value: query)]
      
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
