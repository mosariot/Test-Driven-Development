//
//  UINavigationController+Analytics.swift
//  MyBiz
//
//  Created by Александр Воробьев on 08.11.2021.
//  Copyright © 2021 Razeware. All rights reserved.
//

import UIKit

extension UINavigationController: ReportSending {
  
  var analytics: AnalyticsAPI? {
    get {
      (topViewController as? ReportSending)?.analytics
    }
    set {
      (topViewController as? ReportSending)?.analytics = newValue
    }
  }
}
