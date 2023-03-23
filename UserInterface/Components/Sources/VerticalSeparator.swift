//
//  VerticalSeparator.swift
//  Components
//
//  Created by YHAN on 2023/03/22.
//

import SwiftUI

public struct VerticalSeparator: View {

  public init() {}

  public var body: some View {
    Rectangle()
      .fill(Asset.grayB2B2B4.color)
      .frame(width: 1, height: 40)
  }
}
