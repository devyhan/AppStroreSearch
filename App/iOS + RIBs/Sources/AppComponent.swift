//
//  AppComponent.swift
//  iOS (UIKit, RIBs)
//
//  Created by 조요한 on 2023/03/30.
//

import RIBs

class AppComponent: Component<EmptyDependency>, RootDependency {
  
  init() {
    super.init(dependency: EmptyComponent())
  }
}
