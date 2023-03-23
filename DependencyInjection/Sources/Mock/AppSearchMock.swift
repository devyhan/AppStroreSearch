//
//  AppSearchMock.swift
//  DependencyInjection
//
//  Created by YHAN on 2023/03/21.
//

import Foundation
import ComposableArchitecture

import Utils
import SearchInterface

public final class AppSearchMock: AppSearch {
  var isReturnEmptyList: Bool

  public init(isReturnEmptyList: Bool = false) {
    self.isReturnEmptyList = isReturnEmptyList
  }

  public func iTunesSearch(appName: String) async -> Itunes? {
    return isReturnEmptyList ? dummyEmptyITunes : dummyITunes
  }

  public func getKeyword() -> Array<String> {
    ["TEST_SAVED_DATA"]
  }

  public func saveKeyword(_ keyword: String) {
    let key = UserDefaultKeys.AppSearch.saveKeyword.rawValue
    UserDefaults.standard.set(["TEST_SAVED_DATA"], forKey: key)
  }
}

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
