import 'package:flutter/cupertino.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:clima/services/location.dart';
import 'package:clima/services/networking.dart';

const apiKey = '3337086a905d8d925c074b59a2e5def2';

class WeatherModel {
  Future<dynamic> getCityWeather(cityName) async {
    String url =
        'https://api.openweathermap.org/data/2.5/weather?q=$cityName&units=metric&appid=$apiKey';
    Network networkhelper = Network(url);
    var weatherData = await networkhelper.getData();
    return weatherData;
  }

  Future<dynamic> getWeatherData() async {
    Location location = Location();
    await location.getCurrentLocation();
    double latitude = location.latitude;
    double longitude = location.longitude;
    print(latitude);
    print(longitude);
    String url =
        'https://api.openweathermap.org/data/2.5/weather?lat=$latitude&lon=$longitude&units=metric&appid=$apiKey';
    Network networkhelper = Network(url);
    var weatherData = await networkhelper.getData();
    return weatherData;
  }

  IconData getWeatherIcon(int condition) {
    if (condition < 300) {
      return FlutterIcons.wi_thunderstorm_wea;
    } else if (condition < 400) {
      return FlutterIcons.wi_raindrops_wea;
    } else if (condition < 600) {
      return FlutterIcons.wi_rain_wea;
    } else if (condition < 700) {
      return FlutterIcons.wi_day_snow_wea;
    } else if (condition < 800) {
      return FlutterIcons.wi_fog_wea;
    } else if (condition == 800) {
      return FlutterIcons.wi_wu_clear_wea;
    } else if (condition <= 804) {
      return FlutterIcons.wi_cloud_wea;
    } else {
      return FlutterIcons.weather_night_mco;
    }
  }

  String getMessage(int temp) {
    if (temp > 25) {
      return 'It\'s 🍦 time';
    } else if (temp > 20) {
      return 'Time for shorts and 👕';
    } else if (temp < 10) {
      return 'You\'ll need 🧣 and 🧤';
    } else {
      return 'Bring a 🧥 just in case';
    }
  }
}
