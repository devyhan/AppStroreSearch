//
//  CustomBackButton.swift
//  Components
//
//  Created by YHAN on 2023/03/21.
//

import SwiftUI

public struct CustomBackButton: View {
  @Environment(\.presentationMode) private var presentationMode
  public let title: String

  public init(title: String) {
    self.title = title
  }

  public var body: some View {
    Button(action: {
      presentationMode.wrappedValue.dismiss()
    }, label: {
      HStack(spacing: 5) {
        Image(systemName: "chevron.backward")
        Text(title)
      }
    })
  }
}
