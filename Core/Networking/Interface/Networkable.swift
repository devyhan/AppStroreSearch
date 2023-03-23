//
//  Networkable.swift
//  NetworkingTests
//
//  Created by YHAN on 2023/03/22.
//

import Foundation

public protocol Networkable {
  func data(
    for urlRequest: URLRequest,
    delegate: URLSessionTaskDelegate?
  ) async throws -> (Data, URLResponse)
}

public extension Networkable {
  func data(from urlRequest: URLRequest) async throws -> (Data, URLResponse) {
    try await data(for: urlRequest, delegate: nil)
  }
}

extension URLSession: Networkable {}
