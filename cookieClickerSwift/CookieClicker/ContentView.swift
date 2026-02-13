import SwiftUI
// swiftlint:disable vertical_whitespace

struct ContentView: View {
    @State private var cookies: Int = 0
    @State private var isShowingSheet: Bool = false

    // New game state
    @State private var clickValue: Int = 1
    @State private var upgradeCost: Int = 10

    var body: some View {
        NavigationView {
            ZStack {
                // App-wide background
                Color.gray
                    .ignoresSafeArea()

                VStack(spacing: 24) {
                    // Counter display
                    Text("You have \(cookies) cookies")
                        .font(.title)
                        .fontWeight(.semibold)

                    Text("Current click: +\(clickValue) per tap")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)

                    // Cookie button
                    Button {
                        cookies += clickValue
                        print("Cookie tapped. Count = \(cookies)")
                    } label: {
                        Image("perfectCookie")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 220, height: 220)
                            .shadow(radius: 8)
                            .accessibilityLabel("Cookie")
                    }

                    // Navigation to Credits
                    NavigationLink(destination: CreditsView()) {
                        Text("Credits")
                    }
                    .buttonStyle(.glass)

                    // Open Store as a sheet
                    Button("Open Store") {
                        isShowingSheet = true
                    }
                    .buttonStyle(.glass)

                }
                .padding()
            }
            .sheet(isPresented: $isShowingSheet) {
                StoreView(
                    totalCookies: $cookies,
                    clickValue: $clickValue,
                    upgradeCost: $upgradeCost
                )
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

#Preview {
    ContentView()
}

// shift apple L
// alt apple enter
