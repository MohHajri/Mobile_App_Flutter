import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:geolocator/geolocator.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class WeatherView extends StatefulWidget {
  const WeatherView({Key? key}) : super(key: key);

  @override
  _WeatherViewState createState() => _WeatherViewState();
}

class _WeatherViewState extends State<WeatherView> {
  // late final String _apiKey =
  //     '728709ca1ff2f3d42d627e0495718cb3'; // Replace with your OpenWeatherMap API key

  var _weatherData;

  Future<dynamic> _fetchWeatherData(double lat, double lon) async {
    // Get the API key from the .env file
    await dotenv.load(fileName: ".env"); // Load environment variables
    final String apiKey =
        dotenv.env['API_KEY']!; // Access the API key from the environment

    // Make the HTTP request
    final response = await http.get(Uri.parse(
        'https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$lon&appid=$apiKey&units=metric'));

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      var decodedData = jsonDecode(response.body);
      setState(() {
        _weatherData = decodedData;
      });
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load weather data');
    }
  }

  Future<void> _getLocationAndWeather() async {
    // First, get the user's current location
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    // Then, fetch the weather data for that location
    await _fetchWeatherData(position.latitude, position.longitude);
  }

  @override
  void initState() {
    super.initState();
    _getLocationAndWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Weather View'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {},
          ),
        ],
      ),
      body: Center(
        child: _weatherData == null
            ? const CircularProgressIndicator()
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '${_weatherData['name']}, ${_weatherData['sys']['country']}',
                    style: const TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  Text(
                    '${_weatherData['main']['temp']}°C',
                    style: const TextStyle(fontSize: 64.0),
                  ),
                  const SizedBox(height: 16.0),
                  Text(
                    '${_weatherData['weather'][0]['description']}',
                    style: const TextStyle(fontSize: 24.0),
                  ),
                ],
              ),
      ),
    );
  }
}
