//
//  Pedometer.swift
//  FitNess
//
//  Created by Alex Vorobiev on 01.10.2021.
//  Copyright © 2021 Razeware. All rights reserved.
//

import Foundation

protocol Pedometer {
  var pedometerAvailable: Bool { get }
  var permissionDeclined: Bool { get }
  
  func start(dataUpdates: @escaping (PedometerData?, Error?) -> Void, eventUpdates: @escaping (Error?) -> Void)
  
  func stop()
}

protocol PedometerData {
  var steps: Int { get }
  var distanceTravelled: Double { get }
}
