//
//  SearchView.swift
//  Search
//
//  Created by YHAN on 2023/03/19.
//

import SwiftUI
import ComposableArchitecture

import Components

public struct SearchView: View {
  private let store: StoreOf<Search>
  private let statelessViewStore: ViewStore<Void, Search.Action>
  private let actionlessViewStore: ViewStore<Search.State, Never>

  public init(store: StoreOf<Search>) {
    self.store = store
    self.statelessViewStore = .init(store.stateless)
    self.actionlessViewStore = .init(store.actionless)
  }

  public var body: some View {
    WithViewStore(store) { viewStore in
      NavigationView {
        ZStack {
          ScrollView(showsIndicators: false) {
            if viewStore.isAppListScreenPresented {
              appExploreView
            }

            if !viewStore.isAppListScreenPresented {
              if viewStore.searchText != "" {
                liveSearchView
              } else {
                recentSearchTermsView(viewStore)
              }
            }
          }
        }
        .overlay(emptyListView)
        .overlay(loadingView)
        .padding(.horizontal, 20)
        .navigationTitle("검색")
        .contentShape(Rectangle())
        .onTapGesture(perform: endEditing)
        .onAppear {
          viewStore.send(.getKeywords)
        }
      }
      .searchable(
        text: viewStore.binding(
          get: \.searchText,
          send: Search.Action.searchText
        ),
        placement: .navigationBarDrawer(displayMode: .always),
        prompt: "게임, 앱, 스토리 등"
      )
      .onSubmit(of: .search) {
        viewStore.send(.onSubmit)
      }
    }
  }

  private var appExploreView: some View {
    let APP_SCREENSHOT_WIDTH = UIScreen.main.bounds.width / 3.35

    return VStack(spacing: .zero) {
      if let contents = actionlessViewStore.searchContents?.results {
        ForEach(contents, id: \.self) { content in
          VStack(spacing: .zero) {
            HStack(spacing: 8) {
              AsyncImage(url: URL(string: content.artworkUrl100 ?? "")) { image in
                image.image?
                  .resizable()
                  .scaledToFill()
              }
              .frame(width: 60, height: 60)
              .clipShape(RoundedRectangle(cornerRadius: 15))

              VStack(alignment: .leading, spacing: .zero) {
                Text(content.trackCensoredName ?? "_")
                  .font(.system(size: 16))
                  .fontWeight(.medium)
                  .lineLimit(1)
                Text(content.primaryGenreName ?? "_")
                  .foregroundColor(Asset.gray8A8A8D.color)
                  .font(.system(size: 13))
                  .fontWeight(.medium)
                  .lineLimit(1)

                HStack(spacing: 3) {
                  let rating = content.averageUserRatingForCurrentVersion
                  RatingView(
                    rating: Decimal(rating ?? 0),
                    color: Asset.gray8A8A8D.color,
                    backgroundColor: Asset.gray8A8A8D.color,
                    spacing: 2
                  )
                  .frame(width: 60, height: 10)

                  Text("\((content.userRatingCount ?? 0).toAbbreviation())")
                    .foregroundColor(Asset.gray8A8A8D.color)
                    .font(.system(size: 12))
                    .fontWeight(.medium)
                }
              }

              Spacer()

              RoundTextButton(
                title: "받기",
                backgroundColor: Asset.grayEEEEEE.color
              ) {

              }
              .foregroundColor(Asset.blue.color)
              .font(.system(size: 14, weight: .bold))
              .frame(width: 70, height: 30)
            }
            .padding(.bottom, 17)

            HStack(spacing: 8) {
              if let screenshotUrls = content.screenshotUrls {
                ForEach(Array(screenshotUrls.prefix(3)), id: \.self) { screenshotUrl in
                  AsyncImage(url: URL(string: screenshotUrl)) { image in
                    image.image?
                      .resizable()
                      .scaledToFill()
                  }
                  .frame(width: APP_SCREENSHOT_WIDTH, height: 230)
                  .clipShape(RoundedRectangle(cornerRadius: 15))
                }
              }
            }
          }
          .contentShape(Rectangle())
          .onTapGesture {
            statelessViewStore.send(.pushToDetail(content))
          }
          .padding(.bottom, 40)
        }
      }
    }
    .padding(.top, 20)
  }

  private func recentSearchTermsView(_ viewStore: ViewStoreOf<Search>) -> some View {
    LazyVStack {
      HStack {
        Text("최근 검색어")
          .font(.title2)
          .fontWeight(.bold)
        Spacer()
      }

      if !viewStore.recentSearchesKeywords.isEmpty {
        ForEach(viewStore.recentSearchesKeywords.reversed(), id: \.self) { item in
          Rectangle()
            .fill(Color.gray)
            .frame(height: 1)
            .opacity(0.3)
          HStack {
            Text(item)
              .foregroundColor(Asset.blue.color)
              .font(.title2)
              .lineLimit(1)
              .contentShape(Rectangle())
              .onTapGesture {
                viewStore.send(.recentlySearchitemTap(item))
              }
            Spacer()
          }
        }
      }
    }
    .padding(.top, 20)
    .overlay(
      ZStack {
        if viewStore.recentSearchesKeywords.isEmpty {
          Text("최근 검색어가 없습니다.")
            .foregroundColor(Asset.gray8A8A8D.color)
            .font(.system(size: 30, weight: .bold))
            .padding(.top, 300)
        }
      }
    )
  }

  private var liveSearchView: some View {
    LazyVStack {
      if let contents = actionlessViewStore.searchContents?.results {
        ForEach(Array(contents.prefix(4)), id: \.self) { content in
          if content != contents.first {
            Rectangle()
              .fill(Color.gray)
              .frame(height: 1)
              .opacity(0.3)
          }

          HStack {
            Asset.search.image
              .resizable()
              .frame(width: 10, height: 10)
              .opacity(0.3)

            Text(content.trackCensoredName ?? "_")
              .font(.caption)

            Spacer()
          }
          .contentShape(Rectangle())
          .onTapGesture {
            statelessViewStore.send(.liveSearchResultsTapped(content.trackCensoredName ?? "_"))
            endEditing()
          }
        }
      }
    }
    .padding(.top, 20)
  }

  private var emptyListView: some View {
    ZStack {
      if actionlessViewStore.isEmptyResponse {
        Asset.background.color
        VStack(spacing: 8) {
          Text("결과 없음")
            .font(.system(size: 30, weight: .heavy))
          Text("\'\(actionlessViewStore.searchText)\'")
            .font(.system(size: 13, weight: .regular))
            .foregroundColor(Asset.gray8A8A8D.color)
        }
      }
    }
  }

  private var loadingView: some View {
    ZStack {
      if actionlessViewStore.isLoading {
        Asset.background.color
        ProgressView()
      }
    }
  }

  private func endEditing() {
    UIApplication.shared.sendAction(
      #selector(UIResponder.resignFirstResponder),
      to: nil,
      from: nil,
      for: nil
    )
  }
}
