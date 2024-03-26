import UIKit

final class NetworkManager{

    static let shared = NetworkManager()
    let API_KEY = "API_KEY"
    var lat: Double = 0.0
    var lng: Double = 0.0
    private var weatherURL: String {  return "https://weather.visualcrossing.com/VisualCrossingWebServices/rest/services/timeline/\(lat)%2C\(lng)?unitGroup=metric&key=\(API_KEY)&include=obs%2Cfcst%2Chours%2Ccurrent"
    }

    private var weatherMapURL : String { return
        "https://maps.openweathermap.org/maps/2.0/weather/1h/TA2/{x}/{y}/{z}?appid={API_KEY}"
    }
    
    private init() {}
  
    func getWeather(lat:Double, lng:Double) async throws -> Weather {
        self.lat = lat
        self.lng = lng
        
        guard let url = URL(string: weatherURL) else {
            throw WTError.invalidURL
        }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        
        do {
            let weather =  try JSONDecoder().decode(Weather.self, from: data)
            return weather
        } catch {
            throw WTError.invalidData
        }
    }
    
    func getWeatherMap() async throws -> Data {
        guard let url = URL(string: weatherMapURL) else {
            throw WTError.invalidURL
        }
        
        let (data, _) = try await URLSession.shared.data(from: url)

        return data
    }
    
}

