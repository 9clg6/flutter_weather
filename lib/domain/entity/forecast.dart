class Forecast {
  final String date;
  final int dateEpoch;
  final Day day;
  final Astro astro;
  final List<Hour> hour;

  Forecast({
    required this.date,
    required this.dateEpoch,
    required this.day,
    required this.astro,
    required this.hour,
  });

  factory Forecast.fromJson(Map<String, dynamic> json) {
    var hourListFromJson = json['hour'] as List;
    List<Hour> hourList =
        hourListFromJson.map((i) => Hour.fromJson(i)).toList();

    return Forecast(
      date: json['date'],
      dateEpoch: json['date_epoch'],
      day: Day.fromJson(json['day']),
      astro: Astro.fromJson(json['astro']),
      hour: hourList,
    );
  }
}

class Day {
  final double maxTempC;
  final double minTempC;
  final double avgTempC;
  final Condition condition;

  Day({
    required this.maxTempC,
    required this.minTempC,
    required this.avgTempC,
    required this.condition,
  });

  factory Day.fromJson(Map<String, dynamic> json) {
    return Day(
      maxTempC: json['maxtemp_c'],
      minTempC: json['mintemp_c'],
      avgTempC: json['avgtemp_c'],
      condition: Condition.fromJson(json['condition']),
    );
  }
}

class Condition {
  final String text;
  final String icon;
  final int code;

  Condition({required this.text, required this.icon, required this.code});

  factory Condition.fromJson(Map<String, dynamic> json) {
    return Condition(
      text: json['text'],
      icon: json['icon'],
      code: json['code'],
    );
  }
}

class Astro {
  final String sunrise;
  final String sunset;
  final String moonrise;
  final String moonset;

  Astro({
    required this.sunrise,
    required this.sunset,
    required this.moonrise,
    required this.moonset,
  });

  factory Astro.fromJson(Map<String, dynamic> json) {
    return Astro(
      sunrise: json['sunrise'],
      sunset: json['sunset'],
      moonrise: json['moonrise'],
      moonset: json['moonset'],
    );
  }
}

class Hour {
  final int timeEpoch;
  final String time;
  final double tempC;
  final Condition condition;

  Hour({
    required this.timeEpoch,
    required this.time,
    required this.tempC,
    required this.condition,
  });

  factory Hour.fromJson(Map<String, dynamic> json) {
    return Hour(
      timeEpoch: json['time_epoch'],
      time: json['time'],
      tempC: json['temp_c'],
      condition: Condition.fromJson(json['condition']),
    );
  }
}
