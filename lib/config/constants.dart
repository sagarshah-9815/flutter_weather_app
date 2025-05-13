class AppConstants {
  // API Configuration
  static const String weatherApiBaseUrl = 'http://api.weatherapi.com/v1';
  static const int forecastDays = 3;

  // Widget Configuration
  static const String widgetAppGroupId = 'group.weather_app';
  static const String weatherWidgetName = 'WeatherWidgetProvider';

  // Weather Update Intervals
  static const int weatherUpdateIntervalMinutes = 30;
  static const int widgetUpdateIntervalMinutes = 60;

  // Default Values
  static const String defaultLocation = 'London';
  static const String defaultTemperatureUnit = 'celsius';

  // Storage Keys
  static const String locationKey = 'user_location';
  static const String temperatureUnitKey = 'temperature_unit';
  static const String lastUpdateKey = 'last_update';

  // Error Messages
  static const String locationError = 'Unable to get location';
  static const String weatherError = 'Failed to fetch weather data';
  static const String networkError = 'No internet connection';

  // Animation Durations
  static const int splashScreenDuration = 2;
  static const int weatherAnimationDuration = 500;

  // UI Constants
  static const double cardBorderRadius = 16.0;
  static const double widgetBorderRadius = 12.0;
  static const double defaultPadding = 16.0;
  static const double smallPadding = 8.0;
}
