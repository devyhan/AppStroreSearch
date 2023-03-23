//
//  App.swift
//  SearchDemo
//
//  Created by YHAN on 2023/03/19.
//

import SwiftUI
import ComposableArchitecture

import Search

@main
struct DemoView: App {
  let store = Store(
    initialState: .initialState,
    reducer: Search()
  )

  var body: some Scene {
    WindowGroup {
      SearchView(store: store)
    }
  }
}
