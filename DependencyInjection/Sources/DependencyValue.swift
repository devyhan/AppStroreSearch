//
//  DependencyKey.swift
//  DependencyInjection
//
//  Created by YHAN on 2023/03/22.
//

import Dependencies

extension DependencyValues {
  public var containor: DependencyContainor {
    get { self[DependencyContainor.self] }
    set { self[DependencyContainor.self] = newValue }
  }
}
