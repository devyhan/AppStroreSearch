//
//  URLs.swift
//  ProjectDescriptionHelpers
//
//  Created by YHAN on 2023/03/19.
//

import Foundation
import URLRouter

public enum URLs: URLRoutable {
  /// URL: https://itunes.apple.com/search?term=\(encodedSearchTerm)&entity=software
  case searchApplication(encodedSearchTerm: String)

  public var router: URLRouter {
    URLRouter {
      BaseURL("https://itunes.apple.com")
      switch self {
      case let .searchApplication(encodedSearchTerm):
        Request {
          URL {
            Path("search")
            Query {
              Field(encodedSearchTerm, forKey: "term")
              Field("software", forKey: "entity")
              Field("KR", forKey: "contry")
              Field("ko_kr", forKey: "lang")
            }
          }
        }
      }
    }
  }
}
