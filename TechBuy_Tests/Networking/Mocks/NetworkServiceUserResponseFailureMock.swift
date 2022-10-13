//
//  NetworkServiceUserResponseFailureMock.swift
//  TechBuy_Tests
//
//  Created by Aybars Acar on 13/10/2022.
//

import Foundation
@testable import TechBuy

final class NetworkServiceUserResponseFailureMock: Networking {
  
  func request<T>(_ endpoint: TechBuy.Endpoint, type: T.Type) async throws -> T where T : Decodable, T : Encodable {
    throw NetworkError.invalidURL
  }
  
  func request(_ endpoint: TechBuy.Endpoint) async throws {
    
  }
  
}
