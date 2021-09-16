//
//  RootViewController+Tests.swift
//  FitNessTests
//
//  Created by Александр Воробьев on 15.09.2021.
//  Copyright © 2021 Razeware. All rights reserved.
//

import UIKit
@testable import FitNess

extension RootViewController {
  
  var stepController: StepCountController {
    children.first { $0 is StepCountController } as! StepCountController
  }
}
