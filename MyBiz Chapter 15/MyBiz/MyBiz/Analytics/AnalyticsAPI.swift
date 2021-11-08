//
//  AnalyticsAPI.swift
//  MyBiz
//
//  Created by Александр Воробьев on 08.11.2021.
//  Copyright © 2021 Razeware. All rights reserved.
//

import Foundation

protocol AnalyticsAPI {
  func sendReport(report: Report)
}

protocol ReportSending: AnyObject {
  var analytics: AnalyticsAPI? { get set }
}
