//
//  NetworkingEndpoint_Tests.swift
//  TechBuy_Tests
//
//  Created by Aybars Acar on 16/10/2022.
//

import XCTest
@testable import TechBuy

final class NetworkingEndpoint_Tests: XCTestCase {
  
  var host: String!
  
  override func setUp() {
    host = Bundle.main.object(forInfoDictionaryKey: "BASE_URL") as? String
  }
  
  func test_withProductEndpointValid() {
    let endpoint: Endpoint = .products(page: PageParams(pageIndex: 1, pageSize: 10), sortDescriptor: nil, type: nil, brand: nil)
    
    XCTAssertEqual(endpoint.host, self.host)
    XCTAssertEqual(endpoint.path, "/api/products")
    XCTAssertEqual(endpoint.methodType, .GET)
  }
  
}
