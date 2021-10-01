//
//  MockData.swift
//  FitNessTests
//
//  Created by Alex Vorobiev on 01.10.2021.
//  Copyright © 2021 Razeware. All rights reserved.
//

import Foundation
@testable import FitNess

struct MockData: PedometerData {
  let steps: Int
  let distanceTravelled: Double
}
