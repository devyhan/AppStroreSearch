//
//  Project.swift
//  ProjectDescriptionHelpers
//
//  Created by YHAN on 2023/03/19.
//

import ProjectDescription
import ProjectEnvironment

let projectName = "Utils"
let moduleBaseId = "\(env.bundleId).Utils"

let project = Project(
  name: projectName,
  settings: env.settings,
  targets: [
    Target(
      name: projectName,
      platform: .iOS,
      product: .framework,
      bundleId: moduleBaseId,
      deploymentTarget: env.deploymentTarget,
      infoPlist: env.infoPlist,
      sources: ["Sources/**"],
      dependencies: [
        .SPM.URLRouter
      ]
    )
  ],
  schemes: []
)
