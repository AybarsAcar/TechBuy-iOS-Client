//
//  AccountViewModel.swift
//  TechBuy
//
//  Created by Aybars Acar on 24/5/2022.
//

import Foundation
import SwiftUI

final class AccountViewModel: ObservableObject {
  
  @Published private(set) var account: Account?

  @Published var displayName = ""
  @Published var username = ""
  @Published var email = ""
  @Published var password = ""
  @Published var confirmPassword = ""

  @Published var loading = false
  @Published var showAlert = false
  @Published var errorMessage = ""
  
  @Inject private var service: AccountService
  
  func login() async {
    
    guard !email.isEmpty, !password.isEmpty, !confirmPassword.isEmpty else {
      showAlert = true
      errorMessage = "All fields are requierd to register an account."
      return
    }
    
    guard password == confirmPassword else {
      showAlert = true
      errorMessage = "Passwords do not match."
      return
    }
    
    loading = true
    
    defer {
      loading = false
    }
    
    do {
      let accountDTO = try await service.login(with: LoginFormValues(email: email, password: password))
      
      await MainActor.run {
        withAnimation(.easeInOut) {
          account = accountDTO.toAccount()
        }
      }
      
      // clear the form values
      email = ""
      password = ""
      confirmPassword = ""
      
      // save the user token to UserDefaults - Maybe save the state
      UserDefaults.standard.set(accountDTO.token, forKey: "token")
      
      // save the user into the local device db
      
    } catch {
      print("ERROR\n\(error)")
      showAlert = true
      errorMessage = error.localizedDescription
    }
  }
}
