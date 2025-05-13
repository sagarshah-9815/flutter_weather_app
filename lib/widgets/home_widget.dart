import 'package:flutter/material.dart';
import 'package:home_widget/home_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../services/weather_service.dart';
import '../models/weather_model.dart';

class HomeWidgetProvider {
  static const String appGroupId = 'group.weather_app';
  static const String weatherKey = 'weather_data';

  static Future<void> updateWidget({String? location}) async {
    try {
      final weatherService = WeatherService();
      final weatherData =
          await weatherService.getCurrentWeather(location ?? 'London');
      final weather = Weather.fromJson(weatherData);

      // Send data to widget
      // Save to shared preferences for Android widget
      await HomeWidget.saveWidgetData<String>(
          'temperature', '${weather.temperature.round()}°C');
      await HomeWidget.saveWidgetData<String>('condition', weather.condition);
      await HomeWidget.saveWidgetData<String>('location', weather.location);

      // Also save to regular shared preferences as fallback
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('temperature', '${weather.temperature.round()}°C');
      await prefs.setString('condition', weather.condition);
      await prefs.setString('location', weather.location);
      await HomeWidget.saveWidgetData<String>(
          'updated', DateTime.now().toString());

      // Update widget UI
      await HomeWidget.updateWidget(
        name: 'WeatherWidgetProvider',
        androidName: 'WeatherWidgetProvider',
        iOSName: 'WeatherWidget',
      );
    } catch (e) {
      debugPrint('Error updating widget: $e');
    }
  }

  static Future<void> setupWidget({String? location}) async {
    await HomeWidget.setAppGroupId(appGroupId);
    // Register for widget updates
    HomeWidget.registerBackgroundCallback(backgroundCallback);
    // Initial update
    await updateWidget(location: location);
  }

  // Background callback for widget updates
  static Future<void> backgroundCallback(Uri? uri) async {
    if (uri?.host == 'updateweather') {
      final location = uri?.queryParameters['location'];
      await updateWidget(location: location);
    }
  }
}
