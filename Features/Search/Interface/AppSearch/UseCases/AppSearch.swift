//
//  AppSearch.swift
//  Search
//
//  Created by YHAN on 2023/03/20.
//

import Foundation

public protocol AppSearch {
  func iTunesSearch(appName: String) async -> Itunes?
  func saveKeyword(_ keyword: String)
  func getKeyword() -> Array<String>
}
