//
//  SearchDetail.swift
//  Search
//
//  Created by YHAN on 2023/03/19.
//

import Foundation
import ComposableArchitecture
import SearchInterface

public struct SearchDetail: ReducerProtocol {
  public struct State: Equatable {
    public let id: UUID = UUID()
    public var isDescriptionExpended: Bool
    public var isNewFeatureExpeneded: Bool
    public var result: Result?

    public init(
      isDescriptionExpended: Bool = false,
      isNewFeatureExpeneded: Bool = false,
      result: Result? = nil
    ) {
      self.isDescriptionExpended = isDescriptionExpended
      self.isNewFeatureExpeneded = isNewFeatureExpeneded
      self.result = result
    }
  }

  public enum Action {
    case showMoreUpdates
    case showMoreDescription
  }

  public var body: some ReducerProtocol<State, Action> {
    Reduce { state, action in
      switch action {
      case .showMoreDescription:
        state.isDescriptionExpended = true
        return .none
      case .showMoreUpdates:
        state.isNewFeatureExpeneded = true
        return .none
      default:
        return .none
      }
    }
  }

  public init() {}
}
