//
//  API.swift
//  CharacterizationTests
//
//  Created by Александр Воробьев on 30.10.2021.
//  Copyright © 2021 Razeware. All rights reserved.
//

@testable import MyBiz
import Foundation

let staticMockError = NSError(domain: "Mock", code: 0, userInfo: nil)

class MockAPI: API {
  
  var mockEvents: [Event] = []
  var mockEmployees: [Employee] = []
  var mockError: Error?
  
  override func getEvents() {
    DispatchQueue.main.async {
      if let error = self.mockError {
        self.delegate?.eventsFailed(error: error)
      } else {
        self.delegate?.eventsLoaded(events: self.mockEvents)
      }
    }
  }
  
  override func getOrgChart() {
    DispatchQueue.main.async {
      if let error = self.mockError {
        self.delegate?.orgFailed(error: error)
      } else {
        self.delegate?.orgLoaded(org: self.mockEmployees)
      }
    }
  }
}

func mockEmployees() -> [Employee] {
  [
    Employee(id: "Cap", givenName: "Steve", familyName: "Rogers", location: "Brooklyn",
             manager: nil, directReports: [], birthday: "07-04-1920"),
    Employee(id: "Surfer", givenName: "Norrin", familyName: "Radd", location: "Zenn-La",
             manager: nil, directReports: [], birthday: "03-01-1966"),
    Employee(id: "Wasp", givenName: "Hope", familyName: "van Dyne", location: "San Francisco",
             manager: nil, directReports: [], birthday: "01-02-1979")
  ]
}

func mockBirthdayEvents() -> [Event] {
  let dateFormatter = DateFormatter()
  dateFormatter.dateFormat = Employee.birthdayFormat
  return [
    Event(name: "Steve Rogers Birthday", date: dateFormatter.date(from: "07-04-1920")!.next()!, type: .Birthday, duration: 0),
    Event(name: "Norrin Radd Birthday", date: dateFormatter.date(from: "03-01-1966")!.next()!, type: .Birthday, duration: 0),
    Event(name: "Hope van Dyne Birthday", date: dateFormatter.date(from: "01-02-1979")!.next()!, type: .Birthday, duration: 0)
  ]
}

func mockEvents() -> [Event] {
  [
    Event(name: "Event 1", date: Date(), type: .Appointment, duration: .hours(1)),
    Event(name: "Event 2", date: Date(timeIntervalSinceNow: .days(20)), type: .Meeting, duration: .minutes(30)),
    Event(name: "Event 3", date: Date(timeIntervalSinceNow: -.days(1)), type: .DomesticHoliday, duration: .days(1))
  ]
}
