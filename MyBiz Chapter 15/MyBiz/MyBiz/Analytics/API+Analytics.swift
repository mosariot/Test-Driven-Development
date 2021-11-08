//
//  API+Analytics.swift
//  MyBiz
//
//  Created by Александр Воробьев on 08.11.2021.
//  Copyright © 2021 Razeware. All rights reserved.
//

import Foundation

extension API: AnalyticsAPI {
  
  func sendReport(report: Report) {
    try? logAnalytics(analytics: report) { _ in }
  }
}

extension API {
  
  func logAnalytics(analytics: Report, completion: @escaping (Result<Report, Error>) -> ()) throws {
    let url = URL(string: server + "api/analytics")!
    var request = URLRequest(url: url)
    if let token = token?.token {
      let bearer = "Bearer \(token)"
      request.addValue(bearer, forHTTPHeaderField: "Authorization")
    }
    request.addValue("application/json", forHTTPHeaderField: "Content-Type")
    request.httpMethod = "POST"
    
    let coder = JSONEncoder()
    coder.dateEncodingStrategy = .iso8601
    let data = try coder.encode(analytics)
    request.httpBody = data
    
    sender.send(request: request) { savedEvent in
      completion(.success(savedEvent))
    } failure: { error in
      completion(.failure(error))
    }
  }
}
