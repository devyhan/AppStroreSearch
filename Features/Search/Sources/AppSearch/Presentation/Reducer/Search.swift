//
//  Search.swift
//  Search
//
//  Created by YHAN on 2023/03/19.
//

import Foundation
import ComposableArchitecture

import Utils
import DependencyInjection
import SearchInterface

public struct Search: ReducerProtocol {
  public struct State: Equatable {
    public let id: UUID
    public var recentSearchesKeywords: [String]
    public var searchText: String
    public var isAppListScreenPresented: Bool

    public var searchContents: Itunes?

    public var isLoading: Bool
    public var isEmptyResponse: Bool

    public static let initialState = State(
      id: UUID(),
      recentSearchesKeywords: Array<String>(),
      searchText: String(),
      isAppListScreenPresented: false,
      searchContents: nil,
      isLoading: false,
      isEmptyResponse: false
    )

    public init(
      id: UUID = UUID(),
      recentSearchesKeywords: [String] = [],
      searchText: String = "",
      isAppListScreenPresented: Bool = false,
      searchContents: Itunes? = nil,
      isLoading: Bool = false,
      isEmptyResponse: Bool = false
    ) {
      self.id = id
      self.recentSearchesKeywords = recentSearchesKeywords
      self.searchText = searchText
      self.isAppListScreenPresented = isAppListScreenPresented
      self.searchContents = searchContents
      self.isLoading = isLoading
      self.isEmptyResponse = isEmptyResponse
    }
  }

  public enum Action: Equatable {
    case searchText(String)
    case inputTextResponse(TaskResult<Itunes?>)
    case tapTextResponse(TaskResult<Itunes?>)
    case saveKeyword(String)
    case getKeywords
    case onSubmit
    case liveSearchResultsTapped(String)
    case pushToDetail(Result)
    case recentlySearchitemTap(String)
  }

  @Dependency(\.containor) var containor
  @Dependency(\.mainQueue) var mainQueue

  public var body: some ReducerProtocol<State, Action> {
    Reduce { state, action in
      enum DebounceId {}
      switch action {
      case let .searchText(value):
        state.searchText = value
        if state.isAppListScreenPresented, value.count > 0 {
          state.isAppListScreenPresented = false
          state.isLoading = true
          return .task {
            await .inputTextResponse(
              TaskResult {
                await containor.appSearch.iTunesSearch(appName: value)
              }
            )
          }
          .debounce(id: DebounceId.self, for: 0.3, scheduler: mainQueue)
        }

        if value.count > 0 {
          state.isLoading = true
          return .task {
            await .inputTextResponse(
              TaskResult {
                await containor.appSearch.iTunesSearch(appName: value)
              }
            )
          }
          .debounce(id: DebounceId.self, for: 0.3, scheduler: mainQueue)
        } else {
          state.isEmptyResponse = false
          state.isAppListScreenPresented = false
          state.isLoading = false
          return .send(.getKeywords)
        }

      case let .inputTextResponse(.success(itunes)):
        state.isLoading = false
        state.searchContents = itunes
        state.isEmptyResponse = false
        if let itunes {
          if itunes.results.isEmpty {
            state.isEmptyResponse = true
          }
        }
        return .none

      case let .inputTextResponse(.failure(error)):
        Logger.error(error)
        state.isLoading = false
        return .none

      case let .liveSearchResultsTapped(tapValue):
        state.searchText = tapValue
        state.isLoading = true
        return .send(.saveKeyword(tapValue))

      case let .tapTextResponse(.success(itunes)):
        state.searchContents = itunes
        state.isAppListScreenPresented = true
        state.isLoading = false
        state.isEmptyResponse = false
        if let itunes {
          if itunes.results.isEmpty {
            state.isEmptyResponse = true
          }
        }
        return .none

      case let .tapTextResponse(.failure(error)):
        Logger.error(error)
        state.isLoading = false
        return .none

      case .getKeywords:
        state.recentSearchesKeywords = containor.appSearch.getKeyword()
        return .none

      case let .saveKeyword(keyword):
        if !keyword.isEmpty {
          containor.appSearch.saveKeyword(keyword)
        }
        return .task {
          await .tapTextResponse(
            TaskResult {
              await containor.appSearch.iTunesSearch(appName: keyword)
            }
          )
        }

      case .onSubmit:
        state.isLoading = true
        state.isEmptyResponse = false
        return .send(.saveKeyword(state.searchText))

      case let .recentlySearchitemTap(item):
        state.isAppListScreenPresented = true
        state.searchText = item
        return .task {
          await .tapTextResponse(
            TaskResult {
              await containor.appSearch.iTunesSearch(appName: item)
            }
          )
        }
      default:
        return .none
      }
    }
  }
  public init() {}
}

