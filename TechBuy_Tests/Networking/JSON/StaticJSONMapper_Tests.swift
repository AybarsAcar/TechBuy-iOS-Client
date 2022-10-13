//
//  StaticJSONMapper_Tests.swift
//  TechBuy_Tests
//
//  Created by Aybars Acar on 13/10/2022.
//

import XCTest
@testable import TechBuy

final class JSONMapper_Tests: XCTestCase {
  
  func test_with_valid_JSON_successfully_decodes() {
    XCTAssertNoThrow(try StaticJSONMapper.shared.decode(file: "SuccessfulLoginResponse", type: AccountDTO.self), "Mapper should not throw an error")
    
    let accountDTO = try? StaticJSONMapper.shared.decode(file: "SuccessfulLoginResponse", type: AccountDTO.self)
    
    XCTAssertNotNil(accountDTO, "User response should not be nil")
    
    XCTAssertEqual(accountDTO?.displayName, "Aybars Acar")
    XCTAssertEqual(accountDTO?.email, "aybars@test.com")
    
    XCTAssertNotNil(accountDTO?.token, "Token should not be nil")
  }
  
  func test_with_missing_file_error_throws() {
    XCTAssertThrowsError(try StaticJSONMapper.shared.decode(file: "", type: AccountDTO.self), "An error should be thrown")
    
    do {
      _ = try StaticJSONMapper.shared.decode(file: "", type: AccountDTO.self)
    } catch {
      guard let mappingError = error as? StaticJSONMapper.MappingError else {
        XCTFail("Wrong type of error is thrown")
        return
      }
      
      XCTAssertEqual(mappingError, StaticJSONMapper.MappingError.failedToGetContents, "This should be failed to get contents error")
    }
  }
  
  func test_with_invalid_file_error_throws() {
    XCTAssertThrowsError(try StaticJSONMapper.shared.decode(file: "invalid-file-name", type: AccountDTO.self), "An error should be thrown")
    
    do {
      _ = try StaticJSONMapper.shared.decode(file: "", type: AccountDTO.self)
    } catch {
      guard let mappingError = error as? StaticJSONMapper.MappingError else {
        XCTFail("Wrong type of error is thrown")
        return
      }
      
      XCTAssertEqual(mappingError, StaticJSONMapper.MappingError.failedToGetContents, "This should be failed to get contents error")
    }
  }
  
  func test_with_invalid_JSON_error_thrown() {
    // wrong type is passed
    XCTAssertThrowsError(try StaticJSONMapper.shared.decode(file: "SuccessfulLoginResponse", type: ProductDTO.self), "An error should be thrown")
    
    do {
      _ = try StaticJSONMapper.shared.decode(file: "SuccessfulLoginResponse", type: ProductDTO.self)
    } catch {
      if error is StaticJSONMapper.MappingError {
        XCTFail("Wrong type of error is thrown")
      }
    }
  }
}
