//
//  ViewControllers.swift
//  FitNessTests
//
//  Created by Alex Vorobiev on 15.09.2021.
//  Copyright © 2021 Razeware. All rights reserved.
//

import UIKit
@testable import FitNess

func loadRootViewController() -> RootViewController {
  UIApplication.shared.windows[0].rootViewController as! RootViewController
}
