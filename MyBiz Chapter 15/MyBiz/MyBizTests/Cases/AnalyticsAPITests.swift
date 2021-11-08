//
//  AnalyticsAPITests.swift
//  MyBizTests
//
//  Created by Александр Воробьев on 08.11.2021.
//  Copyright © 2021 Razeware. All rights reserved.
//

import XCTest
@testable import MyBiz

class AnalyticsAPITests: XCTestCase {
  
  var sut: AnalyticsAPI { sutImplementation }
  var sutImplementation: API!
  var mockSender: MockSender!
  
  override func setUpWithError() throws {
    try super.setUpWithError()
    sutImplementation = API(server: "test")
    mockSender = MockSender()
    sutImplementation.sender = mockSender
  }
  
  override func tearDownWithError() throws {
    sutImplementation = nil
    mockSender = nil
    try super.tearDownWithError()
  }
  
  func testAPI_whenReportSent_thenReportIsSent() {
    // given
    let date = Date()
    let interval: TimeInterval = 20.0
    let report = Report(name: "name", recordedDate: date, type: "type", duration: interval, device: "device", os: "os", appVersion: "appVersion")
    
    // when
    sut.sendReport(report: report)
    
    // then
    XCTAssertNotNil(mockSender.lastSend)
    XCTAssertEqual(report.name, "name")
    XCTAssertEqual((mockSender.lastSend as? Report)?.name, "name")
  }
}
