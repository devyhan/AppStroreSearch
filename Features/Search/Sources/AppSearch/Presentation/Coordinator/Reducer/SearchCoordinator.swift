//
//  SearchCoordinator.swift
//  Search
//
//  Created by YHAN on 2023/03/19.
//

import Foundation
import ComposableArchitecture
import TCACoordinators

public struct SearchCoordinator: ReducerProtocol {
  public struct State: Equatable, IndexedRouterState {
    public var id: UUID
    public var routes: [Route<SearchScreen.State>]

    public static let initialState = State(
      id: .init(),
      routes: [.root(.search(.initialState), embedInNavigationView: true)]
    )
  }

  public enum Action: IndexedRouterAction {
    case routeAction(Int, action: SearchScreen.Action)
    case updateRoutes([Route<SearchScreen.State>])
  }

  public var body: some ReducerProtocol<State, Action> {
    Reduce { state, action in
      switch action {
      case let .routeAction(_, action: .search(.pushToDetail(result))):
        state.routes.push(.searchDetail(.init(result: result)))
        return .none
      default:
        return .none
      }
    }
    .forEachRoute {
      SearchScreen()
    }
  }

  public init() {}
}
