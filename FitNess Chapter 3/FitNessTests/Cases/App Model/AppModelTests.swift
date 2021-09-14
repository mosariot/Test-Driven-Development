//
//  AppModelTests.swift
//  FitNessTests
//
//  Created by Alex Vorobiev on 10.09.2021.
//  Copyright © 2021 Razeware. All rights reserved.
//

import XCTest
@testable import FitNess

class AppModelTests: XCTestCase {
  
  var sut: AppModel!
  
  override func setUp() {
    super.setUp()
    sut = AppModel()
  }
  
  override func tearDown() {
    sut = nil
    super.tearDown()
  }
  
  func testAppModel_whenInitialized_isInNotStartedState() {
    let initialState = sut.appState
    XCTAssertEqual(initialState, AppState.notStarted)
  }
  
  func testAppModel_whenStarted_isInInProgressState() {
    // when
    sut.start()
    
    // then
    let observedState = sut.appState
    XCTAssertEqual(observedState, AppState.inProgress)
  }
}
