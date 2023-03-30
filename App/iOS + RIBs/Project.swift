//
//  Project.swift
//  ProjectDescriptionHelpers
//
//  Created by 조요한 on 2023/03/30.
//

import ProjectDescription
import ProjectDescriptionHelpers
import ProjectEnvironment

let targetBaseBundleId = "\(env.bundleId).iOS.RIBs"
let settings: SettingsDictionary = [:]

let project = Project(
  name: "\(env.name) iOS (UIKit, RIBs)",
  settings: env.settings,
  targets: [
    Target(
      name: "iOS (UIKit, RIBs)",
      platform: .iOS,
      product: .app,
      productName: "\(env.name) (UIKit, RIBs)",
      bundleId: targetBaseBundleId,
      deploymentTarget: env.deploymentTarget,
      infoPlist: env.infoPlistUIKit,
      sources: ["Sources/**"],
      resources: ["../../Resources/**"],
      dependencies: [
        .project(target: "Search",  path: .relativeToRoot("Features/Search")),
        .project(target: "Utils",  path: .relativeToRoot("Share/Utils")),
        .project(target: "Networking",  path: .relativeToRoot("Core/Networking")),
        .project(target: "Repository",  path: .relativeToRoot("Core/Repository")),
        .project(target: "DependencyInjection",  path: .relativeToRoot("DependencyInjection")),
        .SPM.RIBs,
        .SPM.RxSwift,
        .SPM.RxCocoa
      ]
    ),
    Target(
      name: "iOSTests",
      platform: .iOS,
      product: .unitTests,
      bundleId: "\(targetBaseBundleId).tests",
      infoPlist: env.infoPlistUIKit,
      sources: ["Tests/**"],
      dependencies: [
        .target(name: "iOS (UIKit, RIBs)"),
        .xctest
      ]
    )
  ],
  schemes: []
)
