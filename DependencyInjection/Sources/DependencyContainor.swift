//
//  DependencyKey.swift
//  DependencyInjection
//
//  Created by YHAN on 2023/03/20.
//

import Foundation
import ComposableArchitecture

import Utils
import SearchInterface

// MARK: - DI Containor

public final class DependencyContainor {
  public let appSearch: AppSearch

  public init(appSearch: AppSearch) {
    self.appSearch = appSearch
  }
}

// MARK: - Testable Values

extension DependencyContainor: TestDependencyKey {
  public static var testValue: DependencyContainor {
    .init(appSearch: AppSearchMock())
  }
}
