//
//  ThirdPartyLibraries.swift
//  ProjectEnvironment
//
//  Created by YHAN on 2023/03/18.
//

import ProjectDescription

extension SwiftPackageManagerDependencies {
  public static var packages: Self {
    [
      .ComposableArchitecture,
      .TCACoordinators,
      .URLRouter,
      .RIBs,
      .RxSwift
    ]
  }
}

extension Package {
  static let ComposableArchitecture = Package.remote(
      url: "https://github.com/pointfreeco/swift-composable-architecture.git",
      requirement: .exact("0.52.0")
  )

  static let TCACoordinators = Package.remote(
      url: "https://github.com/johnpatrickmorgan/TCACoordinators.git",
      requirement: .exact("0.4.0")
  )

  static let URLRouter = Package.remote(
    url: "https://github.com/devyhan/URLRouter.git",
    requirement: .exact("0.1.5")
  )
  
  static let RIBs = Package.remote(url: "https://github.com/uber/RIBs.git", requirement: .exact("0.13.3"))
  
  static let RxSwift = Package.remote(url: "https://github.com/ReactiveX/RxSwift.git", requirement: .exact("6.5.0"))
}


extension TargetDependency {
  public struct SPM {
    public static let ComposableArchitecture = TargetDependency.external(name: "ComposableArchitecture")
    public static let TCACoordinators = TargetDependency.external(name: "TCACoordinators")
    public static let URLRouter = TargetDependency.external(name: "URLRouter")
    public static let RIBs = TargetDependency.external(name: "RIBs")
    public static let RxSwift = TargetDependency.external(name: "RxSwift")
    public static let RxCocoa = TargetDependency.external(name: "RxCocoa")
  }
}
