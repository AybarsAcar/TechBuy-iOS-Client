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
  
  func test_withSuccessfulLoginResponseAccountIsSet() async throws {
    
    XCTAssertFalse(vm.loading)
    defer {
      XCTAssertFalse(vm.loading)
      // state must be successful
      XCTAssertTrue(vm.state == .successful)
    }
    
    await vm.login()
    
    XCTAssertNotNil(vm.account)
    
    if let account = vm.account {
      XCTAssertEqual(account.displayName, "Aybars Acar")
      XCTAssertEqual(account.email, "aybars@test.com")
      XCTAssertFalse(account.token.isEmpty)
    }
    
    XCTFail("Account should not be nil")
  }
}
