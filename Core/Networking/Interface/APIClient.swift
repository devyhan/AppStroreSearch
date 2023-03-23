//
//  APIClient.swift
//  NetworkingInterface
//
//  Created by YHAN on 2023/03/20.
//

import Foundation

public protocol APIClient {
  func execute(with urlRouter: URLRequest) async throws -> Data
}
