//
//  Endpoint.swift
//  TechBuy
//
//  Created by Aybars Acar on 22/9/2022.
//

import Foundation

protocol Endpoint {
  var host: String { get }
  var path: String { get }
  var methodType: MethodType { get }
  var queryItems: [URLQueryItem]? { get }
  var url: URL? { get }
}

enum MethodType: Equatable {
  case GET
  case POST(data: Data?)
  case DELETE
}
