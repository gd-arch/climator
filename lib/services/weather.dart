
import 'dart:html';
import 'location.dart';
import 'networking.dart';

const apikey='11006def71c67cc8956abeea27bbbd44';
const openWeatherMapUrl='https://api.openweathermap.org/data/2.5/weather';
class WeatherModel {
  Future<dynamic> getWeatherData() async{

    Location location=Location();

    await location.getLocation();

    NetworkingHelper networkHelper=NetworkingHelper("$openWeatherMapUrl?lat=${location.lattitude}&lon=${location.longitude}&appid=$apikey&units=metric");
    var weatherData = await networkHelper.getData();
    return weatherData;

  }

  Future<dynamic>getCityWeather(String cityName) async{
    var url='$openWeatherMapUrl?q=$cityName&appid=$apikey&units=metric';
    NetworkingHelper networkingHelper=NetworkingHelper(url);
    var weatherData = await networkingHelper.getData();
    return weatherData;

}
  String getWeatherIcon(int condition) {
    if (condition < 300) {
      return '🌩';
    } else if (condition < 400) {
      return '🌧';
    } else if (condition < 600) {
      return '☔️';
    } else if (condition < 700) {
      return '☃️';
    } else if (condition < 800) {
      return '🌫';
    } else if (condition == 800) {
      return '☀️';
    } else if (condition <= 804) {
      return '☁️';
    } else {
      return '🤷‍';
    }
  }

  String getMessage(int temp) {
    if (temp > 35) {
      return 'It\'s 🍦 time';
    } else if (temp > 30) {
      return 'Time for shorts and 👕';
    } else if (temp < 15) {
      return 'You\'ll need 🧣 and 🧤';
    } else {
      return 'Bring a 🧥 just in case';
    }
  }
}
