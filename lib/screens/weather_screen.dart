import 'package:flutter/material.dart';
import '../models/weather_model.dart';
import '../services/weather_service.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {

  final TextEditingController cityController =
  TextEditingController(text: "London");

  final WeatherService weatherService = WeatherService();

  Weather? weather;
  bool isLoading = false;
  String error = "";

  Future<void> getWeather() async {
    setState(() {
      isLoading = true;
      error = "";
    });

    try {
      final result =
      await weatherService.fetchWeather(cityController.text);

      setState(() {
        weather = result;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        error = "Failed to load weather";
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Weather App")),

      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [

            /// City Input
            TextField(
              controller: cityController,
              decoration: const InputDecoration(
                labelText: "Enter City",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 15),

            /// Button
            ElevatedButton(
              onPressed: getWeather,
              child: const Text("Get Weather"),
            ),

            const SizedBox(height: 30),

            /// Loading
            if (isLoading)
              const CircularProgressIndicator(),

            /// Error
            if (error.isNotEmpty)
              Text(error, style: const TextStyle(color: Colors.red)),

            /// Weather Result
            if (weather != null)
              Card(
                elevation: 5,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Text(
                        weather!.cityName,
                        style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold),
                      ),

                      const SizedBox(height: 10),

                      Text(
                        "${weather!.temperature} °C",
                        style: const TextStyle(fontSize: 30),
                      ),

                      Text(weather!.description),

                      const SizedBox(height: 10),

                      Text("Humidity: ${weather!.humidity}%"),
                      Text("Wind: ${weather!.windSpeed} m/s"),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}