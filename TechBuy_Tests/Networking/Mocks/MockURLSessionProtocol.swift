//
//  MockURLSessionProtocol.swift
//  TechBuy_Tests
//
//  Created by Aybars Acar on 13/10/2022.
//

import XCTest

/// Mocks URL Session functionality so do not send actual requests
final class MockURLSessionProtocol: URLProtocol {
  
  static var loadingHandler: (() -> (HTTPURLResponse, Data?))?
  
  /// alows us to control whether it can handla a given request
  override class func canInit(with request: URLRequest) -> Bool {
    return true
  }
  
  /// returns a fake version of the request
  override class func canonicalRequest(for request: URLRequest) -> URLRequest {
    return request
  }
  
  /// we control the mock response we get from this fake URL Session
  override func startLoading() {
    guard let handler = MockURLSessionProtocol.loadingHandler else {
      XCTFail("Loading handler is not set")
      return
    }
    
    let (response, data) = handler()
    
    client?.urlProtocol(self, didReceive: response, cacheStoragePolicy: .notAllowed)
    
    if let data = data {
      client?.urlProtocol(self, didLoad: data)
    }
    
    // tell the client we have finished loading
    client?.urlProtocolDidFinishLoading(self)
  }
  
  override func stopLoading() {
    
  }
}
