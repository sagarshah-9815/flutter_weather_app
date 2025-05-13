import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'config/theme.dart';
import 'config/constants.dart';
import 'screens/home_screen.dart';
import 'widgets/home_widget.dart';

void main() async {
  final widgetsBinding = WidgetsFlutterBinding.ensureInitialized();

  // Keep splash screen up while we initialize
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  // Initialize services
  await Future.wait([
    HomeWidgetProvider.setupWidget(),
    SharedPreferences.getInstance(),
  ]);

  // Remove splash screen
  FlutterNativeSplash.remove();

  runApp(const WeatherApp());
}

class WeatherApp extends StatelessWidget {
  const WeatherApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather App',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      home: const HomeScreen(),
    );
  }
}
