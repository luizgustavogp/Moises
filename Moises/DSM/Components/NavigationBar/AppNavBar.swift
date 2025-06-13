//
//  AppNavBar.swift
//  Moises
//
//  Created by Gustavo Guimarães on 10/06/25.
//

import SwiftUI

import SwiftUI

public struct AppNavBar<Content: View>: View {

    @Environment(\.presentationMode) private var presentationMode

    private let content: Content
    private let leadingButton: AppNavBarLeadingButton
    private let trailingButton: AppNavBarTrailingButton
    private let leadingButtonAction: Action?
    private let trailingButtonAction: Action?

    @State private var navigationTitle: String = ""

    public init(
        leadingButton: AppNavBarLeadingButton = .back,
        trailingButton: AppNavBarTrailingButton = .none,
        leadingButtonAction: Action? = nil,
        trailingButtonAction: Action? = nil,
        @ViewBuilder content: () -> Content
    ) {
        self.leadingButton = leadingButton
        self.trailingButton = trailingButton
        self.leadingButtonAction = leadingButtonAction
        self.trailingButtonAction = trailingButtonAction
        self.content = content()
    }

    public var body: some View {
        VStack(spacing: 0) {
            navigationBarView

            content
                .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        .onPreferenceChange(CustomNavBarTitlePreferenceKey.self) { newValue in
            Task { @MainActor in
                navigationTitle = newValue
            }
        }
        .navigationBarHidden(true)
    }

    private var navigationBarView: some View {
        HStack {
            viewForLeadingButton()
            Spacer()
            DSMTitle(text: navigationTitle)
            Spacer()
            viewForTrailingButton()
        }
        .padding(.horizontal, DSMSize.Spacing.md)
        .background(Color.dsmBackground)
    }

    @ViewBuilder
    private func viewForLeadingButton() -> some View {
        switch leadingButton {
        case .none:
            FrameZero()
        case .back:
            Button(action: {
                leadingButtonAction?() ?? presentationMode.wrappedValue.dismiss()
            }) {
                DSMImage(icon: .system(name: "arrow.left"))
            }
        case .custom(let view):
            view
        }
    }

    @ViewBuilder
    private func viewForTrailingButton() -> some View {
        switch trailingButton {
        case .none:
            FrameZero()
        case .custom(let view):
            view
        }
    }
}

public enum AppNavBarLeadingButton {
    case none
    case back
    case custom(view: AnyView)
}

public enum AppNavBarTrailingButton {
    case none
    case custom(view: AnyView)
}

struct CustomNavBarTitlePreferenceKey: PreferenceKey {
    static let defaultValue: String = ""
    static func reduce(value: inout String, nextValue: () -> String) {
        value = nextValue()
    }
}

#Preview {
    AppNavBar(content: {
        Color.red
            .customNavigationTitle("Leading Button only")
    })
    
}

#Preview {
    AppNavBar(
        leadingButton: .none,
        content: {
            Color.yellow
                .customNavigationTitle("Leading Button none")
        }
    )
}

#Preview {
    AppNavBar(
        leadingButton: .custom(
            view: AnyView(
                Button(action: {
                    print("Custom action")
                }) {
                    DSMImage(icon: .system(name: "gear"))
                }
            )
        ),
        content: {
            Color.green
                .customNavigationTitle("Custom leading")
        }
    )
}

#Preview {
    AppNavBar(
        leadingButton: .back,
        trailingButton: .custom(
            view: AnyView(
                Button(action: {
                    print("Custom action")
                }) {
                    DSMImage(icon: .system(name: "gear"))
                }
            )
        ),
        content: {
            Color.green
                .customNavigationTitle("Custom traling")
        }
    )
}

