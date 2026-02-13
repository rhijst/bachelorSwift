import SwiftUI

struct CreditsView: View {
    var body: some View {
        VStack(spacing: 16) {
            Text("Credits")
                .font(.largeTitle)
                .fontWeight(.bold)

            Text("Made by Thijs")
                .font(.title3)
        }
        .padding()
        .navigationTitle("Credits")
    }
}


#Preview {
    NavigationView {
        CreditsView()
    }
}
