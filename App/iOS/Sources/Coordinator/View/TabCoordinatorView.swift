//
//  TabCoordinator.swift
//  iOS
//
//  Created by YHAN on 2023/03/18.
//

import SwiftUI
import ComposableArchitecture
import TCACoordinators

import Search

struct TabCoordinatorView: View {
  let store: StoreOf<TabCoordinator>

  var body: some View {
    WithViewStore(store) { viewStore in
      TabView(selection: viewStore.binding(\.$currentActiveTab)) {
        TodayCoordinatorView(
          store: store.scope(
            state: \TabCoordinator.State.today,
            action: TabCoordinator.Action.today
          )
        )
        .ignoresSafeArea(.container, edges: .bottom)
        .tabItem {
          Image(viewStore.tabBarContents[0].image)
          Text(viewStore.tabBarContents[0].name)
        }
        .tag(viewStore.tabBarContents[0].tag)

        GameCoordinatorView(
          store: store.scope(
            state: \TabCoordinator.State.game,
            action: TabCoordinator.Action.game
          )
        )
        .ignoresSafeArea(.container, edges: .bottom)
        .tabItem {
          Image(viewStore.tabBarContents[1].image)
          Text(viewStore.tabBarContents[1].name)
        }
        .tag(viewStore.tabBarContents[1].tag)

        AppCoordinatorView(
          store: store.scope(
            state: \TabCoordinator.State.app,
            action: TabCoordinator.Action.app
          )
        )
        .ignoresSafeArea(.container, edges: .bottom)
        .tabItem {
          Image(viewStore.tabBarContents[2].image)
          Text(viewStore.tabBarContents[2].name)
        }
        .tag(viewStore.tabBarContents[2].tag)

        ArcadeCoordinatorView(
          store: store.scope(
            state: \TabCoordinator.State.arcade,
            action: TabCoordinator.Action.arcade
          )
        )
        .ignoresSafeArea(.container, edges: .bottom)
        .tabItem {
          Image(viewStore.tabBarContents[3].image)
          Text(viewStore.tabBarContents[3].name)
        }
        .tag(viewStore.tabBarContents[3].tag)

        SearchCoordinatorView(
          store: store.scope(
            state: \TabCoordinator.State.search,
            action: TabCoordinator.Action.search
          )
        )
        .ignoresSafeArea(.container, edges: .bottom)
        .tabItem {
          Image(viewStore.tabBarContents[4].image)
          Text(viewStore.tabBarContents[4].name)
        }
        .tag(viewStore.tabBarContents[4].tag)
      }
      .background(.ultraThinMaterial)
    }
  }
}

public struct TodayCoordinatorView: View {
  private let store: StoreOf<TodayCoordinator>

  public init(store: StoreOf<TodayCoordinator>) {
    self.store = store
  }

  public var body: some View {
    Text("Today")
      .font(.system(size: 150))
  }
}

public struct TodayCoordinator: ReducerProtocol {
  public struct State: Equatable {
    let id: UUID = .init()

    static let initialState = State()
  }

  public enum Action {

  }

  public var body: some ReducerProtocol<State, Action> {
    Reduce { state, action in
      switch action {
      default:
        return .none
      }
    }
  }

  public init() {}
}

public struct GameCoordinatorView: View {
  private let store: StoreOf<GameCoordinator>

  public init(store: StoreOf<GameCoordinator>) {
    self.store = store
  }

  public var body: some View {
    Text("Game")
      .font(.system(size: 150))
  }
}

public struct GameCoordinator: ReducerProtocol {
  public struct State: Equatable {
    let id: UUID = .init()

    static let initialState = State()
  }

  public enum Action {

  }

  public var body: some ReducerProtocol<State, Action> {
    Reduce { state, action in
      switch action {
      default:
        return .none
      }
    }
  }

  public init() {}
}

public struct AppCoordinatorView: View {
  private let store: StoreOf<AppCoordinator>

  public init(store: StoreOf<AppCoordinator>) {
    self.store = store
  }

  public var body: some View {
    Text("App")
      .font(.system(size: 150))
  }
}

public struct AppCoordinator: ReducerProtocol {
  public struct State: Equatable {
    let id: UUID = .init()

    static let initialState = State()
  }

  public enum Action {

  }

  public var body: some ReducerProtocol<State, Action> {
    Reduce { state, action in
      switch action {
      default:
        return .none
      }
    }
  }

  public init() {}
}

public struct ArcadeCoordinatorView: View {
  private let store: StoreOf<ArcadeCoordinator>

  public init(store: StoreOf<ArcadeCoordinator>) {
    self.store = store
  }

  public var body: some View {
    Text("Arcade")
      .font(.system(size: 150))
  }
}

public struct ArcadeCoordinator: ReducerProtocol {
  public struct State: Equatable {
    let id: UUID = .init()

    static let initialState = State()
  }

  public enum Action {

  }

  public var body: some ReducerProtocol<State, Action> {
    Reduce { state, action in
      switch action {
      default:
        return .none
      }
    }
  }

  public init() {}
}
