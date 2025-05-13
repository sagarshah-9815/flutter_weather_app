# Weather App

A beautiful Flutter weather app with home screen widgets and notifications.

## Features

- Real-time weather data from WeatherAPI.com
- Beautiful weather animations
- Home screen widgets (Android)
- Weather notifications and alerts
- 3-day weather forecast
- Minimal and gorgeous design
- Dark mode support

## Setup

1. Clone the repository
2. Create a `.env` file in the root directory with your WeatherAPI.com API key:
   ```
   WEATHER_API_KEY=your_api_key_here
   ```
3. Run `flutter pub get` to install dependencies
4. Run `flutter run` to start the app

## Dependencies

- weather_animation: ^1.1.2
- flex_color_scheme: ^8.2.0
- redacted: ^1.0.13
- flutter_native_splash: ^2.4.6
- home_widget: ^0.7.0+1
- elegant_notification: ^2.5.1
- http: ^1.1.0
- geolocator: ^10.0.0
- shared_preferences: ^2.2.0
- intl: ^0.18.1
- flutter_dotenv: ^5.1.0

## Home Screen Widget

The app includes a home screen widget for Android that displays:
- Current temperature
- Weather condition
- Location
- Last update time

The widget updates automatically every 30 minutes.

## Weather Notifications

The app provides notifications for:
- Extreme temperatures
- Rain alerts
- Strong wind warnings
- Tomorrow's weather forecast

## Project Structure

```
lib/
├── main.dart
├── config/
│   ├── theme.dart
│   └── constants.dart
├── models/
│   └── weather_model.dart
├── services/
│   ├── weather_service.dart
│   ├── location_service.dart
│   └── notification_service.dart
├── widgets/
│   ├── weather_card.dart
│   ├── forecast_card.dart
│   └── home_widget.dart
└── screens/
    └── home_screen.dart
```

<img src="https://github.com/user-attachments/assets/ae6573ca-8911-43fa-b070-32fa27701d82" alt="Screenshot_20250513-181036" width="300">
<img src="https://github.com/user-attachments/assets/1d89a5dd-6927-49bd-ab36-91b2fb48a722" alt="Screenshot_20250513-181334" width="300">
<img src="https://github.com/user-attachments/assets/18163035-a358-460d-b6ab-4e136ea38664" alt="Screenshot_20250513-181010" width="300">
<img src="https://github.com/user-attachments/assets/ab3fed78-2717-40b2-b485-097a3e6d8de0" alt="1747148589430" width="300">


## Getting Started

1. Get an API key from [WeatherAPI.com](https://www.weatherapi.com/)
2. Add your API key to the `.env` file
3. Run the app using `flutter run`

## Contributing

Feel free to submit issues and enhancement requests.

## License

This project is licensed under the MIT License - see the LICENSE file for details.
