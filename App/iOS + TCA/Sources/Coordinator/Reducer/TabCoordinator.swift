//
//  TabCoordinator.swift
//  iOS
//
//  Created by YHAN on 2023/03/18.
//

import ComposableArchitecture
import TCACoordinators

import Search

struct TabCoordinator: ReducerProtocol {

  struct TabBarContent: Equatable {
    let name: String
    let image: String
    let tag: Int
  }

  struct State: Equatable {
    @BindingState public var currentActiveTab = 4
    var tabBarContents: Array<TabBarContent>
    var today: TodayCoordinator.State
    var game: GameCoordinator.State
    var app: AppCoordinator.State
    var arcade: ArcadeCoordinator.State
    var search: SearchCoordinator.State

    static let initialState = State(
      tabBarContents: [
        TabBarContent(name: "투데이", image: "today", tag: 0),
        TabBarContent(name: "게임", image: "game", tag: 1),
        TabBarContent(name: "앱", image: "app", tag: 2),
        TabBarContent(name: "arcade", image: "arcade", tag: 3),
        TabBarContent(name: "검색", image: "search", tag: 4),
      ],
      today: .initialState,
      game: .initialState,
      app: .initialState,
      arcade: .initialState,
      search: .initialState
    )
  }

  enum Action: BindableAction {
    case binding(BindingAction<TabCoordinator.State>)
    case today(TodayCoordinator.Action)
    case game(GameCoordinator.Action)
    case app(AppCoordinator.Action)
    case arcade(ArcadeCoordinator.Action)
    case search(SearchCoordinator.Action)
  }

  var body: some ReducerProtocol<State, Action> {
    BindingReducer()
    Scope(
      state: \.today,
      action: /Action.today
    ) {
      TodayCoordinator()
    }
    Scope(
      state: \.game,
      action: /Action.game
    ) {
      GameCoordinator()
    }
    Scope(
      state: \.app,
      action: /Action.app
    ) {
      AppCoordinator()
    }
    Scope(
      state: \.arcade,
      action: /Action.arcade
    ) {
      ArcadeCoordinator()
    }
    Scope(
      state: \.search,
      action: /Action.search
    ) {
      SearchCoordinator()
    }
  }
}
