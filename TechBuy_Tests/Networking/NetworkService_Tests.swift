//
//  NetworkService_Tests.swift
//  TechBuy_Tests
//
//  Created by Aybars Acar on 13/10/2022.
//

import XCTest
@testable import TechBuy

final class NetworkService_Tests: XCTestCase {
  
  private var url: URL!
  private var mockService: Networking!
  
  /// Runs before each function
  /// to set up the class member variables for each test to avoid caching etc
  override func setUp() {
    // setup the URL we want to simulate
    url = URL(string: "https://reqres.in/users")
    
    // create the fake url session
    // make sure the state of the session is clean and no data is cached on the device between the tests
    let configuration = URLSessionConfiguration.ephemeral
    
    // hook up the mock
    configuration.protocolClasses = [MockURLSessionProtocol.self]
    
    // set the session to be the configuration
    let session = URLSession(configuration: configuration)
    
    // set up the mock service with the mock session
    mockService = NetworkService(session: session)
  }
  
  /// runs after each test case
  /// to avoid using the same URLSession for each class
  override func tearDown() {
    url = nil
    mockService = nil
  }
  
 
  func test_withSuccessfulResponseVoidIsValid() async throws {
      
      MockURLSessionProtocol.loadingHandler = {
        let response = HTTPURLResponse(url: self.url, statusCode: 200, httpVersion: nil, headerFields: nil)
        
        return (response!, nil)
      }

    _ = try await mockService.request(.products(page: PageParams(pageIndex: 1, pageSize: 1), sortDescriptor: nil, type: nil, brand: nil))
  }
  
  func test_withUnsuccessfulResponseCodeVoidInInvalidRangeIsInvalid() async {
     let invalidStatusCode = 401
     
     MockURLSessionProtocol.loadingHandler = {
       let response = HTTPURLResponse(url: self.url, statusCode: invalidStatusCode, httpVersion: nil, headerFields: nil)
       
       return (response!, nil)
     }
     
     do {
       _ = try await mockService.request(.brands)
     } catch {
       
       guard let networkingError = error as? NetworkError else {
         XCTFail("Got the wrong type of error, expecting NetworkingManager NetworkError")
         return
       }
       
       XCTAssertEqual(networkingError, .invalidStatusCode(statusCode: 401), "Error should be networking error with an invalid status code \(invalidStatusCode)")
     }
   }
  
}
