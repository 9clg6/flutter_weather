class Weather {
  final DateTime lastUpdated;
  final double tempC;
  final double tempF;
  final bool isDay;
  final WeatherCondition condition;
  final double windMph;
  final double windKph;
  final double pressureMb;
  final double pressureIn;
  final double precipMm;
  final double precipIn;
  final int humidity;
  final int cloud;
  final double feelslikeC;
  final double feelslikeF;
  final double visKm;
  final double visMiles;
  final double uv;
  final double gustMph;
  final double gustKph;

  Weather({
    required this.lastUpdated,
    required this.tempC,
    required this.tempF,
    required this.isDay,
    required this.condition,
    required this.windMph,
    required this.windKph,
    required this.pressureMb,
    required this.pressureIn,
    required this.precipMm,
    required this.precipIn,
    required this.humidity,
    required this.cloud,
    required this.feelslikeC,
    required this.feelslikeF,
    required this.visKm,
    required this.visMiles,
    required this.uv,
    required this.gustMph,
    required this.gustKph,
  });

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      lastUpdated: DateTime.fromMillisecondsSinceEpoch(
          json['last_updated_epoch'] * 1000),
      tempC: json['temp_c'].toDouble(),
      tempF: json['temp_f'].toDouble(),
      isDay: json['is_day'] == 1,
      condition: WeatherCondition.fromJson(json['condition']),
      windMph: json['wind_mph'].toDouble(),
      windKph: json['wind_kph'].toDouble(),
      pressureMb: json['pressure_mb'].toDouble(),
      pressureIn: json['pressure_in'].toDouble(),
      precipMm: json['precip_mm'].toDouble(),
      precipIn: json['precip_in'].toDouble(),
      humidity: json['humidity'],
      cloud: json['cloud'],
      feelslikeC: json['feelslike_c'].toDouble(),
      feelslikeF: json['feelslike_f'].toDouble(),
      visKm: json['vis_km'].toDouble(),
      visMiles: json['vis_miles'].toDouble(),
      uv: json['uv'].toDouble(),
      gustMph: json['gust_mph'].toDouble(),
      gustKph: json['gust_kph'].toDouble(),
    );
  }
}

class WeatherCondition {
  final String text;
  final String icon;
  final int code;

  WeatherCondition(
      {required this.text, required this.icon, required this.code});

  factory WeatherCondition.fromJson(Map<String, dynamic> json) {
    return WeatherCondition(
      text: json['text'],
      icon: json['icon'],
      code: json['code'],
    );
  }
}
