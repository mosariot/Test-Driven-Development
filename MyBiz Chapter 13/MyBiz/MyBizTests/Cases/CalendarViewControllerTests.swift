//
//  CalendarViewControllerTests.swift
//  MyBizTests
//
//  Created by Александр Воробьев on 01.11.2021.
//  Copyright © 2021 Razeware. All rights reserved.
//

@testable import MyBiz
import XCTest

class CalendarViewControllerTests: XCTestCase {
  
  var sut: CalendarViewController!
  var mockAPI: MockAPI!
  
  override func setUpWithError() throws {
    try super.setUpWithError()
    sut = UIStoryboard(name: "Main", bundle: nil)
      .instantiateViewController(withIdentifier: "Calendar") as? CalendarViewController
    mockAPI = MockAPI()
    sut.api = mockAPI
    sut.loadViewIfNeeded()
  }
  
  override func tearDownWithError() throws {
    mockAPI = nil
    sut = nil
    try super.tearDownWithError()
  }
  
  func testLoadEvents_getsBirthdays() {
    // given
    mockAPI.mockEmployees = mockEmployees()
    let expectedEvents = mockBirthdayEvents()
    
    // when
    let exp = expectation(for: NSPredicate(block: { vc, _ -> Bool in
      !(vc as! CalendarViewController).events.isEmpty
    }), evaluatedWith: sut, handler: nil)
    sut.loadEvents()
    
    // then
    wait(for: [exp], timeout: 2)
    XCTAssertEqual(sut.events, expectedEvents)
  }
  
  func testLoadEvents_getsBirthdaysAndEvents() {
    // given
    mockAPI.mockEmployees = mockEmployees()
    mockAPI.mockEvents = mockEvents()
    let expectedEvents = mockAPI.mockEvents + mockBirthdayEvents()
    
    // when
    let exp = expectation(for: NSPredicate(block: { vc, _ -> Bool in
      !(vc as! CalendarViewController).events.isEmpty
    }), evaluatedWith: sut, handler: nil)
    sut.loadEvents()
    
    // then
    wait(for: [exp], timeout: 2)
    XCTAssertEqual(sut.events, expectedEvents)
  }
}
