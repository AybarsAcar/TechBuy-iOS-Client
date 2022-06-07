//
//  AccountDTO.swift
//  TechBuy
//
//  Created by Aybars Acar on 7/6/2022.
//

import Foundation

// MARK: - Account returned from GET request
struct AccountDTO: Codable {
  let email, displayName, token: String
  
  enum CodingKeys: String, CodingKey {
    case email, token
    case displayName = "display_name"
  }
}

// MARK: - Form values for Register POST request
struct RegisterFormValues: Codable {
  let displayName, username, email, password: String

   enum CodingKeys: String, CodingKey {
       case displayName = "display_name"
       case username, email, password
   }
}

// MARK: - Form Values for Login POST request
struct LoginFormValues: Codable {
  let email, password: String
}

// MARK: - Mappers
extension AccountDTO {
  public func toAccount() -> Account {
    return Account(email: self.email, displayName: self.displayName, token: self.token)
  }
}
