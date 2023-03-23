//
//  Project.swift
//  ProjectDescriptionHelpers
//
//  Created by YHAN on 2023/03/18.
//

import ProjectDescription
import ProjectEnvironment

let projectName = "Components"
let moduleBaseId = "\(env.bundleId).Components"

let project = Project(
  name: projectName,
  targets: [
    Target(
      name: projectName,
      platform: .iOS,
      product: .framework,
      bundleId: moduleBaseId,
      deploymentTarget: env.deploymentTarget,
      infoPlist: env.infoPlist,
      sources: ["Sources/**"],
      resources: ["../../Resources/**"],
      dependencies: [
        .project(target: "Utils",  path: .relativeToRoot("Share/Utils")),
      ]
    )
  ],
  schemes: [],
  resourceSynthesizers: [.assets()]
)
