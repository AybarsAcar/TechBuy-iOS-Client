//
//  NetworkServiceSuccessfulProductMock.swift
//  TechBuy_Tests
//
//  Created by Aybars Acar on 16/10/2022.
//

import Foundation
@testable import TechBuy

final class NetworkServiceSuccessfulProductMock: Networking {
  func request<T>(_ endpoint: TechBuy.Endpoint, type: T.Type) async throws -> T where T : Decodable, T : Encodable {
    return try! StaticJSONMapper.shared.decode(file: "ProductsResponse", type: ProductResultsDTO.self) as! T
  }
  
  func request(_ endpoint: TechBuy.Endpoint) async throws {
  
  }
  
}
