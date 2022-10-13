//
//  AccountViewModel_Tests.swift
//  TechBuy_Tests
//
//  Created by Aybars Acar on 13/10/2022.
//

import XCTest
@testable import TechBuy

final class AccountViewModel_Tests: XCTestCase {

  private var mockNetwork: Networking!
  private var vm: AccountViewModel!
  
  override func setUp() {
    // create the mock Network Service with successful login response
    mockNetwork = NetworkServiceUserLoginSuccessMock()
    
    // inject the service into Account View Model
    vm = AccountViewModel(service: mockNetwork)
  }
  
  override func tearDown() {
      mockNetwork = nil
      vm = nil
    }
}
