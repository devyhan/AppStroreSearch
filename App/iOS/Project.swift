//
//  Project.swift
//  ProjectDescriptionHelpers
//
//  Created by YHAN on 2023/03/18.
//

import ProjectDescription
import ProjectDescriptionHelpers
import ProjectEnvironment

let targetBaseBundleId = "\(env.bundleId).iOS"
let settings: SettingsDictionary = [:]

let project = Project(
  name: "\(env.name) iOS",
  settings: env.settings,
  targets: [
    Target(
      name: "iOS",
      platform: .iOS,
      product: .app,
      productName: env.name,
      bundleId: targetBaseBundleId,
      deploymentTarget: env.deploymentTarget,
      infoPlist: env.infoPlist,
      sources: ["Sources/**"],
      resources: ["../../Resources/**"],
      dependencies: [
        .project(target: "Search",  path: .relativeToRoot("Features/Search")),
        .project(target: "Utils",  path: .relativeToRoot("Share/Utils")),
        .project(target: "Networking",  path: .relativeToRoot("Core/Networking")),
        .project(target: "Repository",  path: .relativeToRoot("Core/Repository")),
        .project(target: "DependencyInjection",  path: .relativeToRoot("DependencyInjection")),
        .SPM.ComposableArchitecture,
        .SPM.TCACoordinators
      ]
    ),
    Target(
      name: "iOSTests",
      platform: .iOS,
      product: .unitTests,
      bundleId: "\(targetBaseBundleId).tests",
      infoPlist: env.infoPlist,
      sources: ["Tests/**"],
      dependencies: [
        .target(name: "iOS"),
        .xctest
      ]
    )
  ],
  schemes: []
)
