//
//  CalendarViewControllerTests.swift
//  CharacterizationTests
//
//  Created by Александр Воробьев on 30.10.2021.
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
  
  func testLoadEvents_getData() {
    // given
    let eventJson = """
      [{"name": "Alien invasion", "date":
    "2019-04-10T12:00:00+0000",
      "type": "Appointment", "duration": 3600.0},
       {"name": "Interview with Hydra", "date":
    "2019-04-10T17:30:00+0000",
      "type": "Appointment", "duration": 1800.0},
       {"name": "Panic attack", "date": "2019-04-17T14:00:00+0000",
      "type": "Meeting", "duration": 3600.0}]
    """
    let data = Data(eventJson.utf8)
    let decoder = JSONDecoder()
    decoder.dateDecodingStrategy = .iso8601
    let expectedEvents = try! decoder.decode([Event].self, from: data)
    mockAPI.mockEvents = expectedEvents
    
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
