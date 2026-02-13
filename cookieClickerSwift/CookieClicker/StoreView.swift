import SwiftUI

struct StoreView: View {
    @Binding var totalCookies: Int
    @Binding var clickValue: Int
    @Binding var upgradeCost: Int

    var body: some View {
        NavigationView {
            VStack(spacing: 24) {
                Text("Store")
                    .font(.largeTitle)
                    .fontWeight(.bold)

                VStack(spacing: 8) {
                    Text("You have \(totalCookies) cookies")
                        .font(.title3)
                    Text("Current click: +\(clickValue) per tap")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                }
	
                // Upgrade clicker: +1 per click, cost scales
                Button {
                    guard totalCookies >= upgradeCost else { return }
                    totalCookies -= upgradeCost
                    clickValue += 1

                    // Scale the next upgrade cost.
                    // 1.5x rounded up, ensuring it always increases by at least 1.
                    let scaled = Int(ceil(Double(upgradeCost) * 1.5))
                    upgradeCost = max(upgradeCost + 1, scaled)
                } label: {
                    Text("Upgrade click (+1 per tap) — Cost: \(upgradeCost)")
                }
                .buttonStyle(.borderedProminent)
                .disabled(totalCookies < upgradeCost)

                Spacer()
            }
            .padding()
            .navigationTitle("Store")
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

#Preview {
    StoreView(
        totalCookies: .constant(42),
        clickValue: .constant(1),
        upgradeCost: .constant(10)
    )
}
