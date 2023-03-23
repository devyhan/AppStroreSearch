//
//  RoundTextButton.swift
//  Components
//
//  Created by YHAN on 2023/03/21.
//

import SwiftUI

public struct RoundTextButton: View {
  public let title: String
  public let backgroundColor: Color
  public let action: () -> Void

  public init(
    title: String,
    backgroundColor: Color = .clear,
    action: @escaping () -> Void
  ) {
    self.title = title
    self.backgroundColor = backgroundColor
    self.action = action
  }

  public var body: some View {
    Text(title)
      .fontWeight(.semibold)
      .padding(.vertical, 5)
      .padding(.horizontal, 20)
      .background {
        GeometryReader { proxy in
          RoundedRectangle(cornerRadius: proxy.size.height / 2)
            .fill(backgroundColor)
        }
      }
      .onTapGesture(perform: action)
  }
}

struct RoundButton_Previews: PreviewProvider {
  static var previews: some View {
    RoundTextButton(title: "title", action: {})
  }
}
