import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/weather_model.dart';
import '../utils/constants.dart';

class WeatherService {

  Future<Weather> fetchWeather(String city) async {

    final url =
        "${AppConstants.baseUrl}?q=$city&appid=${AppConstants.apiKey}&units=metric";

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return Weather.fromJson(data);
    } else {
      throw Exception("Failed to load weather");
    }
  }
}