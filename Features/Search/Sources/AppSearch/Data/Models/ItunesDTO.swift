//
//  ItunesDTO.swift
//  Search
//
//  Created by YHAN on 2023/03/20.
//

import Foundation

public struct ItunesDTO: Codable {
  public let resultCount: Int
  public let results: Array<ResultDTO>
}

public struct ResultDTO: Codable {
  public let artworkUrl60, artworkUrl512, artworkUrl100: String?
  public let trackCensoredName: String?
  public let primaryGenreName: String?
  public let averageUserRatingForCurrentVersion: Double?
  public let screenshotUrls: Array<String>?
  public let userRatingCount: Int?
  public let description: String?
  public let contentAdvisoryRating: String?
  public let version: String?
  public let currentVersionReleaseDate: String?
  public let sellerName: String?
  public let releaseNotes: String?
}
