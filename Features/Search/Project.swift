//
//  Project.swift
//  ProjectDescriptionHelpers
//
//  Created by YHAN on 2023/03/18.
//

import ProjectDescription
import ProjectEnvironment

let projectName = "Search"
let moduleBaseId = "\(env.bundleId).Home"

let project = Project(
  name: projectName,
  settings: env.settings,
  targets: [
    Target(
      name: projectName,
      platform: .iOS,
      product: .staticFramework,
      bundleId: moduleBaseId,
      deploymentTarget: env.deploymentTarget,
      infoPlist: env.infoPlist,
      sources: ["Sources/**"],
      resources: ["../../Resources/**"],
      dependencies: [
        .target(name: "\(projectName)Interface"),
        .project(target: "Components",  path: .relativeToRoot("UserInterface/Components")),
        .project(target: "Utils",  path: .relativeToRoot("Share/Utils")),
        .project(target: "DependencyInjection",  path: .relativeToRoot("DependencyInjection"))
      ]
    ),
    Target(
      name: "\(projectName)Interface",
      platform: .iOS,
      product: .framework,
      bundleId: "\(moduleBaseId).interface",
      deploymentTarget: env.deploymentTarget,
      infoPlist: env.infoPlist,
      sources: ["Interface/**"],
      dependencies: []
    ),
    Target(
      name: "\(projectName)Tests",
      platform: .iOS,
      product: .unitTests,
      bundleId: "\(moduleBaseId).tests",
      deploymentTarget: env.deploymentTarget,
      infoPlist: env.infoPlist,
      sources: ["Tests/**"],
      dependencies: [
        .target(name: projectName),
        .xctest
      ]
    ),
    Target(
      name: "\(projectName)Demo",
      platform: .iOS,
      product: .app,
      bundleId: "\(moduleBaseId).Demo",
      deploymentTarget: env.deploymentTarget,
      infoPlist: env.infoPlist,
      sources: ["Demo/Sources/**"],
      dependencies: [
        .target(name: projectName)
      ]
    ),
  ],
  schemes: [],
  resourceSynthesizers: [.assets()]
)
