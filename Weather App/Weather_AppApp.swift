import SwiftUI

struct WeatherResponse: Codable {
    let main: Main
    let weather: [Weather]
    let name: String

    struct Main: Codable {
        let temp: Double
        let humidity: Int
    }

    struct Weather: Codable {
        let description: String
    }
}

struct ContentView: View {
    @State private var city: String = "New York"
    @State private var temperature: String = "--"
    @State private var description: String = "--"
    @State private var humidity: String = "--"

    let apiKey = "YOUR_API_KEY_HERE"

    var body: some View {
        VStack(spacing: 20) {
            TextField("Enter city", text: $city)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

            Button("Get Weather") {
                fetchWeather()
            }

            Text("City: \(city)")
                .font(.title)

            Text("Temperature: \(temperature)°C")
            Text("Condition: \(description)")
            Text("Humidity: \(humidity)%")
        }
        .padding()
    }

    func fetchWeather() {
        let cityEncoded = city.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        let urlString = "https://api.openweathermap.org/data/2.5/weather?q=\(cityEncoded)&appid=\(apiKey)&units=metric"

        guard let url = URL(string: urlString) else { return }

        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else { return }

            if let decoded = try? JSONDecoder().decode(WeatherResponse.self, from: data) {
                DispatchQueue.main.async {
                    temperature = String(format: "%.1f", decoded.main.temp)
                    description = decoded.weather.first?.description.capitalized ?? ""
                    humidity = "\(decoded.main.humidity)"
                }
            }
        }.resume()
    }
}
