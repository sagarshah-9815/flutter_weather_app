import 'package:elegant_notification/elegant_notification.dart';
import 'package:flutter/material.dart';
import '../models/weather_model.dart';

class NotificationService {
  static void showWeatherAlert(BuildContext context, Weather weather) {
    // Temperature alerts
    if (weather.temperature > 30) {
      ElegantNotification.info(
        title: const Text("High Temperature Alert"),
        description: const Text("Temperature is above 30°C. Stay hydrated!"),
        icon: const Icon(Icons.thermostat_outlined, color: Colors.orange),
      ).show(context);
    } else if (weather.temperature < 0) {
      ElegantNotification.info(
        title: const Text("Freezing Temperature Alert"),
        description: const Text("Temperature is below 0°C. Bundle up!"),
        icon: const Icon(Icons.ac_unit, color: Colors.blue),
      ).show(context);
    }

    // Rain alerts
    if (weather.condition.toLowerCase().contains('rain')) {
      ElegantNotification.info(
        title: const Text("Rain Alert"),
        description: const Text("Don't forget your umbrella!"),
        icon: const Icon(Icons.umbrella, color: Colors.blue),
      ).show(context);
    }

    // Strong wind alerts
    if (weather.windSpeed > 30) {
      ElegantNotification.info(
        title: const Text("Strong Wind Alert"),
        description: const Text("Strong winds detected. Be careful outside!"),
        icon: const Icon(Icons.air, color: Colors.grey),
      ).show(context);
    }
  }

  static void showForecastAlert(BuildContext context, List<Forecast> forecast) {
    // Check for upcoming rain
    final tomorrowForecast = forecast.firstWhere(
      (f) => DateTime.parse(f.date).difference(DateTime.now()).inDays == 1,
      orElse: () => forecast.first,
    );

    if (tomorrowForecast.chanceOfRain > 70) {
      ElegantNotification.info(
        title: const Text("Tomorrow's Weather Alert"),
        description:
            const Text("High chance of rain tomorrow. Plan accordingly!"),
        icon: const Icon(Icons.water_drop, color: Colors.blue),
      ).show(context);
    }
  }

  static void showErrorNotification(BuildContext context, String message) {
    ElegantNotification.error(
      title: const Text("Error"),
      description: Text(message),
    ).show(context);
  }
}
