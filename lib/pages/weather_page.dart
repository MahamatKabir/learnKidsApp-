import 'package:flutter/material.dart';
import '../models/weather_model.dart';
import '../services/weather_service.dart';

class WeatherPages extends StatefulWidget {
  const WeatherPages({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _WeatherPagesState createState() => _WeatherPagesState();
}

class _WeatherPagesState extends State<WeatherPages> {
  // api key
  final _weatherService = WeatherService('b189627ac060851d687c8238f9c5457c');
  Weather? _weather;

  @override
  void initState() {
    super.initState();
    _fetchWeather();
  }

  // fetch weather
  _fetchWeather() async {
    // get the current city
    String cityName = await _weatherService.getCurrentCity();
    // get weather for city
    try {
      final weather = await _weatherService.getWeather(cityName);
      setState(() {
        _weather = weather;
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(_weather?.cityName ?? "Loading city..."),
            Text("${_weather?.temperature.round()}°C"),
          ],
        ),
      ),
    );
  }
}
