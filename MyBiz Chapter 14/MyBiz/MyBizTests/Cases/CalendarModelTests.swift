//
//  CalendarModelTests.swift
//  MyBizTests
//
//  Created by Александр Воробьев on 30.10.2021.
//  Copyright © 2021 Razeware. All rights reserved.
//

@testable import MyBiz
import XCTest

class CalendarModelTests: XCTestCase {
  
  var sut: CalendarModel!
  var mockAPI: MockAPI!
  
  override func setUpWithError() throws {
    try super.setUpWithError()
    mockAPI = MockAPI()
    sut = CalendarModel(api: mockAPI)
  }
  
  override func tearDownWithError() throws {
    mockAPI = nil
    sut = nil
    try super.tearDownWithError()
  }
  
  func testModel_whenGivenEmployeeList_generatesBirthdayEvents() {
    // given
    let employees = mockEmployees()
    
    // when
    let events = sut.convertBirthdays(employees)
    
    // then
    let expectedEvents = mockBirthdayEvents()
    XCTAssertEqual(events, expectedEvents)
  }
  
  func testModel_whenBirthdaysLoaded_getBirthdayEvents() {
    // given
    let exp = expectation(description: "birthdays loaded")
    mockAPI.mockEmployees = mockEmployees()
    
    // when
    var loadedEvents: [Event]?
    sut.getBirthdays { res in
      loadedEvents = try? res.get()
      exp.fulfill()
    }
    
    // then
    wait(for: [exp], timeout: 2)
    let expectedEvents = mockBirthdayEvents()
    XCTAssertEqual(loadedEvents, expectedEvents)
  }
  
  func testModel_whenGetOrgFails_returnsError() {
    // given
    let exp = expectation(description: "birthdays loaded")
    mockAPI.mockError = staticMockError
    
    // when
    var receivedError: Error?
    sut.getBirthdays { res in
      if case .failure(let error) = res {
       receivedError = error
      }
      exp.fulfill()
    }
    
    // then
    wait(for: [exp], timeout: 2)
    XCTAssertNotNil(receivedError)
  }
  
  func testModel_whenEventsLoaded_getsEvents() {
    // given
    let expectedEvents = mockEvents()
    mockAPI.mockEvents = expectedEvents
    let exp = expectation(description: "events loaded")
    
    // when
    var loadedEvents: [Event]?
    sut.getEvents { res in
      loadedEvents = try? res.get()
      exp.fulfill()
    }
    
    // then
    wait(for: [exp], timeout: 2)
    XCTAssertEqual(loadedEvents, expectedEvents)
  }
  
  func testModel_whenGetEventsFails_returnsError() {
    // given
    mockAPI.mockError = staticMockError
    let exp = expectation(description: "events loaded")
    
    // when
    var recievedError: Error?
    sut.getEvents { res in
      if case .failure(let error) = res {
        recievedError = error
      }
      exp.fulfill()
    }
    
    // then
    wait(for: [exp], timeout: 2)
    XCTAssertNotNil(recievedError)
  }
  
  func testModel_whenGetAll_getsBirthdaysAndEvents() {
    // given
    let exp = expectation(description: "all loaded")
    mockAPI.mockEvents = mockEvents()
    mockAPI.mockEmployees = mockEmployees()
    let expectedEvents = mockAPI.mockEvents + mockBirthdayEvents()
    
    var loadedEvents: [Event]!
    sut.getAll { res in
      loadedEvents = try? res.get()
      exp.fulfill()
    }
    
    // then
    wait(for: [exp], timeout: 2)
    XCTAssertEqual(loadedEvents.sorted(), expectedEvents.sorted())
  }
}
