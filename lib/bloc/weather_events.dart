abstract class WeatherEvent {
}

class FetchWeatherEvent extends WeatherEvent {
  FetchWeatherEvent(this.city);
  final String city;
}