//
//  DBClientImpl.swift
//  NetworkingInterface
//
//  Created by YHAN on 2023/03/20.
//

import Foundation

import RepositoryInterface

public final class DBClientImpl: DBClient {
  public let userDefatults: UserDefaults

  public init(userDefatults: UserDefaults) {
    self.userDefatults = userDefatults
  }

  public func add(_ value: String?, forKey keyName: String) {
    if
      let currentValue = self.read(forKey: keyName),
      let value
    {
      var newValue: Array<String> = currentValue
      newValue.append(value)
      userDefatults.set(newValue, forKey: keyName)
      return
    }

    userDefatults.set(Array(arrayLiteral: value), forKey: keyName)
  }

  public func read(forKey keyName: String) -> Array<String>? {
    userDefatults.stringArray(forKey: keyName)
  }

  public func update(
    _ value: String? = nil,
    target: String? = nil,
    forKey keyName: String
  ) throws {
    if let value,
       let target,
       var array = self.read(forKey: keyName),
       let index = self.read(forKey: keyName)?.firstIndex(of: target)
    {
      array[index] = value
      userDefatults.set(array, forKey: keyName)
      return
    } else {
      throw DBError.update(description: "업데이트에 실패하였습니다.")
    }
  }

  public func delete(forKey keyName: String) {
    userDefatults.set(nil, forKey: keyName)
  }
}
