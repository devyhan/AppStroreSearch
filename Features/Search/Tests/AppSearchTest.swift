//
//  AppSearchTest.swift
//  SearchTests
//
//  Created by YHAN on 2023/03/21.
//

import XCTest
import ComposableArchitecture

import Utils
import SearchInterface
import DependencyInjection

@testable import Search

@MainActor
final class AppSearchTests: XCTestCase {
  private var userDefaults: UserDefaults?

  private let dummyITunes: Itunes = .init(
    resultCount: 1,
    results: [
      .init(
        artworkUrl60: "TEST_ART_WORK_URL_160",
        artworkUrl512: "TEST_ART_WORK_URL_1512",
        artworkUrl100: "TEST_ART_WORK_URL_100",
        trackCensoredName: "TEST_TRACK_CONSORED_NAME",
        primaryGenreName: "TEST_PRIMARY_GENRE_NAME",
        averageUserRatingForCurrentVersion: 3.3,
        screenshotUrls: [
          "TEST_SCREENSHOT_URLS_01",
          "TEST_SCREENSHOT_URLS_02",
          "TEST_SCREENSHOT_URLS_03",
          "TEST_SCREENSHOT_URLS_04",
          "TEST_SCREENSHOT_URLS_05"
        ],
        userRatingCount: 123_456_789,
        description: "TEST_DESCRIPTION",
        contentAdvisoryRating: "TEST_CONTENT_ADVISORY_RATING",
        version: "TEST_VERSION",
        currentVersionReleaseDate: "TEST_CURRENT_VERSION_RELEASE_DATA",
        releaseNotes: "TEST_RELEASE_NOTES",
        sellerName: "TEST_SOLLER_NAME"
      )
    ]
  )

  private let dummyEmptyITunes: Itunes = .init(
    resultCount: 0,
    results: []
  )

  override func setUp() {
    super.setUp()
    self.userDefaults = UserDefaults.standard
  }

  func test_user_live_search_list_tap_scenario() async {
    let store = TestStore(
      initialState: Search.State(searchText: .init()),
      reducer: Search()
    )
    let mainQueue = DispatchQueue.test
    store.dependencies.mainQueue = mainQueue.eraseToAnyScheduler()

    let userDefaultsKey = UserDefaultKeys.AppSearch.saveKeyword.rawValue

    // 저장된 키워드 가져오기
    await store.send(.getKeywords) {
      $0.recentSearchesKeywords = ["TEST_SAVED_DATA"]
    }

    // 텍스트 입력, 로딩 시작
    await store.send(.searchText("TEST_VALUE")) {
      $0.searchText = "TEST_VALUE"
      $0.isLoading = true
    }

    // 입력시 debounce 0.3초
    await mainQueue.advance(by: 0.3)

    // iTunesSearch API통신
    let _ = await store.dependencies.containor.appSearch.iTunesSearch(appName: "TEST_VALUE")

    // 성공 시 결과 값 입력, 로딩 종료
    await store.receive(.inputTextResponse(.success(self.dummyITunes))) {
      $0.searchContents = self.dummyITunes
      $0.isLoading = false
      $0.isEmptyResponse = false
    }

    // 통신으로 얻은 앱 Row를 탭 하였을 때 검색 필드에 값을 입력, 로딩 시작
    await store.send(.liveSearchResultsTapped("TEST_TRACK_CONSORED_NAME")) {
      $0.searchText = "TEST_TRACK_CONSORED_NAME"
      $0.isLoading = true
    }

    // 텍스트 필드에 입력된 값으로 재 통신
    let _ = await store.dependencies.containor.appSearch.iTunesSearch(appName: "TEST_TRACK_CONSORED_NAME")

    // 입력값 로컬 스토리지에 검색어 저장
    await store.receive(.saveKeyword("TEST_TRACK_CONSORED_NAME"))
    if let comparisonValue = userDefaults?.stringArray(forKey: userDefaultsKey) {
      XCTAssertEqual(["TEST_SAVED_DATA"], comparisonValue)
      userDefaults?.set(nil, forKey: "key")
    }

    // 입력된 결과 성공 시 앱 리스트 업데이트 및 앱 리스트 화면으로 전환, 로딩 종료
    await store.receive(.tapTextResponse(.success(self.dummyITunes))) {
      $0.searchContents = self.dummyITunes
      $0.isAppListScreenPresented = true
      $0.isLoading = false
    }
  }

  func test_user_delete_textField_sinario() async {
    let store = TestStore(
      initialState: Search.State(searchText: "TEST_DEFAULT_VALUE"),
      reducer: Search()
    )

    // 텍스트 입력값이 없거나 지웠을 때
    await store.send(.searchText("")) {
      $0.searchText = ""
      $0.isAppListScreenPresented = false
      $0.isLoading = false
    }

    // 저장된 키워드 가져오기
    await store.receive(.getKeywords) {
      $0.recentSearchesKeywords = ["TEST_SAVED_DATA"]
    }
  }

  func test_user_onSubmit_sinario() async {
    let store = TestStore(
      initialState: Search.State(searchText: "TEST_DEFAULT_VALUE"),
      reducer: Search()
    )

    // 입력된 텍스트를 키보드의 검색을 이용해 검색 실행
    await store.send(.onSubmit) {
      $0.isLoading = true
    }

    // 입력되어있는 키워드를 저장
    await store.receive(.saveKeyword(store.state.searchText))

    // 입력된 결과 성공 시 앱 리스트 업데이트 및 앱 리스트 화면으로 전환, 로딩 종료
    await store.receive(.tapTextResponse(.success(self.dummyITunes))) {
      $0.searchContents = self.dummyITunes
      $0.isAppListScreenPresented = true
      $0.isLoading = false
    }
  }

  func test_user_additional_searches_when_search_complete_sinario() async {
    let store = TestStore(
      initialState: Search.State(
        searchText: "TEST_DEFAULT_VALUE",
        isAppListScreenPresented: true
      ),
      reducer: Search()
    )

    let mainQueue = DispatchQueue.test
    store.dependencies.mainQueue = mainQueue.eraseToAnyScheduler()

    // 앱 탐색 화면인 상태에서 검색 필드에 추가로 입력을 하려는 상황
    await store.send(.searchText("TEST_DEFAULT_VALUE_ADDITIONAL")) {
      $0.searchText = "TEST_DEFAULT_VALUE_ADDITIONAL"
      $0.isAppListScreenPresented = false
      $0.isLoading = true
    }

    // 입력시 debounce 0.3초
    await mainQueue.advance(by: 0.3)

    // 성공 시 결과 값 입력, 로딩 종료
    await store.receive(.inputTextResponse(.success(self.dummyITunes))) {
      $0.searchContents = self.dummyITunes
      $0.isLoading = false
      $0.isEmptyResponse = false
    }
  }

  func test_user_search_finished_to_but_empty_list_sinario() async {
    let store = TestStore(
      initialState: Search.State(),
      reducer: Search()
    )

    // 성공 시 결과 값 입력, 로딩 종료
    await store.send(.inputTextResponse(.success(self.dummyEmptyITunes))) {
      $0.searchContents = self.dummyEmptyITunes
      $0.isLoading = false
      $0.isEmptyResponse = true
    }
  }

  func test_user_recently_search_item_tap() async {
    let store = TestStore(
      initialState: Search.State(),
      reducer: Search()
    )

    // 저장된 키워드 가져오기
    await store.send(.getKeywords) {
      $0.recentSearchesKeywords = ["TEST_SAVED_DATA"]
    }

    // 저장된 키워드 탭
    await store.send(.recentlySearchitemTap(store.state.recentSearchesKeywords.first!)) {
      $0.isAppListScreenPresented = true
      $0.searchText = "TEST_SAVED_DATA"
    }

    // 성공 시 결과 값 입력, 로딩 종료
    await store.receive(.tapTextResponse(.success(self.dummyITunes))) {
      $0.searchContents = self.dummyITunes
      $0.isLoading = false
      $0.isEmptyResponse = false
    }
  }
}
