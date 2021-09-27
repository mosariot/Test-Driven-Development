//
//  RootViewControllerTests.swift
//  FitNessTests
//
//  Created by Alex Vorobiev on 27.09.2021.
//  Copyright © 2021 Razeware. All rights reserved.
//

import XCTest
@testable import FitNess

class RootViewControllerTests: XCTestCase {
  
  var sut: RootViewController!
  
  override func setUp() {
    super.setUp()
    sut = loadRootViewController()
    sut.reset()
  }
  
  override func tearDown() {
    AlertCenter.instance.clearAlerts()
    sut = nil
    super.tearDown()
  }
  
  // MARK: - Alert Container
  
  func testWhenLoaded_noAlertAreShown() {
    XCTAssertTrue(sut.alertContainer.isHidden)
  }
  
  func testWhenAlertPosted_alertContainerIsShown() {
    // given
    let exp = expectation(forNotification: AlertNotification.name, object: nil, handler: nil)
    let alert = Alert("show the container")
    
    // when
    AlertCenter.instance.postAlert(alert: alert)
    
    // then
    wait(for: [exp], timeout: 1)
    XCTAssertFalse(sut.alertContainer.isHidden)
  }
}
