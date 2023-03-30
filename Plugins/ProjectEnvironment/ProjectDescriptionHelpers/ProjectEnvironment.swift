import Foundation
import ProjectDescription

public let env = ProjectEnvironment(
  name: "AppStore",
  settings: .settings,
  orgenizationName: "Apple",
  bundleId: "com.appstore",
  targetVersion: "16.0",
  deploymentTarget: .iOS(targetVersion: "16.0", devices: [.iphone, .ipad]),
  infoPlist: .infoPlist,
  infoPlistUIKit: .infoPlistUIKit,
  spmPackages: .packages
)

public struct ProjectEnvironment {
  public let name: String
  public let settings: Settings
  public let orgenizationName: String
  public let bundleId: String
  public let targetVersion: String
  public let deploymentTarget: DeploymentTarget
  public let infoPlist: InfoPlist
  public let infoPlistUIKit: InfoPlist
  public let spmPackages: SwiftPackageManagerDependencies

  public init(
    name: String,
    settings: Settings,
    orgenizationName: String,
    bundleId: String,
    targetVersion: String,
    deploymentTarget: DeploymentTarget,
    infoPlist: InfoPlist,
    infoPlistUIKit: InfoPlist,
    spmPackages: SwiftPackageManagerDependencies
  ) {
    self.name = name
    self.settings = settings
    self.orgenizationName = orgenizationName
    self.bundleId = bundleId
    self.targetVersion = targetVersion
    self.deploymentTarget = deploymentTarget
    self.infoPlist = infoPlist
    self.infoPlistUIKit = infoPlistUIKit
    self.spmPackages = spmPackages
  }
}
