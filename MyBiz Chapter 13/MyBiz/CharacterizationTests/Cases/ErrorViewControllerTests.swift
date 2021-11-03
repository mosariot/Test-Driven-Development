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
  
  func whenDefault() {
    sut.loadViewIfNeeded()
  }
  
  func whenSetToLogin() {
    sut.secondaryAction = .init(title: "Try Again", action: {})
    sut.loadViewIfNeeded()
  }
  
  func testViewController_whenSetToLogin_primaryButtonIsOK() {
    // when
    whenSetToLogin()
    
    // then
    XCTAssertEqual(sut.okButton.currentTitle, "OK")
  }
  
  func testViewController_whenSetToLogin_showsTryAgainButton() {
    // when
    whenSetToLogin()
    
    // then
    XCTAssertFalse(sut.secondaryButton.isHidden)
    XCTAssertEqual(sut.secondaryButton.currentTitle, "Try Again")
  }
  
  func testViewController_whenDefault_secondaryButtonIsHidden() {
    // when
    whenDefault()
    
    // then
    XCTAssertNil(sut.secondaryButton.superview)
  }
}
