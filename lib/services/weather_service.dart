import 'dart:convert';
import 'package:http/http.dart' as http;
import '../constants/api_constants.dart';

class WeatherService {
  final String apiKey = weatherApiKey;

  Future<Map<String, dynamic>> getCurrentWeather(String location) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/current.json?key=$apiKey&q=$location&aqi=yes'),
      );

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception('Failed to load weather data');
      }
    } catch (e) {
      throw Exception('Error fetching weather data: $e');
    }
  }

  Future<Map<String, dynamic>> getForecast(String location,
      {int days = 3}) async {
    try {
      final response = await http.get(
        Uri.parse(
            '$baseUrl/forecast.json?key=$apiKey&q=$location&days=$days&aqi=yes'),
      );

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception('Failed to load forecast data');
      }
    } catch (e) {
      throw Exception('Error fetching forecast data: $e');
    }
  }
}
