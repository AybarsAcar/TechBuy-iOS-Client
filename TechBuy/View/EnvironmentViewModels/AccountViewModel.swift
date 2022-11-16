//
//  AccountViewModel.swift
//  TechBuy
//
//  Created by Aybars Acar on 24/5/2022.
//

import SwiftUI

final class AccountViewModel: ObservableObject {
  
  @Published private(set) var account: Account?
  
  @Published var displayName = ""
  @Published var username = ""
  @Published var email = ""
  @Published var password = ""
  @Published var confirmPassword = ""
  
  @Published private(set) var state: SubmissionState = .default
  @Published var hasError = false
  @Published private(set) var error: FormError?
  
  @Inject private var service: Networking
  
  var loading: Bool {
    return state == .submitting
  }
  
  var isLoggedIn: Bool {
    return account != nil
  }
  
  @MainActor
  func login() async {
    
    do {
      
      let formValues = LoginFormValues(email: email, password: password)
      
      state = .submitting
      
      try CreateValidator.shared.validate(forLogin: formValues)
      
      let data = try JSONEncoder().encode(formValues)
      
      let accountDTO = try await service.request(AuthEndpoint.login(data: data), type: AccountDTO.self)
      
      withAnimation(.easeInOut) {
        account = accountDTO.toAccount()
      }
      
      state = .successful
      
      // clear the form values
      email = ""
      password = ""
      confirmPassword = ""
      
      // save the user token to UserDefaults - Maybe save the state
      UserDefaults.standard.set(accountDTO.token, forKey: UserDefaultKeys.userToken)
      
      // save the user into the local device db
      
    } catch {
      
      withAnimation(.linear(duration: 0.2)) {
        hasError = true
        self.state = .unsuccessful
        
        switch error {
        case is NetworkError:
          self.error = .networking(error: error as! NetworkError)
          
        case is CreateValidator.CreateValidatorError:
          self.error = .validation(error: error as! CreateValidator.CreateValidatorError)
          
        default:
          self.error = .system(error: error)
        }
      }
    }
  }
}

// MARK: - Convenience Init for testing
extension AccountViewModel {
  convenience init(service: Networking) {
    self.init()
    self._service.wrappedValue = service
  }
}
