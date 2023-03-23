//
//  Settings.swift
//  ProjectEnvironment
//
//  Created by YHAN on 2023/03/19.
//

import ProjectDescription

private let debugSettings: SettingsDictionary = [
  "OTHER_SWIFT_FLAGS": SettingValue(stringLiteral: "-D LOG")
]

private let releaseSettings: SettingsDictionary = [:]

extension Settings {
  public static var settings: Self {
    .settings(
      configurations: [
        .debug(
          name: "Debug",
          settings: debugSettings,
          xcconfig: nil
        ),
        .release(
          name: "Release",
          settings: releaseSettings,
          xcconfig: nil
        ),
      ]
    )
  }
}

