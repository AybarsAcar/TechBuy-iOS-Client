//
//  AccountRepository.swift
//  TechBuy
//
//  Created by Aybars Acar on 7/6/2022.
//

import Foundation

final class AccountRepository: AccountService {
  
  private let domain = "https://dev-tech-buy.herokuapp.com/api"
  
  func login(with loginValues: LoginFormValues) async throws -> AccountDTO {
    
    try? await Task.sleep(nanoseconds: 2_000_000_000)
    
    guard let url = URL(string: "\(domain)/account/login") else {
      throw APIError.invalidURL
    }
    
    // build request
    var request = URLRequest(url: url)
    request.httpMethod = "POST"
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    
    guard let dataToSend = try? JSONEncoder().encode(loginValues) else {
      throw APIError.corruptData
    }
    
    do {
      let (data, response) = try await URLSession.shared.upload(for: request, from: dataToSend)
      
      guard let httpResponse = response as? HTTPURLResponse else {
        throw APIError.invalidResponseStatus
      }
      
      guard httpResponse.statusCode == 200 else {
        if httpResponse.statusCode == 401 {
          throw APIError.unauthorised
        }
        
        throw APIError.invalidResponseStatus
      }
      
      let decoder = JSONDecoder()
      
      do {
        return try decoder.decode(AccountDTO.self, from: data)
        
      } catch {
        print(error)
        throw APIError.decodingError(error.localizedDescription)
      }
      
    } catch {
      print(error)
      throw APIError.dataTaskError(error.localizedDescription)
    }
  }
  
  func register(with registerValues: RegisterFormValues) async throws -> AccountDTO {
    
    guard let url = URL(string: "\(domain)/account/register") else {
      throw APIError.invalidURL
    }
    
    // build request
    var request = URLRequest(url: url)
    request.httpMethod = "POST"
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    
    guard let dataToSend = try? JSONEncoder().encode(registerValues) else {
      throw APIError.corruptData
    }
    
    do {
      let (data, response) = try await URLSession.shared.upload(for: request, from: dataToSend)
      
      guard let httpResponse = response as? HTTPURLResponse else {
        throw APIError.invalidResponseStatus
      }
      
      guard httpResponse.statusCode == 200 else {
        if httpResponse.statusCode == 401 {
          throw APIError.unauthorised
        }
        
        throw APIError.invalidResponseStatus
      }
      
      let decoder = JSONDecoder()
      
      do {
        print(data)
        
        return try decoder.decode(AccountDTO.self, from: data)
        
      } catch {
        print(error)
        throw APIError.decodingError(error.localizedDescription)
      }
      
    } catch {
      print(error)
      throw APIError.dataTaskError(error.localizedDescription)
    }
  }
  
  func getCurrentUser(token: String) async throws -> AccountDTO {
    return AccountDTO(email: "", displayName: "", token: "")
  }
  
  func emailExists(_ email: String) async throws -> Bool {
    return false
  }
}
