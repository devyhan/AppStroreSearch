//
//  SearchCoordinatorView.swift
//  Search
//
//  Created by YHAN on 2023/03/19.
//

import SwiftUI
import ComposableArchitecture
import TCACoordinators

import Utils

public struct SearchCoordinatorView: View {
  let store: StoreOf<SearchCoordinator>

  public init(store: StoreOf<SearchCoordinator>) {
    self.store = store
  }

  public var body: some View {
    TCARouter(store) { screen in
      SwitchStore(screen) {
        CaseLet(
          state: /SearchScreen.State.search,
          action: SearchScreen.Action.search,
          then: SearchView.init
        )
        CaseLet(
          state: /SearchScreen.State.searchDetail,
          action: SearchScreen.Action.searchDetail,
          then: SearchDetailView.init
        )
      }
    }
  }
}
