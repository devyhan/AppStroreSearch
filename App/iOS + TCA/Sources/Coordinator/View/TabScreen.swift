//
//  TabScreen.swift
//  iOS
//
//  Created by YHAN on 2023/03/18.
//

import Foundation
import ComposableArchitecture

import Search

struct TabScreen: ReducerProtocol {
  enum State: Equatable, Identifiable {
    case today(TodayCoordinator.State)
    case game(GameCoordinator.State)
    case app(AppCoordinator.State)
    case arcade(ArcadeCoordinator.State)
    case search(SearchCoordinator.State)

    var id: UUID {
      switch self {
      case let .today(state):
        return state.id
      case let .game(state):
        return state.id
      case let .app(state):
        return state.id
      case let .arcade(state):
        return state.id
      case let .search(state):
        return state.id
      }
    }
  }

  enum Action {
    case today(TodayCoordinator.Action)
    case game(GameCoordinator.Action)
    case app(AppCoordinator.Action)
    case arcade(ArcadeCoordinator.Action)
    case search(SearchCoordinator.Action)
  }

  var body: some ReducerProtocol<State, Action> {
    Scope(
      state: /State.today,
      action: /Action.today
    ) {
      TodayCoordinator()
    }
    Scope(
      state: /State.game,
      action: /Action.game
    ) {
      GameCoordinator()
    }
    Scope(
      state: /State.app,
      action: /Action.app
    ) {
      AppCoordinator()
    }
    Scope(
      state: /State.arcade,
      action: /Action.arcade
    ) {
      ArcadeCoordinator()
    }
    Scope(
      state: /State.search,
      action: /Action.search
    ) {
      SearchCoordinator()
    }
  }
}
