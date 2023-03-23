//
//  AppSearchModel.swift
//  Search
//
//  Created by YHAN on 2023/03/20.
//

import Foundation

public struct Itunes: Equatable, Hashable {
  public let resultCount: Int
  public let results: Array<Result>

  public init(resultCount: Int, results: Array<Result>) {
    self.resultCount = resultCount
    self.results = results
  }
}

public struct Result: Equatable, Hashable {
  /// 아이콘
  public let artworkUrl60, artworkUrl512, artworkUrl100: String?

  /// 타이틀
  public let trackCensoredName: String?

  /// 카테고리
  public let primaryGenreName: String?

  /// 별점
  public let averageUserRatingForCurrentVersion: Double?

  /// 스크린샷
  public let screenshotUrls: Array<String>?

  /// 리뷰 수
  public let userRatingCount: Int?

  /// 앱 상세
  public let description: String?

  /// 연령
  public let contentAdvisoryRating: String?

  /// 버전
  public let version: String?

  /// 버전 릴리즈 날짜
  public let currentVersionReleaseDate: String?

  /// 릴리즈 노트
  public let releaseNotes: String?

  /// 판매자
  public let sellerName: String?

  public init(
    artworkUrl60: String?,
    artworkUrl512: String?,
    artworkUrl100: String?,
    trackCensoredName: String?,
    primaryGenreName: String?,
    averageUserRatingForCurrentVersion: Double?,
    screenshotUrls: Array<String>?,
    userRatingCount: Int?,
    description: String?,
    contentAdvisoryRating: String?,
    version: String?,
    currentVersionReleaseDate: String?,
    releaseNotes: String?,
    sellerName: String?
  ) {
    self.artworkUrl60 = artworkUrl60
    self.artworkUrl512 = artworkUrl512
    self.artworkUrl100 = artworkUrl100
    self.trackCensoredName = trackCensoredName
    self.primaryGenreName = primaryGenreName
    self.averageUserRatingForCurrentVersion = averageUserRatingForCurrentVersion
    self.screenshotUrls = screenshotUrls
    self.userRatingCount = userRatingCount
    self.description = description
    self.contentAdvisoryRating = contentAdvisoryRating
    self.version = version
    self.currentVersionReleaseDate = currentVersionReleaseDate
    self.releaseNotes = releaseNotes
    self.sellerName = sellerName
  }
}
