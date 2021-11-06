//
//  Logger.swift
//  UIHelpers
//
//  Created by Александр Воробьев on 06.11.2021.
//  Copyright © 2021 Razeware. All rights reserved.
//

import Foundation

public var Logger: LoggerAPI!

public protocol LoggerAPI {
  func logFatal(_ message: String)
  func logDebug(_ message: String)
  func logError(_ error: Error)
}
