//
//  CMPedometer+Pedometer.swift
//  FitNess
//
//  Created by AlexVorobiev on 01.10.2021.
//  Copyright © 2021 Razeware. All rights reserved.
//

import CoreMotion

extension CMPedometer: Pedometer {
  var pedometerAvailable: Bool {
    CMPedometer.isStepCountingAvailable() && CMPedometer.isDistanceAvailable() && CMPedometer.authorizationStatus() != .restricted
  }
  
  var permissionDeclined: Bool {
    CMPedometer.authorizationStatus() == .denied
  }
  
  func start(dataUpdates: @escaping (PedometerData?, Error?) -> Void, eventUpdates: @escaping (Error?) -> Void) {
    startEventUpdates { event, error in
      eventUpdates(error)
    }
    
    startUpdates(from: Date()) { data, error in
      dataUpdates(data, error)
    }
  }
  
  func stop() {
    stopUpdates()
  }
}

extension CMPedometerData: PedometerData {
  var steps: Int {
    numberOfSteps.intValue
  }
  
  var distanceTravelled: Double {
    distance?.doubleValue ?? 0
  }
}
