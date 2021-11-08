//
//  UINavigationControllerTests.swift
//  MyBizTests
//
//  Created by Александр Воробьев on 08.11.2021.
//  Copyright © 2021 Razeware. All rights reserved.
//

import XCTest
@testable import MyBiz

class UINavigationControllerTests: XCTestCase {
  
  var sut: UINavigationController!
  var mockAnalytics: MockAnalyticsAPI!
  
  override func setUpWithError() throws {
    try super.setUpWithError()
    sut = UINavigationController()
    mockAnalytics = MockAnalyticsAPI()
  }
  
  override func tearDownWithError() throws {
    sut = nil
    mockAnalytics = nil
    try super.tearDownWithError()
  }
  
  func testController_whenNoViewControllers_doesNotStoreAnalytics() {
    // when
    sut.analytics = mockAnalytics
    
    // then
    XCTAssertNil(sut.analytics)
  }
  
  func testController_whenHasTopReportSending_forwardsAnalytics() {
    // given
    let otherController = TestController()
    sut.pushViewController(otherController, animated: false)
    
    // when
    sut.analytics = mockAnalytics
    
    // then
    XCTAssertNotNil(otherController.analytics)
  }
  
}

fileprivate class TestController: UIViewController, ReportSending {
  var analytics: AnalyticsAPI?
}
