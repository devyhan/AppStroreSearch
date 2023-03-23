//
//  Data+Extension.swift
//  Utils
//
//  Created by YHAN on 2023/03/19.
//

import Foundation

public extension Data {
  var prettyPrintedJSONString: NSString {
    guard
      let object = try? JSONSerialization.jsonObject(with: self, options: []),
      let data = try? JSONSerialization.data(
        withJSONObject: object,
        options: [.prettyPrinted]
      ),
      let prettyPrintedString = NSString(
        data: data,
        encoding: String.Encoding.utf8.rawValue
      ) else {
      return NSString()
    }

    return prettyPrintedString
  }
}
