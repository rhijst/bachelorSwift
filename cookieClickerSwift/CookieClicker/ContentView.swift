import SwiftUI

struct ContentView: View {
    @State private var count: Int = 0

    var body: some View {
        ZStack {
            // App-wide background
            Color.gray
                .ignoresSafeArea()

            VStack(spacing: 24) {
                // Counter display
                Text("Cookies: \(count)")
                    .font(.largeTitle)
                    .fontWeight(.bold)

                // Cookie button
                Button {
                    count += 1
                    print("Cookie tapped. Count = \(count)")
                } label: {
                    Image("perfectCookie")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 220, height: 220)
                        .shadow(radius: 8)
                        .accessibilityLabel("Cookie")
                }

                // Optional extra button
                Button("More cookies") {
                    count += 1
                }
                .padding(20)
                .buttonStyle(.borderedProminent)
            }
            .padding()
        }
    }
}

#Preview {
    ContentView()
}

// shift apple L
// alt apple enter
