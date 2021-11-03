//
//  ErrorViewControllerTests.swift
//  CharacterizationTests
//
//  Created by Александр Воробьев on 03.11.2021.
//  Copyright © 2021 Razeware. All rights reserved.
//

@testable import MyBiz
import XCTest

class ErrorViewControllerTests: XCTestCase {
  
  var sut: ErrorViewController!
  
  override func setUpWithError() throws {
    try super.setUpWithError()
    sut = UIStoryboard(name: "Main", bundle: nil)
      .instantiateViewController(withIdentifier: "error") as? ErrorViewController
  }
  
  override func tearDownWithError() throws {
    sut = nil
    try super.tearDownWithError()
  }
  
  func testSecondaryButton_whenActionSet_hasCorrectTitle() {
    // given
    let action = ErrorViewController.SecondaryAction(title: "title") {}
    sut.secondaryAction = action
    
    // when
    sut.loadViewIfNeeded()
    
    // then
    XCTAssertEqual(sut.secondaryButton.currentTitle, "title")
  }
  
  func testSecondaryAction_whenButtonTapped_isInvoked() {
    // given
    let exp = expectation(description: "secondary action")
    var actionHappened = false
    let action = ErrorViewController.SecondaryAction(title: "action") {
      actionHappened = true
      exp.fulfill()
    }
    sut.secondaryAction = action
    sut.loadViewIfNeeded()
    
    // when
    sut.secondaryAction(())
    
    // then
    wait(for: [exp], timeout: 2)
    XCTAssertTrue(actionHappened)
  }
}
