//
//  AppSearchTranslator.swift
//  Search
//
//  Created by YHAN on 2023/03/20.
//

import SearchInterface

extension AppSearchImpl {
  public func translate(_ dto: ItunesDTO) -> Itunes {
    .init(
      resultCount: dto.resultCount,
      results: dto.results.map {
        .init(
          artworkUrl60: $0.artworkUrl60,
          artworkUrl512: $0.artworkUrl512,
          artworkUrl100: $0.artworkUrl100,
          trackCensoredName: $0.trackCensoredName,
          primaryGenreName: $0.primaryGenreName,
          averageUserRatingForCurrentVersion: $0.averageUserRatingForCurrentVersion,
          screenshotUrls: $0.screenshotUrls,
          userRatingCount: $0.userRatingCount,
          description: $0.description,
          contentAdvisoryRating: $0.contentAdvisoryRating,
          version: $0.version,
          currentVersionReleaseDate: $0.currentVersionReleaseDate,
          releaseNotes: $0.releaseNotes,
          sellerName: $0.sellerName ?? ""
        )
      }
    )
  }
}

