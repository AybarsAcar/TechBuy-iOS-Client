//
//  ProductRepository.swift
//  TechBuy
//
//  Created by Aybars Acar on 29/5/2022.
//

import Foundation

/// This repository is not currently being used
/// replaces by the reusable networking service
@available(*, deprecated, message: "Use the NetworkingService: Networking instead")
final class ProductRepository: ProductService {
  
  private let domain: String = "https://dev-tech-buy.herokuapp.com/api"
  
  private var session: URLSession
  init(session: URLSession) {
    self.session = session
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
      throw NetworkError.invalidURL
    }

    do {
      let (data, response) = try await session.data(from: url)

      guard let httpResponse = response as? HTTPURLResponse,
            (200...300) ~= httpResponse.statusCode else {
        
        let statusCode = (response as! HTTPURLResponse).statusCode
        
        if statusCode == 401 {
          throw NetworkError.unauthorised
        }
        
        throw NetworkError.invalidStatusCode(statusCode: statusCode)
      }
      
      let decoder = JSONDecoder()
      decoder.dateDecodingStrategy = .deferredToDate
      decoder.keyDecodingStrategy = .useDefaultKeys
      
      do {
        let productsResult = try decoder.decode(ProductResultsDTO.self, from: data)
        
        return productsResult
        
      } catch {
        print(error)
        throw NetworkError.decodingError(error.localizedDescription)
      }
      
    } catch {
      print(error)
      throw NetworkError.dataTaskError(error.localizedDescription)
    }
  }
  
  func searchForProducts(by query: String) async throws -> ProductResultsDTO {
    return ProductResultsDTO(pageIndex: 1, pageSize: 1, pageCount: 1, data: [])
  }
  
}
