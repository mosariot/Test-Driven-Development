//
//  ValidatorsTests.swift
//  CharacterizationTests
//
//  Created by Александр Воробьев on 03.11.2021.
//  Copyright © 2021 Razeware. All rights reserved.
//

import XCTest
@testable import MyBiz

class ValidatorsTests: XCTestCase {
  
  func testIsEmail_whenGoodEmail_returnsTrue() {
    XCTAssertTrue("hello@hello".isEmail)
  }
  
  func testIsEmail_whenBadEmail_returnsFalse() {
    XCTAssertFalse("hello".isEmail)
  }
  
  func testIsValidPassword_whenGoodPassword_returnsTrue() {
    XCTAssertTrue("GoodPassword".isValidPassword)
  }
  
  func testIsValidPassword_whenBadPassword_returnsFalse() {
    XCTAssertFalse("no".isValidPassword)
    XCTAssertFalse("badpassword".isValidPassword)
  }
}
