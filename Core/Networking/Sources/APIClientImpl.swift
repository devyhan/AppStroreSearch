//
//  APIClient.swift
//  Networking
//
//  Created by YHAN on 2023/03/19.
//

import Foundation

import Utils
import NetworkingInterface

public final class APIClientImpl: APIClient {
  private let networking: Networkable

  public init(networking: Networkable = URLSession.shared) {
    self.networking = networking
  }

  public func execute(with urlRequest: URLRequest) async throws -> Data {
    let startTime = CFAbsoluteTimeGetCurrent()
    recordRequest(with: urlRequest)

    let (data, response) = try await networking.data(from: urlRequest)

    guard let httpResponse = response as? HTTPURLResponse else {
      throw APIError.unknown
    }

    guard httpResponse.statusCode == 200 else {
      throw APIError.init(statusCode: httpResponse.statusCode)
    }

    let endTime = CFAbsoluteTimeGetCurrent()
    let responseTime = Double(endTime - startTime)
    recodeResponse(
      with: response,
      data: data,
      responseTime: responseTime
    )

    return data
  }

  private func recordRequest(with urlRequest: URLRequest) {
    Logger.network("--> \(urlRequest.httpMethod ?? "") \(urlRequest.url?.absoluteString.removingPercentEncoding ?? "")")
    if let hasHeader = urlRequest.allHTTPHeaderFields {
      hasHeader.forEach {
        Logger.network("HEADER \($0.key): \($0.value)")
      }
    }

    if let base64EncodedString = urlRequest.httpBody?.base64EncodedString(),
       let data = Data(base64Encoded: base64EncodedString),
       let body = String(data: data, encoding: .utf8) {
      Logger.network("BODY: \(body)")
    }

    if let url = urlRequest.url,
       let components = URLComponents(url: url, resolvingAgainstBaseURL: false),
       let queryItems = components.queryItems {
        for item in queryItems {
          Logger.network("QUERY_ITEM: \(item.name): \(item.value ?? "")")
        }
    }

    Logger.network("--> END \(urlRequest.httpMethod ?? "") (\(urlRequest.httpBody?.count ?? 0)-byte body)")
  }

  private func recodeResponse(
    with response: URLResponse,
    data: Data,
    responseTime: Double
  ) {
    guard let httpResponse = response as? HTTPURLResponse else { return }
    Logger.network("<-- \(httpResponse.statusCode) \(httpResponse.url?.absoluteString.removingPercentEncoding ?? "") (\(responseTime)ms)")

    httpResponse.allHeaderFields
      .forEach { Logger.network("HEADER: \($0.key): \($0.value)") }

    Logger.network("BODY: \(data.prettyPrintedJSONString)")

    Logger.network("<-- END HTTP \(data.count)-byte body")
  }
}
