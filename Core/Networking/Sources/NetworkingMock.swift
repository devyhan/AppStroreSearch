//
//  NetworkingMock.swift
//  NetworkingTests
//
//  Created by YHAN on 2023/03/22.
//

import Foundation

import Utils
import NetworkingInterface

public class NetworkingMock: Networkable {
  public func data(
    for urlRequest: URLRequest,
    delegate: URLSessionTaskDelegate?
  ) async throws -> (Data, URLResponse) {
    let url = urlRequest.url!
    let response = HTTPURLResponse(
      url: url,
      statusCode: 200,
      httpVersion: nil,
      headerFields: nil
    )!
    let data = "TEST_DATA".data(using: .utf8)!
    return try (Result<Data, Error>.success(data).get(), response)
  }
}
