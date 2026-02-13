import Foundation

struct WeatherData: Codable {
    var main: WeatherMain
    var name: String
    var id: Int
    var coord: WeatherCoord
    var weather: [WeatherWeather]
    var clouds: WeatherClouds
    // swiftlint:disable identifier_name
    var dt: Int
    var base: String
    var sys: WeatherSys
    var cod: Int
    var visibility: Int
    var wind: WeatherWind
    // Optional fields that may be present
    var timezone: Int?
}

struct WeatherCoord: Codable {
    var lat: Double
    var lon: Double
}

struct WeatherSys: Codable {
    var country: String
    var id: Int
//    var message: Double // Since < 2021-03-21 unavailable
    var sunrise: Int
    var sunset: Int
    var type: Int
}

struct WeatherWeather: Codable {
    var description: String
    var icon: String
    var id: Int
    var main: String
}

struct WeatherClouds: Codable {
    var all: Int
}

struct WeatherMain: Codable {
    var humidity: Int
    var pressure: Int
    var temp: Double
    // swiftlint:disable identifier_name
    var temp_max: Double
    var temp_min: Double
    // Optional fields that sometimes appear
    var feels_like: Double?
    var sea_level: Int?
    var grnd_level: Int?
}

struct WeatherWind: Codable {
    var deg: Int
    var speed: Double
    // Optional gust may appear
    var gust: Double?
}

// Voorbeeld response:

/*
 ["main": {
 humidity = 50;
 pressure = 1029;
 temp = "270.58";
 "temp_max" = "271.15";
 "temp_min" = "269.15";
 },
 
 "name": s-Hertogenbosch,
 
 "id": 2747351,
 
 "coord": {
 lat = "51.7";
 lon = "5.3";
 },
 
 "weather": <__NSSingleObjectArrayI 0x600000018200>(
 {
 description = "scattered clouds";
 icon = 03n;
 id = 802;
 main = Clouds;
 }
 ),
 
 
 "clouds": {
 all = 40;
 },
 
 "dt": 1519588500,
 
 "base": stations,
 
 "sys": {
 country = NL;
 id = 5208;
 message = "0.0027";  BAD tegenwoordig
 sunrise = 1519540277;
 sunset = 1519578780;
 type = 1;
 },
 
 "cod": 200,
 
 "visibility": 10000,
 
 "wind": {
 deg = 70;
 speed = "6.7";
 }]
 */
