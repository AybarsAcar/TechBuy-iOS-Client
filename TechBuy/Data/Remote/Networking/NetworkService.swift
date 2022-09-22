//
//  NetworkService.swift
//  TechBuy
//
//  Created by Aybars Acar on 22/9/2022.
//

import Foundation

final class NetworkService: Networking {
  
  let session: URLSession
  init(session: URLSession) {
    self.session = session
  }
  
  func request<T: Codable>(_ endpoint: Endpoint, type: T.Type) async throws -> T {
    
    guard let url = endpoint.url else {
      throw NetworkError.invalidURL
    }
    
    let request = buildRequest(from: url, methodType: endpoint.methodType)
    
    let (data, response) = try await session.data(for: request)
        
    guard let response = response as? HTTPURLResponse,
          (200...300) ~= response.statusCode else {
      
      let statusCode = (response as! HTTPURLResponse).statusCode
      
      if statusCode == 401 {
        throw NetworkError.unauthorised
      }
      
      throw NetworkError.invalidStatusCode(statusCode: statusCode)
    }
    
    let decoder = JSONDecoder()
    
    do {
      let result = try decoder.decode(T.self, from: data)
      return result
    } catch {
      throw NetworkError.decodingError(error.localizedDescription)
    }
  }
  
  func request(_ endpoint: Endpoint) async throws {
    guard let url = endpoint.url else {
      throw NetworkError.invalidURL
    }
    
    let request = buildRequest(from: url, methodType: endpoint.methodType)

    let (_, response) = try await session.data(for: request)
    
    guard let response = response as? HTTPURLResponse,
          (200...300) ~= response.statusCode else {
      
      let statusCode = (response as! HTTPURLResponse).statusCode
      throw NetworkError.invalidStatusCode(statusCode: statusCode)
    }
  }
  
  
}

private extension NetworkService {
  
  func buildRequest(from url: URL, methodType: Endpoint.MethodType) -> URLRequest {
    
    var request = URLRequest(url: url)
    
    switch methodType {
    case .GET:
      request.httpMethod = "GET"
      
    case .POST(let data):
      request.httpMethod = "POST"
      request.httpBody = data      
      request.setValue("application/json", forHTTPHeaderField: "Content-Type")

      
    case .DELETE:
      request.httpMethod = "DELETE"
    }
    
    return request
  }
}
