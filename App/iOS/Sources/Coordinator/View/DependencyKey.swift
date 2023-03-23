//
//  DependencyKey.swift
//  iOS
//
//  Created by YHAN on 2023/03/20.
//

import Foundation
import ComposableArchitecture

import Search
import Networking
import Repository
import DependencyInjection

extension DependencyContainor: DependencyKey {
  public static var liveValue: DependencyContainor {
    DependencyContainor(
      appSearch: AppSearchImpl(
        apiClient: APIClientImpl(),
        dbClient: DBClientImpl(userDefatults: UserDefaults.standard)
      )
    )
  }
}
