//
//  ProductViewModel_Tests.swift
//  TechBuy_Tests
//
//  Created by Aybars Acar on 16/10/2022.
//

import XCTest
@testable import TechBuy

final class ProductViewModel_Tests: XCTestCase {
  
  private var mockNetwork: Networking!
  private var vm: ProductViewModel!
  
  override func setUp() {
    // create the mock Network Service with successful login response
    mockNetwork = NetworkServiceSuccessfulProductMock()
    
    // inject the service into Account View Model
    vm = ProductViewModel(service: mockNetwork)
  }
  
  override func tearDown() {
    mockNetwork = nil
    vm = nil
  }
  
  
  func test_withSuccessfulResponseProductsArrayIsSet() async throws {
    
    XCTAssertFalse(vm.loading, "The view model should not be loading any data")
    defer {
      XCTAssertFalse(vm.loading, "The view model should not be loading any data")
      XCTAssertEqual(vm.state, .finished, "The view state should be finished")
    }
    
    await vm.loadProducts()
    
    XCTAssertEqual(vm.products.count, 6)
  }
  
  func test_withSuccessfulResponseStateErrorIsNil() async throws {
    XCTAssertFalse(vm.loading, "The view model should not be loading any data")
    defer {
      XCTAssertFalse(vm.loading, "The view model should not be loading any data")
      XCTAssertEqual(vm.state, .finished, "The view state should be finished")
    }

    await vm.loadProducts()
    
    XCTAssertNil(vm.error)
  }
  
  func test_sortDescriptorSetToDefault() {
    XCTAssertTrue(vm.sortDescriptor == .default)
  }
}
