//
//  MockPedometer.swift
//  FitNessTests
//
//  Created by Alex Vorobiev on 01.10.2021.
//  Copyright © 2021 Razeware. All rights reserved.
//

import CoreMotion
@testable import FitNess

class MockPedometer: Pedometer {
  private(set) var started: Bool = false
  private(set) var stopped: Bool = false
  var pedometerAvailable: Bool = true
  var permissionDeclined: Bool = false
  var error: Error?
  var updateBlock: ((Error?) -> Void)?
  var dataBlock: ((PedometerData?, Error?) -> Void)?
  
  func start(dataUpdates: @escaping (PedometerData?, Error?) -> Void, eventUpdates: @escaping (Error?) -> Void) {
    started = true
    updateBlock = eventUpdates
    dataBlock = dataUpdates
    DispatchQueue.global(qos: .default).async {
      self.updateBlock?(self.error)
    }
  }
  
  func sendData(_ data: PedometerData?) {
    dataBlock?(data, nil)
  }
  
  func sendError(_ error: Error?) {
    dataBlock?(nil, error)
  }
  
  func stop() {
    stopped = true
  }
  
  static let notAuthorizedError = NSError(domain: CMErrorDomain, code: Int(CMErrorMotionActivityNotAuthorized.rawValue), userInfo: nil)
}
