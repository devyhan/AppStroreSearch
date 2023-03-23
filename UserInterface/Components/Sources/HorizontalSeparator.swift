//
//  HorizontalSeparator.swift
//  Components
//
//  Created by YHAN on 2023/03/22.
//

import SwiftUI

public struct HorizontalSeparator: View {

  public init() {}

  public var body: some View {
    Rectangle()
      .fill(Asset.grayB2B2B4.color)
      .frame(height: 1)
      .opacity(0.3)
      .padding(.bottom, 8)
      .padding(.horizontal, 20)
  }
}
