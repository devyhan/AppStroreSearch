//
//  Workspace.swift
//  ProjectDescriptionHelpers
//
//  Created by YHAN on 2023/03/18.
//

import ProjectDescription
import ProjectEnvironment

let workspace = Workspace(
  name: env.name,
  projects: ["App/iOS"],
  schemes: [],
  additionalFiles: [
    "README.md"
  ]
)
