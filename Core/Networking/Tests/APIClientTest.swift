//
//  APIClientTest.swift
//  NetworkingTests
//
//  Created by YHAN on 2023/03/22.
//

import XCTest
import NetworkingInterface
import Utils

@testable import Networking

final class APIClientTest: XCTestCase {
  private var apiClient: APIClient?
  private var networking: Networkable?

  // Given
  override func setUp() {
    super.setUp()
    self.networking = NetworkingMock()
    if let networking {
      self.apiClient = APIClientImpl(networking: networking)
    }
  }

  // Dispose
  override func tearDown() {
    super.tearDown()
    self.apiClient = nil
    self.networking = nil
  }

  func test_APICLient_execute() async throws {
    // When
    let request = URLs.searchApplication(encodedSearchTerm: "카카오뱅크").router.urlRequest!
    let sut = try await apiClient?.execute(with: request)

    // Then
    let data = "TEST_DATA".data(using: .utf8)!
    XCTAssertEqual(sut, data)
  }
}
