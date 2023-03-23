//
//  Project.swift
//  ProjectDescriptionHelpers
//
//  Created by YHAN on 2023/03/20.
//

import ProjectDescription
import ProjectEnvironment

let projectName = "Repository"
let moduleBaseId = "\(env.bundleId).Repository"

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
      dependencies: [
        .target(name: "\(projectName)Interface"),
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
  ],
  schemes: []
)
