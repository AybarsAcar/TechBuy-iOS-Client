//
//  AccountService.swift
//  TechBuy
//
//  Created by Aybars Acar on 7/6/2022.
//

import Foundation

/// Deprecated by NetworkService
@available(*, deprecated, message: "Use the NetworkingService: Networking instead")
protocol AccountService {
  
  /// Login using login values
  /// POST method to application server
  func login(with loginValues: LoginFormValues) async throws -> AccountDTO
  
  /// Login using register values
  /// POST method to application server
  func register(with registerValues: RegisterFormValues) async throws -> AccountDTO
  
  /// returns the current Account using Bearer token
  /// POST method to application server
  func getCurrentUser(token: String) async throws -> AccountDTO
  
  /// returns true from the API if the email already exists
  /// used to validate email while user is typing
  func emailExists(_ email: String) async throws -> Bool
}
