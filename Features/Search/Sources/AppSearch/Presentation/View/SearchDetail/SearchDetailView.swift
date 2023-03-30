//
//  SearchDetailView.swift
//  Search
//
//  Created by YHAN on 2023/03/20.
//

import SwiftUI
import ComposableArchitecture
import Components

import SearchInterface

public struct SearchDetailView: View {
  let store: StoreOf<SearchDetail>
  private let statelessViewStore: ViewStore<Void, SearchDetail.Action>
  private let actionlessViewStore: ViewStore<SearchDetail.State, Never>

  public init(store: StoreOf<SearchDetail>) {
    self.store = store
    self.statelessViewStore = .init(store.stateless)
    self.actionlessViewStore = .init(store.actionless)
  }

  public var body: some View {
    WithViewStore(store) { viewStore in
      let content = viewStore.result
      ScrollView(showsIndicators: false) {
        VStack(alignment: .leading, spacing: .zero) {
          headerSction(content)
          HorizontalSeparator()
          ratingSection(content)
          HorizontalSeparator()
          newFreatureSection(content, viewStore: viewStore)
          HorizontalSeparator()
          previewSection(content)
          HorizontalSeparator()
          descriptionSection(content, viewStore: viewStore)
        }
        .padding(.bottom, 100)
      }
      .navigationBarBackButtonHidden(true)
      .navigationBarTitle("", displayMode: .inline)
      .navigationBarItems(leading: CustomBackButton(title: "검색"))
    }
  }

  private func headerSction(_ content: Result?) -> some View {
    HStack {
      AsyncImage(url: URL(string: content?.artworkUrl512 ?? "")) { image in
        image.image?.resizable().scaledToFill()
      }
      .frame(width: 114, height: 114)
      .clipShape(RoundedRectangle(cornerRadius: 24))
      .padding(.trailing, 15)

      VStack(alignment: .leading) {
        Text(content?.trackCensoredName ?? "")
          .font(.system(size: 20))
          .fontWeight(.medium)
          .lineLimit(3)

        Text(content?.sellerName ?? "")
          .foregroundColor(Asset.gray8A8A8D.color)
          .font(.system(size: 13))
          .fontWeight(.regular)
          .lineLimit(1)
        Spacer()

        RoundTextButton(
          title: "받기",
          backgroundColor: Asset.blue.color
        ) {

        }
        .foregroundColor(Color.white)
        .font(.system(size: 14, weight: .bold))
        .frame(width: 70, height: 30)
      }
      Spacer()
      VStack {
        Spacer()
        Asset.share.image
      }
    }
    .padding(.bottom, 20)
    .padding(.horizontal, 20)
  }

  private func ratingSection(_ content: Result?) -> some View {
    ScrollView(.horizontal, showsIndicators: false) {
      HStack(spacing: 20) {
        RatingInfoView(content: content)
        VerticalSeparator()
        AgeInfoView(content: content)
        VerticalSeparator()
        CategoryInfoView(content: content)
        VerticalSeparator()
        DeveloperInfoView(content: content)
      }
      .padding(.horizontal, 20)
    }
    .padding(.bottom, 8)
  }

  private func newFreatureSection(
    _ content: Result?,
    viewStore: ViewStoreOf<SearchDetail>
  ) -> some View {
    Group {
      Text("새로운 기능")
        .font(.system(size: 18, weight: .heavy))
        .padding(.leading, 20)
        .padding(.bottom, 4)

      HStack {
        Text("버전 \(content?.version ?? "_")")
          .font(.system(size: 13, weight: .regular))
          .foregroundColor(Asset.gray8A8A8D.color)
          .padding(.leading, 20)

        Spacer()

        Text("\(content?.currentVersionReleaseDate?.convertISO8601?.toRelativeDateString() ?? "")")
          .foregroundColor(Asset.grayB2B2B4.color)
          .font(.system(size: 13, weight: .regular))
          .padding(.trailing, 20)
      }
      .padding(.bottom, 4)

      Text(content?.releaseNotes ?? "")
        .font(.system(size: 13, weight: .regular))
        .foregroundColor(Asset.gray8A8A8D.color)
        .lineSpacing(5)
        .lineLimit(viewStore.isNewFeatureExpeneded ? nil : 3)
        .overlay(
          GeometryReader { proxy in
            let size = proxy.size
            if size.height > 45, !viewStore.isNewFeatureExpeneded {
              VStack {
                Spacer()
                MoreButton(
                  text: viewStore.isNewFeatureExpeneded ? "" : "더보기",
                  action: {
                    viewStore.send(.showMoreUpdates)
                  }
                )
              }
            }
          }
        )
        .padding(.horizontal, 20)
    }
    .padding(.bottom, 8)
  }

  private func previewSection(_ content: Result?) -> some View {
    VStack(alignment: .leading, spacing: 8) {
      Text("미리보기")
        .font(.system(size: 18, weight: .heavy))
        .padding(.leading, 20)
        .padding(.bottom, 4)


      let width = UIScreen.main.bounds.width / 1.7
      ScrollView(.horizontal, showsIndicators: false) {
        HStack(spacing: 8) {
          ForEach(content?.screenshotUrls ?? [], id: \.self) { url in
            AsyncImage(url: URL(string: url)) { image in
              image.image?.resizable().scaledToFill()
            }
            .frame(width: width, height: 445)
            .clipShape(RoundedRectangle(cornerRadius: 22))
          }
        }
        .padding(.horizontal, 20)
      }
    }
    .padding(.bottom, 8)
  }

  private func descriptionSection(
    _ content: Result?,
    viewStore: ViewStoreOf<SearchDetail>
  ) -> some View {
    VStack(alignment: .leading, spacing: 8) {
      Text("설명")
        .font(.system(size: 18, weight: .heavy))
        .padding(.leading, 20)
        .padding(.bottom, 4)

      Text(content?.description ?? "")
        .font(.system(size: 13, weight: .regular))
        .foregroundColor(Asset.gray8A8A8D.color)
        .lineSpacing(5)
        .lineLimit(viewStore.isDescriptionExpended ? nil : 3)
        .overlay(
          GeometryReader { proxy in
            let size = proxy.size
            if size.height > 45, !viewStore.isDescriptionExpended {
              VStack {
                Spacer()
                MoreButton(
                  text: viewStore.isDescriptionExpended ? "" : "더보기",
                  action: {
                    viewStore.send(.showMoreDescription)
                  }
                )
              }
            }
          }
        )
        .padding(.horizontal, 20)
    }
    .padding(.bottom, 8)
  }
}

struct RatingInfoView: View {
  let content: Result?

  var body: some View {
    VStack(spacing: 5) {
      let rating = content?.averageUserRatingForCurrentVersion ?? 0
      Text("\(content?.userRatingCount?.toAbbreviation() ?? "_")개의 평가")
        .foregroundColor(Asset.grayB2B2B4.color)
        .font(.system(size: 11, weight: .semibold))

      Text("\(Int(rating))")
        .foregroundColor(Asset.grayB2B2B4.color)
        .font(.system(size: 20, weight: .semibold))

      RatingView(
        rating: Decimal(rating),
        color: Asset.grayB2B2B4.color,
        backgroundColor: Asset.grayB2B2B4.color,
        spacing: 2
      )
      .frame(width: 70, height: 10)
    }
  }
}

struct AgeInfoView: View {
  let content: Result?

  var body: some View {
    VStack(spacing: 5) {
      Text("연령")
        .foregroundColor(Asset.grayB2B2B4.color)
        .font(.system(size: 11, weight: .semibold))

      Text("\(content?.contentAdvisoryRating ?? "_")")
        .foregroundColor(Asset.grayB2B2B4.color)
        .font(.system(size: 20, weight: .semibold))

      Text("세")
        .foregroundColor(Asset.grayB2B2B4.color)
        .font(.system(size: 13, weight: .medium))
    }
    .frame(width: 60)
  }
}

struct CategoryInfoView: View {
  let content: Result?

  var body: some View {
    VStack(spacing: 3) {
      Text("카테고리")
        .foregroundColor(Asset.grayB2B2B4.color)
        .font(.system(size: 11, weight: .semibold))

      Asset.category.image

      Text("\(content?.primaryGenreName ?? "_")")
        .foregroundColor(Asset.grayB2B2B4.color)
        .font(.system(size: 13, weight: .medium))
        .minimumScaleFactor(0.1)
        .frame(height: 22)
    }
    .frame(width: 60)
  }
}

struct DeveloperInfoView: View {
  let content: Result?

  var body: some View {
    VStack(spacing: 5) {
      Text("개발자")
        .foregroundColor(Asset.grayB2B2B4.color)
        .font(.system(size: 11, weight: .semibold))

      Asset.developer.image

      Text("\(content?.sellerName ?? "_")")
        .foregroundColor(Asset.grayB2B2B4.color)
        .font(.system(size: 13, weight: .medium))
        .minimumScaleFactor(0.1)
        .frame(height: 22)
    }
    .frame(width: 60)
  }
}

struct MoreButton: View {
  let text: String
  var action: () -> Void

  var body: some View {
    Text(text)
      .foregroundColor(Asset.blue.color)
      .padding(.leading, 20)
      .font(.system(size: 11, weight: .semibold))
      .shadow(color: Asset.background.color, radius: 10)
      .background(
        RadialGradient(
          gradient: Gradient(colors: [Asset.background.color, .clear]),
          center: .center,
          startRadius: 0,
          endRadius: 40
        )
      )
      .offset(x: UIScreen.main.bounds.width - 90)
      .onTapGesture(perform: action)
  }
}
