//
//  MockLoginAPI.swift
//  LoginTests
//
//  Created by Александр Воробьев on 06.11.2021.
//  Copyright © 2021 Razeware. All rights reserved.
//

import Foundation
@testable import Login

enum MockError: String, Error {
  case loginError
}

class MockLoginAPI: LoginAPI {
  var loginCalled = false
  var responseError = false
  
  func login(username: String, password: String, completion: @escaping (Result<String, Error>) -> ()) {
    loginCalled = true
    
    if !responseError {
      completion(.success("testuser"))
    } else {
      completion(.failure(MockError.loginError))
    }
  }
}
