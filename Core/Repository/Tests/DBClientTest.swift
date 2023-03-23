//
//  DBClientTest.swift
//  ProjectDescriptionHelpers
//
//  Created by YHAN on 2023/03/18.
//

import XCTest
import RepositoryInterface

@testable import Repository

final class DBClientTest: XCTestCase {
  private let userDefaults = UserDefaults.standard
  private var dbClient: DBClient?

  // Given
  override func setUp() {
    super.setUp()
    self.dbClient = DBClientImpl(userDefatults: userDefaults)
  }

  // Dispose
  override func tearDown() {
    super.tearDown()
    self.dbClient = nil
  }

  func test_add_value() {
    // When
    dbClient?.add("TEST_VALUE", forKey: "TEST_KEY")

    // Then
    if let result = userDefaults.stringArray(forKey: "TEST_KEY") {
      XCTAssertEqual(result, ["TEST_VALUE"])
    }
    userDefaults.set(nil, forKey: "TEST_KEY")
  }

  func test_add_multiple_value() {
    // When
    dbClient?.add("TEST_VALUE_01", forKey: "TEST_KEY")
    dbClient?.add("TEST_VALUE_02", forKey: "TEST_KEY")
    dbClient?.add("TEST_VALUE_03", forKey: "TEST_KEY")
    dbClient?.add("TEST_VALUE_04", forKey: "TEST_KEY")

    // Then
    if let result = userDefaults.stringArray(forKey: "TEST_KEY") {
      XCTAssertEqual(
        result,
        [
          "TEST_VALUE_01",
          "TEST_VALUE_02",
          "TEST_VALUE_03",
          "TEST_VALUE_04"
        ]
      )
      userDefaults.set(nil, forKey: "TEST_KEY")
    }
  }

  func test_read_value() {
    // When
    userDefaults.set(["TEST_VALUE"], forKey: "TEST_KEY")
    let sut = dbClient?.read(forKey: "TEST_KEY")

    // Then
    if let sut {
      XCTAssertEqual(["TEST_VALUE"], sut)
    }
    userDefaults.set(nil, forKey: "TEST_KEY")
  }

  func test_update_target_value() throws {
    // When
    userDefaults.set(
      [
        "TEST_VALUE_01",
        "TEST_VALUE_02",
        "TEST_VALUE_03",
        "TEST_VALUE_04"
      ],
      forKey: "TEST_KEY"
    )
    try dbClient?.update("TEST_VALUE_UPDATED", target: "TEST_VALUE_02", forKey: "TEST_KEY")

    // Then
    if let result = userDefaults.stringArray(forKey: "TEST_KEY") {
      XCTAssertEqual(
        result,
        [
          "TEST_VALUE_01",
          "TEST_VALUE_UPDATED",
          "TEST_VALUE_03",
          "TEST_VALUE_04"
        ]
      )
      userDefaults.set(nil, forKey: "TEST_KEY")
    }
  }

  func test_delete_value() {
    // When
    userDefaults.set(
      [
        "TEST_VALUE_01",
        "TEST_VALUE_02",
        "TEST_VALUE_03",
        "TEST_VALUE_04"
      ],
      forKey: "TEST_KEY"
    )
    dbClient?.delete(forKey: "TEST_KEY")

    // Then
    XCTAssertNil(userDefaults.stringArray(forKey: "TEST_KEY"))
  }
}
