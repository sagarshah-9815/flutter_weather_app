class Weather {
  final double temperature;
  final double feelsLike;
  final double windSpeed;
  final int humidity;
  final String condition;
  final String conditionIcon;
  final String location;
  final String country;
  final String localTime;

  Weather({
    required this.temperature,
    required this.feelsLike,
    required this.windSpeed,
    required this.humidity,
    required this.condition,
    required this.conditionIcon,
    required this.location,
    required this.country,
    required this.localTime,
  });

  factory Weather.fromJson(Map<String, dynamic> json) {
    final current = json['current'];
    final location = json['location'];

    return Weather(
      temperature: current['temp_c'].toDouble(),
      feelsLike: current['feelslike_c'].toDouble(),
      windSpeed: current['wind_kph'].toDouble(),
      humidity: current['humidity'],
      condition: current['condition']['text'],
      conditionIcon: 'https:${current['condition']['icon']}',
      location: location['name'],
      country: location['country'],
      localTime: location['localtime'],
    );
  }
}

class Forecast {
  final String date;
  final double maxTemp;
  final double minTemp;
  final String condition;
  final String conditionIcon;
  final double chanceOfRain;

  Forecast({
    required this.date,
    required this.maxTemp,
    required this.minTemp,
    required this.condition,
    required this.conditionIcon,
    required this.chanceOfRain,
  });

  factory Forecast.fromJson(Map<String, dynamic> json) {
    final day = json['day'];

    return Forecast(
      date: json['date'],
      maxTemp: day['maxtemp_c'].toDouble(),
      minTemp: day['mintemp_c'].toDouble(),
      condition: day['condition']['text'],
      conditionIcon: 'https:${day['condition']['icon']}',
      chanceOfRain: day['daily_chance_of_rain'].toDouble(),
    );
  }
}
