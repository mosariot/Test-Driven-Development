//
//  MockSender.swift
//  MyBizTests
//
//  Created by Александр Воробьев on 08.11.2021.
//  Copyright © 2021 Razeware. All rights reserved.
//

import Foundation
@testable import MyBiz

class MockSender: RequestSender {
  
  var lastSend: Decodable? = nil
  
  func send<T: Decodable>(request: URLRequest, success: ((T) -> ())?, failure: ((Error) -> ())?) {
    let decoder = JSONDecoder()
    decoder.dateDecodingStrategy = .iso8601
    
    do {
      let obj = try decoder.decode(T.self, from: request.httpBody!)
      lastSend = obj
      success?(obj)
    } catch {
      print("error decoding a \(T.self): \(error)")
      failure?(error)
    }
  }
}
