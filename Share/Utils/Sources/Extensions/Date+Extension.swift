//
//  Date+Extension.swift
//  Utils
//
//  Created by YHAN on 2023/03/21.
//

import Foundation

public extension Date {
  func toRelativeDateString() -> String {
    let calendar = Calendar.current
    let now = Date()

    if calendar.isDateInToday(self) {
      return "오늘"
    }

    if calendar.isDateInYesterday(self) {
      return "어제"
    }

    else {
      let daysAgo = calendar.dateComponents(
        [.day],
        from: self,
        to: now
      ).day ?? 0

      let monthsAgo = calendar.dateComponents(
        [.month],
        from: self,
        to: now
      ).month ?? 0

      if monthsAgo > 0 {
        return "\(monthsAgo)개월 전"
      }
      else {
        return "\(daysAgo)일 전"
      }
    }
  }
}

public extension String {
  var convertISO8601: Date? {
    let dateFormatter = ISO8601DateFormatter()
    dateFormatter.formatOptions = [.withInternetDateTime]
    return dateFormatter.date(from: self)
  }
}
