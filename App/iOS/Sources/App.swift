//
//  App.swift
//  iOS
//
//  Created by YHAN on 2023/03/18.
//

import SwiftUI
import ComposableArchitecture

/// 앱의 전반적인 구조 설계는 README.md에 문서화 하였습니다.

@main
struct AppView: App {
  let store = Store(
    initialState: .initialState,
    reducer: TabCoordinator()
      .dependency(\.containor, .liveValue)
  )

  var body: some Scene {
    WindowGroup {
      TabCoordinatorView(store: store)
    }
  }
}
