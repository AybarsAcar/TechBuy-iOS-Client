//
//  ProductEndpoint.swift
//  TechBuy
//
//  Created by Aybars Acar on 25/10/2022.
//

import Foundation

// MARK: - Endpoints
/// endpoints available for our application in the backend
enum ProductEndpoint: Endpoint {
  case products(page: PageParams, sortDescriptor: SortDescriptor?, type: String?, brand: String?)
  case search(query: String)
  
  case brands
  case types
}

// MARK: - Host and Paths
extension ProductEndpoint {
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

    }
  }
}

// MARK: - MethodType and URL Building
extension ProductEndpoint {
  
  var methodType: MethodType {
    switch self {
    case .products,
        .search,
        .brands,
        .types:
      return .GET

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
