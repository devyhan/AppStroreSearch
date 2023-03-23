//
//  Project.swift
//  ProjectDescriptionHelpers
//
//  Created by YHAN on 2023/03/20.
//

import ProjectDescription
import ProjectEnvironment

let projectName = "DependencyInjection"
let moduleBaseId = "\(env.bundleId).DependencyInjection"

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
        .SPM.ComposableArchitecture
      ]
    )
  ],
  schemes: []
)
