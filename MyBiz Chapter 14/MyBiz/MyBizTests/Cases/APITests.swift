//
//  APITests.swift
//  MyBizTests
//
//  Created by Александр Воробьев on 03.11.2021.
//  Copyright © 2021 Razeware. All rights reserved.
//

@testable import MyBiz
import XCTest

class APITests: XCTestCase {
  
  var sut: API!
  
  override func setUpWithError() throws {
    try super.setUpWithError()
    sut = MockAPI()
  }
  
  override func tearDownWithError() throws {
    sut = nil
    try super.tearDownWithError()
  }
  
  func givenLoggedIn() {
    sut.token = Token(token: "Nobody", userID: UUID())
  }
  
  func testAPI_whenLogout_generatesANotification() {
    // given
    givenLoggedIn()
    let exp = expectation(forNotification: UserLoggedOutNotification, object: nil)
    
    // when
    sut.logout()
    
    // then
    wait(for: [exp], timeout: 2)
    XCTAssertNil(sut.token)
  }
  
  func testAPI_whenLogin_generatesANotification() {
    // given
    var userInfo: [AnyHashable: Any]?
    let exp = expectation(forNotification: UserLoggedInNotification, object: nil) { note in
      userInfo = note.userInfo
      return true
    }
    
    // when
    sut.login(username: "test", password: "test")
    
    // then
    wait(for: [exp], timeout: 2)
    let userID = userInfo?[UserNotificationKey.userID]
    XCTAssertNotNil(userID, "the login notification should also have a user id")
  }
}
