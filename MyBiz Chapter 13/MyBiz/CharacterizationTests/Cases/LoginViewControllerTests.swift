//
//  LoginViewControllerTests.swift
//  CharacterizationTests
//
//  Created by Александр Воробьев on 02.11.2021.
//  Copyright © 2021 Razeware. All rights reserved.
//

@testable import MyBiz
import XCTest

class LoginViewControllerTests: XCTestCase {
  
  var sut: LoginViewController!
  
  override func setUpWithError() throws {
    try super.setUpWithError()
    sut = UIStoryboard(name: "Main", bundle: nil)
      .instantiateViewController(withIdentifier: "login") as? LoginViewController
    UIApplication.appDelegate.userId = nil
    sut.api = UIApplication.appDelegate.api
    sut.loadViewIfNeeded()
  }
  
  override func tearDownWithError() throws {
    sut = nil
    UIApplication.appDelegate.userId = nil // do the "logout"
    try super.tearDownWithError()
  }
  
  func testSignIn_WithGoodCredentials_doesLogin() {
    // given
    sut.emailField.text = "agent@shield.org"
    sut.passwordField.text = "hailHydra"
    
    // when
    let exp = expectation(for: NSPredicate(block: { vc, _ -> Bool in
      UIApplication.appDelegate.userId != nil
    }), evaluatedWith: sut, handler: nil)
    sut.signIn(sut.signInButton!)
    
    // then
    wait(for: [exp], timeout: 2)
    XCTAssertNotNil(UIApplication.appDelegate.userId, "a successful login sets valid user id")
  }
  
  func testSignIn_WithBadCredentials_showsError() {
    // given
    sut.emailField.text = "bad@credentials.sa"
    sut.passwordField.text = "Shazam!"
    
    // when
    let exp = expectation(for: NSPredicate(block: { vc, _ -> Bool in
      UIApplication.appDelegate.window?.rootViewController?.presentedViewController != nil
    }), evaluatedWith: sut, handler: nil)
    sut.signIn(sut.signInButton!)
    
    // then
    wait(for: [exp], timeout: 2)
    let presentedController = UIApplication.appDelegate.window?.rootViewController?.presentedViewController as? ErrorViewController
    XCTAssertNotNil(presentedController, "should be showing an error controller")
    XCTAssertEqual(presentedController?.alertTitle, "Login Failed")
    XCTAssertEqual(presentedController?.subtitle, "User has not been authenticated.")
  }
  
  func testSignIn_WithBadEmail_showsError() {
    // given
    sut.emailField.text = "badEmail.sa"
    sut.passwordField.text = "hailHydra"
    
    // when
    let exp = expectation(for: NSPredicate(block: { vc, _ -> Bool in
      UIApplication.appDelegate.window?.rootViewController?.presentedViewController != nil
    }), evaluatedWith: sut, handler: nil)
    sut.signIn(sut.signInButton!)
    
    // then
    wait(for: [exp], timeout: 2)
    let presentedController = UIApplication.appDelegate.window?.rootViewController?.presentedViewController as? ErrorViewController
    XCTAssertNotNil(presentedController, "should be showing an error controller")
    XCTAssertEqual(presentedController?.alertTitle, "Login Failed")
    XCTAssertEqual(presentedController?.subtitle, "Check the username or password.")
  }
  
  func testSignIn_WithBadPassword_showsError() {
    // given
    sut.emailField.text = "agent@shield.org"
    sut.passwordField.text = "badpassword"
    
    // when
    let exp = expectation(for: NSPredicate(block: { vc, _ -> Bool in
      UIApplication.appDelegate.window?.rootViewController?.presentedViewController != nil
    }), evaluatedWith: sut, handler: nil)
    sut.signIn(sut.signInButton!)
    
    // then
    wait(for: [exp], timeout: 2)
    let presentedController = UIApplication.appDelegate.window?.rootViewController?.presentedViewController as? ErrorViewController
    XCTAssertNotNil(presentedController, "should be showing an error controller")
    XCTAssertEqual(presentedController?.alertTitle, "Login Failed")
    XCTAssertEqual(presentedController?.subtitle, "Check the username or password.")
  }
}
