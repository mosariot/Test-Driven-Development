//
//  SettingsTableViewControllerTests.swift
//  MyBizTests
//
//  Created by Александр Воробьев on 08.11.2021.
//  Copyright © 2021 Razeware. All rights reserved.
//

import XCTest
@testable import MyBiz

class SettingsTableViewControllerTests: XCTestCase {
  
  var sut: SettingsTableViewController!
  var mockAnalytics: MockAnalyticsAPI!
  
  override func setUpWithError() throws {
    try super.setUpWithError()
    sut = UIStoryboard(name: "Main", bundle: nil)
      .instantiateViewController(withIdentifier: "settings") as? SettingsTableViewController
    mockAnalytics = MockAnalyticsAPI()
    sut.analytics = mockAnalytics
  }
  
  override func tearDownWithError() throws {
    sut = nil
    mockAnalytics = nil
    try super.tearDownWithError()
  }
  
  func whenShown() {
    sut.viewWillAppear(false)
  }
  
  func testController_whenShown_sendsAnalytics() {
    // when
    whenShown()
    
    // then the report will be sent
    XCTAssertTrue(mockAnalytics.reportsSent)
  }
  
  func testController_whenShownTwice_sendsTwoReports() {
    // when
    whenShown()
    whenShown()
    
    // then
    XCTAssertEqual(mockAnalytics.reportCount, 2)
  }
}
