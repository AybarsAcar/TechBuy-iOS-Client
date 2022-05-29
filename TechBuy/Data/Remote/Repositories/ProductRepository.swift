//
//  ProductRepository.swift
//  TechBuy
//
//  Created by Aybars Acar on 29/5/2022.
//

import Foundation

final class ProductRepository: ProductService {
  
  private let domain: String = "http://127.0.0.1:5000/api"
  
  func getProducts(_ pageParams: PageParams, orderBy order: SortDescriptor? = nil, productType: Int? = nil, productBrand: Int? = nil) async throws -> ProductResultsDTO {
    
    var componets = URLComponents()
    componets.scheme = "http"
    componets.host = "127.0.0.1:5000/api"
    componets.path = "products"
    componets.queryItems = [
      URLQueryItem(name: "PageIndex", value: String(pageParams.pageIndex)),
      URLQueryItem(name: "PageSize", value: String(pageParams.pageSize)),
      URLQueryItem(name: "Sort", value: order?.rawValue)
    ]
    
    guard let url = componets.url else {
      throw APIError.invalidURL
    }
    
    do {
      let (data, response) = try await URLSession.shared.data(from: url)
      
      guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode >= 200 else {
        throw APIError.invalidResponseStatus
      }
      
      let decoder = JSONDecoder()
      decoder.dateDecodingStrategy = .deferredToDate
      decoder.keyDecodingStrategy = .useDefaultKeys
      
      do {
        let productsResult = try decoder.decode(ProductResultsDTO.self, from: data)
        
        return productsResult
        
      } catch {
        throw APIError.decodingError(error.localizedDescription)
      }
      
    } catch {
      throw APIError.dataTaskError(error.localizedDescription)
    }
  }
  
  func searchForProducts(by query: String) async throws -> ProductResultsDTO {
    return ProductResultsDTO(pageIndex: 1, pageSize: 1, pageCount: 1, data: [])
  }
  
}
