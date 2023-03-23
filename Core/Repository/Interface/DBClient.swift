//
//  DBClient.swift
//  NetworkingInterface
//
//  Created by YHAN on 2023/03/20.
//

import Foundation

public protocol DBClient {
  func add(_ value: String?, forKey keyName: String)
  func read(forKey keyName: String) -> Array<String>?
  func update(
    _ value: String?,
    target: String?,
    forKey keyName: String
  ) throws
  func delete(forKey keyName: String)
}
