//
//  AppDelegateTests.swift
//  MyBizTests
//
//  Created by Александр Воробьев on 06.11.2021.
//  Copyright © 2021 Razeware. All rights reserved.
//

@testable import MyBiz
import Login
import XCTest

class AppDelegateTests: XCTestCase {
  
  var sut: AppDelegate!
  
  override func setUpWithError() throws {
    try super.setUpWithError()
    sut = AppDelegate()
    sut.window = UIApplication.shared.windows.first
    _ = sut.application(UIApplication.shared, didFinishLaunchingWithOptions: nil)
  }
  
  override func tearDownWithError() throws {
    sut = nil
    try super.tearDownWithError()
  }
  
  func testAppDelegate_whenLoggedIn_hasUserId() {
    // given
    let note = Notification(name: UserLoggedInNotification, userInfo: [UserNotificationKey.userId: "testUser"])
    let exp = expectation(forNotification: UserLoggedInNotification, object: nil)
    
    // when
    DispatchQueue.main.async {
      NotificationCenter.default.post(note)
    }
    
    // then
    wait(for: [exp], timeout: 2)
    XCTAssertEqual(sut.userId, "testUser")
  }
  
  func testAppDelegate_whenLoggedOut_loginScreenShown() {
    // given
    let note = Notification(name: UserLoggedOutNotification)
    let exp = expectation(forNotification: UserLoggedOutNotification, object: nil)
    
    // when
    DispatchQueue.main.async {
      NotificationCenter.default.post(note)
    }
    
    // then
    wait(for: [exp], timeout: 2)
    let topController = sut.window?.rootViewController
    XCTAssertNotNil(topController)
    XCTAssertTrue(topController is LoginViewController)
  }
}
