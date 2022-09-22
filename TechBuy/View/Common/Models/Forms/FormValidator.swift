//
//  FormValidator.swift
//  TechBuy
//
//  Created by Aybars Acar on 22/9/2022.
//

import Foundation

/// validator object
final class CreateValidator {
  static let shared = CreateValidator()
  private init() { }
  
  func validate(forLogin values: LoginFormValues) throws {
    
    if values.email.isEmpty {
      throw CreateValidatorError.invalidEmail
    }
    
    if values.password.isEmpty {
      throw CreateValidatorError.invalidPassword
    }
  }
  
  func validate(forRegister values: RegisterFormValues) throws {
    
  }
}

extension CreateValidator {
  
  enum CreateValidatorError: Error, LocalizedError {
    case invalidEmail
    case invalidPassword
    
    var errorDescription: String? {
      switch self {
      case .invalidEmail:
        return "Email can't be empty"
      case .invalidPassword:
        return "Password can't be empty"
      }
    }
  }
}
