//
//  MockAnalyticsAPI.swift
//  MyBizTests
//
//  Created by Александр Воробьев on 08.11.2021.
//  Copyright © 2021 Razeware. All rights reserved.
//

import Foundation
@testable import MyBiz

class MockAnalyticsAPI: AnalyticsAPI {
  
  var reportsSent = false
  var reportCount = 0
  
  func sendReport(report: Report) {
    reportsSent = true
    reportCount = reportCount + 1
  }
}
