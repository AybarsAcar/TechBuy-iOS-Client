//
//  Networking.swift
//  TechBuy
//
//  Created by Aybars Acar on 22/9/2022.
//

import Foundation

protocol Networking {
  func request<T: Codable>(_ endpoint: Endpoint, type: T.Type) async throws -> T
  func request(_ endpoint: Endpoint) async throws
}
