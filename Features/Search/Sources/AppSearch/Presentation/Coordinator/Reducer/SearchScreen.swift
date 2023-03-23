//
//  SearchScreen.swift
//  Search
//
//  Created by YHAN on 2023/03/19.
//

import Foundation
import ComposableArchitecture

public struct SearchScreen: ReducerProtocol {
  public enum State: Equatable, Identifiable {
    case search(Search.State)
    case searchDetail(SearchDetail.State)

    public var id: UUID {
      switch self {
      case .search(let state):
        return state.id
      case .searchDetail(let state):
        return state.id
      }
    }
  }

  public enum Action {
    case search(Search.Action)
    case searchDetail(SearchDetail.Action)
  }

  public var body: some ReducerProtocol<State, Action> {
    Scope(
      state: /State.search,
      action: /Action.search
    ) {
      Search()
    }
    Scope(
      state: /State.searchDetail,
      action: /Action.searchDetail
    ) {
      SearchDetail()
    }
  }
}
