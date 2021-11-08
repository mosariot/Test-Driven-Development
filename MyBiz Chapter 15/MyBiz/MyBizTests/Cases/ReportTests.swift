//
//  ReportTests.swift
//  MyBizTests
//
//  Created by Александр Воробьев on 08.11.2021.
//  Copyright © 2021 Razeware. All rights reserved.
//

import XCTest
@testable import MyBiz

class ReportTests: XCTestCase {
  
  var sut: Report!
  
  override func setUpWithError() throws {
    try super.setUpWithError()
  }
  
  override func tearDownWithError() throws {
    try super.tearDownWithError()
  }
  
  func testReport_whenMake_makesReport() {
    // given
    let event = AnalyticsEvent.loginShown
    let type = AnalyticsType.buttonTap
    
    // when
    let sut = Report.make(event: event, type: type)
    
    // then
    XCTAssertEqual(sut.name, event.rawValue)
    XCTAssertEqual(sut.type, type.rawValue)
    XCTAssertNil(sut.duration)
    XCTAssertEqual(sut.device, UIDevice.current.model)
    XCTAssertEqual(sut.os, UIDevice.current.systemVersion)
    XCTAssertEqual(sut.appVersion, Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String)
  }
}
