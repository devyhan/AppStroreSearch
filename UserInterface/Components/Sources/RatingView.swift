//
//  RatingView.swift
//  Components
//
//  Created by YHAN on 2023/03/21.
//

import SwiftUI

public struct RatingView: View {
  var rating: Decimal
  var color: Color
  var backgroundColor: Color
  var spacing: CGFloat

  public init(
    rating: Decimal,
    color: Color = .red,
    backgroundColor: Color = .gray,
    spacing: CGFloat = .zero
  ) {
    self.rating = rating
    self.color = color
    self.backgroundColor = backgroundColor
    self.spacing = spacing
  }

  public var body: some View {
    ZStack {
      BackgroundStars(backgroundColor, spacing: spacing)
      ForegroundStars(rating: rating, color: color, spacing: spacing)
    }
  }
}

struct RatingStar: View {
  var rating: CGFloat
  var color: Color
  var index: Int

  var maskRatio: CGFloat {
    let mask = rating - CGFloat(index)
    switch mask {
    case 1...: return 1
    case ..<0: return 0
    default: return mask
    }
  }

  init(rating: Decimal, color: Color, index: Int) {
    self.rating = CGFloat(Double(rating.description) ?? 0)
    self.color = color
    self.index = index
  }

  var body: some View {
    GeometryReader { star in
      StarFillImage()
        .foregroundColor(self.color)
        .mask(
          Rectangle()
            .size(
              width: star.size.width * self.maskRatio,
              height: star.size.height
            )
        )
    }
  }
}

private struct StarFillImage: View {
  var body: some View {
    Image(systemName: "star.fill")
      .resizable()
      .aspectRatio(contentMode: .fill)
  }
}

private struct StarImage: View {
  var body: some View {
    Image(systemName: "star")
      .resizable()
      .aspectRatio(contentMode: .fill)
  }
}

private struct BackgroundStars: View {
  var color: Color
  var spacing: CGFloat

  init(_ color: Color, spacing: CGFloat) {
    self.color = color
    self.spacing = spacing
  }

  var body: some View {
    HStack(spacing: spacing) {
      ForEach(0..<5) { _ in
        StarImage()
      }
    }.foregroundColor(color)
  }
}

private struct ForegroundStars: View {
  var rating: Decimal
  var color: Color
  var spacing: CGFloat

  init(rating: Decimal, color: Color, spacing: CGFloat) {
    self.rating = rating
    self.color = color
    self.spacing = spacing
  }

  var body: some View {
    HStack(spacing: spacing) {
      ForEach(0..<5) { index in
        RatingStar(
          rating: self.rating,
          color: self.color,
          index: index
        )
      }
    }
  }
}

struct RatingView_Previews: PreviewProvider {
  static var previews: some View {
    VStack {
      RatingView(rating: 4.8)
        .previewLayout(.sizeThatFits)
    }
  }
}
