//
//  InfoPlist.swift
//  ProjectEnvironment
//
//  Created by YHAN on 2023/03/18.
//

import ProjectDescription

extension InfoPlist {
  public static var infoPlist: Self {
    .extendingDefault(
      with: [
        "CFBundleExecutable": "$(EXECUTABLE_NAME)",
        "CFBundleInfoDictionaryVersion": "0.1.0",
        "CFBundlePackageType": "APPL",
        "CFBundleName": "$(PRODUCT_NAME)",
        "CFBundleIdentifier": "$(PRODUCT_BUNDLE_IDENTIFIER)",
        "CFBundleVersion": "1",
        "CFBundleShortVersionString": "0.1.0",
        "UILaunchStoryboardName": "LaunchScreen",
        "UISupportedInterfaceOrientations": "UIInterfaceOrientationPortrait"
      ]
    )
  }
}

