//
//  Notification+Tests.swift
//  FitNessTests
//
//  Created by Alex Vorobiev on 27.09.2021.
//  Copyright © 2021 Razeware. All rights reserved.
//

import Foundation
@testable import FitNess

extension Notification {
  var alert: Alert? {
    userInfo?[AlertNotification.Keys.alert] as? Alert
  }
}
