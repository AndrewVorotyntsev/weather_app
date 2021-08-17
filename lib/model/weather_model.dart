import '../model/current_weather.dart';
import '../model/weather_forecast.dart';

class WeatherModel {

  CurrentWeather currentWeather;

  WeatherForecast weatherForecast;

  WeatherModel(this.currentWeather, this.weatherForecast);

  WeatherModel.empty() {
    this.currentWeather = CurrentWeather.empty();
    this.weatherForecast = WeatherForecast.empty();
    print("WeatherModel.empty()");
  }

}