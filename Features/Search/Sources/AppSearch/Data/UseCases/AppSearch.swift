//
//  AppSearch.swift
//  Search
//
//  Created by YHAN on 2023/03/19.
//

import Foundation

import Utils
import SearchInterface
import NetworkingInterface
import RepositoryInterface

public struct AppSearchImpl: AppSearch {
  private let apiClient: APIClient
  private let dbClient: DBClient

  public init(
    apiClient: APIClient,
    dbClient: DBClient
  ) {
    self.apiClient = apiClient
    self.dbClient = dbClient
  }

  public func iTunesSearch(appName: String) async -> Itunes? {
    guard let request = URLs.searchApplication(encodedSearchTerm: appName).router.urlRequest else {
      return nil
    }
    do {
      let data = try await apiClient.execute(with: request)
      let response = try JSONDecoder().decode(ItunesDTO.self, from: data)
      return self.translate(response)
    } catch {
      Logger.error(error)
      return nil
    }
  }

  public func saveKeyword(_ keyword: String) {
    dbClient.add(
      keyword,
      forKey: UserDefaultKeys.AppSearch.saveKeyword.rawValue
    )
  }

  public func getKeyword() -> Array<String> {
    let key = UserDefaultKeys.AppSearch.saveKeyword.rawValue
    guard let allStrings = dbClient.read(forKey: key) else { return [] }
    let startIndex = max(0, allStrings.count - 4)
    return Array(allStrings[startIndex..<allStrings.count])
  }
}
