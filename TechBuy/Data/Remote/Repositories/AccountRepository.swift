//
//  AccountRepository.swift
//  TechBuy
//
//  Created by Aybars Acar on 7/6/2022.
//

import Foundation

final class AccountRepository: AccountService {
  
  private let domain = "https://dev-tech-buy.herokuapp.com/api"
  
  private var session: URLSession
  init(session: URLSession) {
    self.session = session
  }
  
  func login(with loginValues: LoginFormValues) async throws -> AccountDTO {
#if DEBUG
    try? await Task.sleep(nanoseconds: 2_000_000_000)
#endif

    guard let url = URL(string: "\(domain)/account/login") else {
      throw NetworkError.invalidURL
    }
    
    // build request
    var request = URLRequest(url: url)
    request.httpMethod = "POST"
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    
    guard let dataToSend = try? JSONEncoder().encode(loginValues) else {
      throw NetworkError.corruptData
    }
    
    do {
      let (data, response) = try await session.upload(for: request, from: dataToSend)
      
      guard let httpResponse = response as? HTTPURLResponse,
            (200...300) ~= httpResponse.statusCode else {
        
        let statusCode = (response as! HTTPURLResponse).statusCode
        
        if statusCode == 401 {
          throw NetworkError.unauthorised
        }
        
        throw NetworkError.invalidStatusCode(statusCode: statusCode)
      }
      
      let decoder = JSONDecoder()
      
      do {
        return try decoder.decode(AccountDTO.self, from: data)
        
      } catch {
        print(error)
        throw NetworkError.decodingError(error.localizedDescription)
      }
      
    } catch {
      print(error)
      throw NetworkError.dataTaskError(error.localizedDescription)
    }
  }
  
  func register(with registerValues: RegisterFormValues) async throws -> AccountDTO {
    
    guard let url = URL(string: "\(domain)/account/register") else {
      throw NetworkError.invalidURL
    }
    
    // build request
    var request = URLRequest(url: url)
    request.httpMethod = "POST"
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    
    guard let dataToSend = try? JSONEncoder().encode(registerValues) else {
      throw NetworkError.corruptData
    }
    
    do {
      let (data, response) = try await session.upload(for: request, from: dataToSend)
      
      guard let httpResponse = response as? HTTPURLResponse,
            (200...300) ~= httpResponse.statusCode else {
        
        let statusCode = (response as! HTTPURLResponse).statusCode
        
        if statusCode == 401 {
          throw NetworkError.unauthorised
        }
        
        throw NetworkError.invalidStatusCode(statusCode: statusCode)
      }
      
      let decoder = JSONDecoder()
      
      do {
        print(data)
        
        return try decoder.decode(AccountDTO.self, from: data)
        
      } catch {
        print(error)
        throw NetworkError.decodingError(error.localizedDescription)
      }
      
    } catch {
      print(error)
      throw NetworkError.dataTaskError(error.localizedDescription)
    }
  }
  
  func getCurrentUser(token: String) async throws -> AccountDTO {
    return AccountDTO(email: "", displayName: "", token: "")
  }
  
  func emailExists(_ email: String) async throws -> Bool {
    return false
  }
}
