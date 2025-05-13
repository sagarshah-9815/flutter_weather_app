import 'package:flutter/material.dart';
import '../widgets/home_widget.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_animation/weather_animation.dart';
import 'package:elegant_notification/elegant_notification.dart';
import '../models/weather_model.dart';
import '../services/weather_service.dart';
import '../widgets/weather_card.dart';
import '../widgets/forecast_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final WeatherService _weatherService = WeatherService();
  Weather? _currentWeather;
  List<Forecast> _forecast = [];
  bool _isLoading = true;
  String _location = 'Kathmandu'; // Default location
  List<String> _savedLocations = [];
  final TextEditingController _locationController = TextEditingController();

  Future<void> _getCurrentLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      if (mounted) {
        ElegantNotification.info(
          title: Text("Location Service"),
          description: Text("Please enable location services"),
        ).show(context);
      }
      return;
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        if (mounted) {
          ElegantNotification.info(
            title: Text("Permission Required"),
            description: Text("Location permissions are denied"),
          ).show(context);
        }
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      if (mounted) {
        ElegantNotification.info(
          title: Text("Permission Required"),
          description: Text("Location permissions are permanently denied"),
        ).show(context);
      }
      return;
    }

    setState(() => _isLoading = true);
    try {
      Position position = await Geolocator.getCurrentPosition();
      _location = '${position.latitude},${position.longitude}';
      await _fetchWeatherData();
      await _saveLocation(_location);
    } catch (e) {
      if (mounted) {
        ElegantNotification.error(
          title: Text("Error"),
          description: Text("Failed to get current location"),
        ).show(context);
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  Future<void> _saveLocation(String location) async {
    if (!_savedLocations.contains(location)) {
      setState(() => _savedLocations.add(location));
      final prefs = await SharedPreferences.getInstance();
      await prefs.setStringList('savedLocations', _savedLocations);
    }
  }

  Future<void> _loadSavedLocations() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _savedLocations = prefs.getStringList('savedLocations') ?? [];
    });
  }

  void _addNewLocation() {
    if (_locationController.text.isNotEmpty) {
      setState(() {
        _location = _locationController.text;
        _locationController.clear();
      });
      _fetchWeatherData();
      _saveLocation(_location);
    }
  }

  @override
  void initState() {
    super.initState();
    _loadSavedLocations().then((_) {
      HomeWidgetProvider.setupWidget(location: _location);
    });
    _fetchWeatherData();
  }

  Future<void> _fetchWeatherData() async {
    try {
      setState(() => _isLoading = true);

      final currentWeatherData =
          await _weatherService.getCurrentWeather(_location);
      final forecastData = await _weatherService.getForecast(_location);

      _currentWeather = Weather.fromJson(currentWeatherData);
      _forecast = (forecastData['forecast']['forecastday'] as List)
          .map((day) => Forecast.fromJson(day))
          .toList();
      setState(() => _isLoading = false);

      // Update home widget with new weather data
      await HomeWidgetProvider.updateWidget(location: _location);

      // Show notification for significant weather changes
      _showWeatherNotification();
    } catch (e) {
      setState(() => _isLoading = false);
      if (mounted) {
        ElegantNotification.error(
          title: Text("Error"),
          description: Text("Failed to fetch weather data"),
        ).show(context);
      }
    }
  }

  void _showWeatherNotification() {
    if (_currentWeather != null) {
      if (_currentWeather!.temperature > 30) {
        ElegantNotification.info(
          title: Text("High Temperature Alert"),
          description: Text("Temperature is above 30°C. Stay hydrated!"),
        ).show(context);
      }
    }
  }

  Widget _getWeatherAnimation() {
    if (_currentWeather == null) return const SizedBox();

    final condition = _currentWeather!.condition.toLowerCase();
    if (condition.contains('rain')) {
      return const RainWidget();
    } else if (condition.contains('snow')) {
      return const SnowWidget();
    } else if (condition.contains('cloud')) {
      return const CloudWidget();
    }
    return const SunWidget();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Stack(
              children: [
                _getWeatherAnimation(),
                RefreshIndicator(
                  onRefresh: _fetchWeatherData,
                  child: CustomScrollView(
                    slivers: [
                      SliverAppBar(
                        expandedHeight: 80,
                        floating: true,
                        pinned: true,
                        title: Text(_currentWeather?.location ?? ''),
                        actions: [
                          IconButton(
                            icon: const Icon(Icons.my_location),
                            onPressed: _getCurrentLocation,
                          ),
                        ],
                      ),
                      SliverToBoxAdapter(
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: TextField(
                                      controller: _locationController,
                                      decoration: InputDecoration(
                                        hintText: 'Enter location',
                                        suffixIcon: IconButton(
                                          icon: const Icon(Icons.search),
                                          onPressed: _addNewLocation,
                                        ),
                                      ),
                                      onSubmitted: (_) => _addNewLocation(),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 20),
                              if (_currentWeather != null)
                                WeatherCard(weather: _currentWeather!),
                              const SizedBox(height: 20),
                              const Text(
                                'Forecast',
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 10),
                              SizedBox(
                                height: 180,
                                child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: _forecast.length,
                                  itemBuilder: (context, index) {
                                    return Padding(
                                      padding:
                                          const EdgeInsets.only(right: 8.0),
                                      child: ForecastCard(
                                        forecast: _forecast[index],
                                      ),
                                    );
                                  },
                                ),
                              ),
                              const SizedBox(height: 20),
                              if (_savedLocations.isNotEmpty)
                                const Text(
                                  'Saved Locations',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ..._savedLocations.map((location) => ListTile(
                                    title: Text(location),
                                    trailing: IconButton(
                                      icon: const Icon(Icons.delete),
                                      onPressed: () async {
                                        setState(() {
                                          _savedLocations.remove(location);
                                        });
                                        final prefs = await SharedPreferences
                                            .getInstance();
                                        await prefs.setStringList(
                                            'savedLocations', _savedLocations);
                                      },
                                    ),
                                    onTap: () {
                                      setState(() => _location = location);
                                      _fetchWeatherData();
                                    },
                                  )),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}
