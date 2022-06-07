//
//  ProductRepository.swift
//  TechBuy
//
//  Created by Aybars Acar on 29/5/2022.
//

import Foundation

final class ProductRepository: ProductService {
  
  private let domain: String = "https://dev-tech-buy.herokuapp.com/api"
  
  init() {
    
  }
  
  func getProducts(_ pageParams: PageParams, orderBy order: SortDescriptor? = nil, productType: String? = nil, productBrand: String? = nil) async throws -> ProductResultsDTO {
    
    // build URL
    var componets = URLComponents()
    componets.scheme = "https"
    componets.host = "dev-tech-buy.herokuapp.com"
    componets.path = "/api/products"
    componets.queryItems = [
      URLQueryItem(name: "pageIndex", value: String(pageParams.pageIndex)),
      URLQueryItem(name: "pageSize", value: String(pageParams.pageSize)),
      URLQueryItem(name: "sort", value: order?.rawValue),
      URLQueryItem(name: "typeId", value: productType)
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
        print(error)
        throw APIError.decodingError(error.localizedDescription)
      }
      
    } catch {
      print("\n\n\n\n\n\n\n")
      print(error)
      print("\n\n\n\n\n\n\n")
      throw APIError.dataTaskError(error.localizedDescription)
    }
  }
  
  func searchForProducts(by query: String) async throws -> ProductResultsDTO {
    return ProductResultsDTO(pageIndex: 1, pageSize: 1, pageCount: 1, data: [])
  }
  
}
