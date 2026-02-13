import SwiftUI

struct ContentView: View {
    @State var weatherData: WeatherData?
    @State var errorMessage: String?

    var body: some View {
        ZStack {
            Image(.cloud)
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
            VStack{
                Text("Den bosch")
                    .font(.system(size: 60.0))
                Text(getTemperatureString() + "°")
                    .font(.custom("Helvetica Neue UltraLight", size: 120))
                if let errorMessage {
                    Text(errorMessage)
                        .foregroundStyle(.red)
                        .padding(.top, 16)
                }
            }
            .task {
                await loadData()
            }
        }
    }

    private func getTemperatureString() -> String {
        if let temp = weatherData?.main.temp {
            let rounded = Int(round(temp))
            return String(rounded)
        } else {
            return "--"
        }
    }

    @MainActor
    private func handle(result: Result<WeatherData, Error>) {
        switch result {
        case .success(let data):
            self.weatherData = data
            self.errorMessage = nil
        case .failure(let error):
            self.errorMessage = error.localizedDescription
        }
    }

    private func buildURL() -> URL? {
        // You can move the API key to a safer place for production apps.
        var components = URLComponents(string: "https://api.openweathermap.org/data/2.5/weather")
        components?.queryItems = [
            URLQueryItem(name: "q", value: "s-Hertogenbosch"),
            URLQueryItem(name: "appid", value: "3b7c0bb2df5778f696d6dfc53b6189c9"),
            URLQueryItem(name: "units", value: "metric")
        ]
        return components?.url
    }

    private func loadData() async {
        guard let url = buildURL() else {
            await MainActor.run {
                self.errorMessage = "Invalid URL"
            }
            return
        }

        do {
            let (data, response) = try await URLSession.shared.data(from: url)
            if let http = response as? HTTPURLResponse, !(200...299).contains(http.statusCode) {
                throw NSError(domain: "HTTPError", code: http.statusCode, userInfo: [NSLocalizedDescriptionKey: "HTTP \(http.statusCode)"])
            }

            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .useDefaultKeys
            let decoded = try decoder.decode(WeatherData.self, from: data)

            await MainActor.run {
                self.weatherData = decoded
                self.errorMessage = nil
            }
        } catch {
            await MainActor.run {
                self.errorMessage = error.localizedDescription
            }
        }
    }
}

#Preview {
    ContentView()
}
