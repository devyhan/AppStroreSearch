//
//  Logger.swift
//  Utils
//
//  Created by YHAN on 2023/03/19.
//

import Foundation
import os.log

extension OSLog {
  static let subsystem = Bundle.main.bundleIdentifier!
  static let network = OSLog(subsystem: subsystem, category: "Network")
  static let debug = OSLog(subsystem: subsystem, category: "Debug")
  static let info = OSLog(subsystem: subsystem, category: "Info")
  static let error = OSLog(subsystem: subsystem, category: "Error")
}

public struct Logger {
  enum Level {
    case debug
    case info
    case network
    case error
    case custom(categoryName: String)

    fileprivate var category: String {
      switch self {
      case .debug:
        return "Debug"
      case .info:
        return "Info"
      case .network:
        return "Network"
      case .error:
        return "Error"
      case .custom(let categoryName):
        return categoryName
      }
    }

    fileprivate var osLog: OSLog {
      switch self {
      case .debug:
        return OSLog.debug
      case .info:
        return OSLog.info
      case .network:
        return OSLog.network
      case .error:
        return OSLog.error
      case .custom:
        return OSLog.debug
      }
    }

    fileprivate var osLogType: OSLogType {
      switch self {
      case .debug:
        return .debug
      case .info:
        return .info
      case .network:
        return .default
      case .error:
        return .error
      case .custom:
        return .debug
      }
    }
  }

  static func log(_ message: Any, _ arguments: [Any], level: Level) {
    #if LOG
    let extraMessage: String = arguments.map({ String(describing: $0) }).joined(separator: " ")
    let logger = os.Logger(subsystem: OSLog.subsystem, category: level.category)
    let logMessage = "\(message) \(extraMessage)"
    switch level {
    case .debug,
        .custom:
      logger.debug("\(logMessage, privacy: .public)")
    case .info:
      logger.info("\(logMessage, privacy: .public)")
    case .network:
      logger.log("\(logMessage, privacy: .public)")
    case .error:
      logger.error("\(logMessage, privacy: .public)")
    }
    #endif
  }
}
