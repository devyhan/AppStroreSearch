//
//  Logger+Extension.swift
//  Utils
//
//  Created by YHAN on 2023/03/19.
//

import Foundation

public extension Logger {
  static func debug(_ message: Any, _ arguments: Any...) {
    log(message, arguments, level: .debug)
  }

  static func info(_ message: Any, _ arguments: Any...) {
    log(message, arguments, level: .info)
  }

  static func network(_ message: Any, _ arguments: Any...) {
    log(message, arguments, level: .network)
  }

  static func error(_ message: Any, _ arguments: Any...) {
    log(message, arguments, level: .network)
  }

  static func custom(category: String, _ message: Any, _ arguments: Any...) {
    log(message, arguments, level: .custom(categoryName: category))
  }
}
