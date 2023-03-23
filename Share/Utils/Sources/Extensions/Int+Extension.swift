//
//  Int+Extension.swift
//  Utils
//
//  Created by YHAN on 2023/03/21.
//

import Foundation

extension Int {
  public func toAbbreviation() -> String {
    let number = Double(self)
    let sign = ((number < 0) ? "-" : "")
    let numFormatter = NumberFormatter()
    numFormatter.maximumFractionDigits = 1
    var abbreviation = ""

    if number >= 10000 {
      abbreviation = sign + numFormatter.string(from: NSNumber(value: number/10000))! + "만"
    } else if number >= 1000 {
      abbreviation = sign + numFormatter.string(from: NSNumber(value: number/1000))! + "천"
    } else {
      abbreviation = sign + String(format: "%.0f", number)
    }
    return abbreviation
  }
}
