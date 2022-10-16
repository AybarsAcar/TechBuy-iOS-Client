//
//  NetworkServiceUserLoginSuccessMock.swift
//  TechBuy_Tests
//
//  Created by Aybars Acar on 13/10/2022.
//

import Foundation
@testable import TechBuy

final class NetworkServiceUserLoginSuccessMock: Networking {
  
  /// Returns a successful login response
  func request<T>(_ endpoint: TechBuy.Endpoint, type: T.Type) async throws -> T where T : Decodable, T : Encodable {
    return try StaticJSONMapper.shared.decode(file: "SuccessfulLoginResponse", type: AccountDTO.self) as! T
  }
  
  func request(_ endpoint: TechBuy.Endpoint) async throws {
    
  }
  
}
