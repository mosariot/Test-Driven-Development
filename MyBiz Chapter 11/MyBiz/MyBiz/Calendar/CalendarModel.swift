//
//  CalendarModel.swift
//  MyBiz
//
//  Created by Александр Воробьев on 30.10.2021.
//  Copyright © 2021 Razeware. All rights reserved.
//

import Foundation

class CalendarModel {
  
  let api: API
  var birthdayCallback: ((Result<[Event], Error>) -> Void)?
  var eventsCallback: ((Result<[Event], Error>) -> Void)?
  
  init(api: API) {
    self.api = api
  }
  
  func convertBirthdays(_ employees: [Employee]) -> [Event] {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = Employee.birthdayFormat
    return employees.compactMap {
      if let dayString = $0.birthday,
         let day = dateFormatter.date(from: dayString),
         let nextBirthday = day.next() {
        let title = $0.displayName + " Birthday"
        return Event(name: title, date: nextBirthday, type: .Birthday, duration: 0)
      }
      return nil
    }
  }
  
  func getBirthdays(completion: @escaping (Result<[Event], Error>) -> Void) {
    birthdayCallback = completion
    api.delegate = self
    api.getOrgChart()
  }
  
  func getEvents(completion: @escaping (Result<[Event], Error>) -> Void) {
    eventsCallback = completion
    api.delegate = self
    api.getEvents()
  }
  
  func getAll(completion: @escaping (Result<[Event], Error>) -> Void) {
    getEvents { firstResult in
      self.getBirthdays { secondResult in
        switch (firstResult, secondResult) {
        case (.success(let e1), .success(let e2)):
          completion(.success(e1 + e2))
        case (.failure, _):
          completion(firstResult)
        default:
          completion(secondResult)
        }
      }
    }
  }
}

// MARK: - API Delegate

extension CalendarModel: APIDelegate {
  
  func orgLoaded(org: [Employee]) {
    let birthdays = convertBirthdays(org)
    birthdayCallback?(.success(birthdays))
    birthdayCallback = nil
  }
  
  func orgFailed(error: Error) {
    birthdayCallback?(.failure(error))
    birthdayCallback = nil
  }
  
  func eventsLoaded(events: [Event]) {
    eventsCallback?(.success(events))
    eventsCallback = nil
  }
  func eventsFailed(error: Error) {
    eventsCallback?(.failure(error))
    eventsCallback = nil
  }
  
  func loginFailed(error: Error) {}
  func loginSucceeded(userId: String) {}
  func announcementsLoaded(announcements: [Announcement]) {}
  func announcementsFailed(error: Error) {}
  func productsLoaded(products: [Product]) {}
  func productsFailed(error: Error) {}
  func purchasesLoaded(purchases: [PurchaseOrder]) {}
  func purchasesFailed(error: Error) {}
  func userLoaded(user: UserInfo) {}
  func userFailed(error: Error) {}
}
