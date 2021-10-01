//
//  ChaseViewPartialMock.swift
//  FitNessTests
//
//  Created by Alex Vorobiev on 01.10.2021.
//  Copyright © 2021 Razeware. All rights reserved.
//

import Foundation
@testable import FitNess

class ChaseViewPartialMock: ChaseView {
  var updateStateCalled = false
  var lastRunner: Double?
  var lastNessie: Double?
  
  override func updateState(runner: Double, nessie: Double) {
    updateStateCalled = true
    lastRunner = runner
    lastNessie = nessie
    super.updateState(runner: runner, nessie: nessie)
  }
}
