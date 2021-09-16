//
//  StepCountControllerTests.swift
//  FitNessTests
//
//  Created by Alex Vorobiev on 13.09.2021.
//  Copyright © 2021 Razeware. All rights reserved.
//

import XCTest
@testable import FitNess

class StepCountControllerTests: XCTestCase {
  
  var sut: StepCountController!
  
  override func setUp() {
    super.setUp()
    sut = StepCountController()
  }
  
  override func tearDown() {
    sut = nil
    super.tearDown()
  }
  
  // MARK: - Initial State
  
  func testController_whenCreated_buttonLabelIsStart() {
    // when
    sut.viewDidLoad()
    
    // then
    let text = sut.startButton.title(for: .normal)
    XCTAssertEqual(text, AppState.notStarted.nextStateButtonLabel)
  }
  
  // MARK: - In Progress
  
  func testController_whenStartTapped_appIsInProgress() {
    // when
    whenStartStopPauseCalled()
    
    //then
    let state = AppModel.instance.appState
    XCTAssertEqual(state, AppState.inProgress)
  }
  
  func testController_whenStartTapped_buttonLabelIsPause() {
    // when
    whenStartStopPauseCalled()
    
    // then
    let text = sut.startButton.title(for: .normal)
    XCTAssertEqual(text, AppState.inProgress.nextStateButtonLabel)
  }
  
  // MARK: - Helper 'When' Methods
  
  private func whenStartStopPauseCalled() {
    sut.startStopPause(nil)
  }
}
