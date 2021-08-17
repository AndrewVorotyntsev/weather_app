
// Data structure
class CurrentWeather {
  String city;

  double temp;
  double minTemp;
  double maxTemp;

  double humidity;
  double pressure;

  double windSpeed;
  double windDeg;

  double clouds;

  String description;

  CurrentWeather(
      this.city,
      this.temp,
      this.minTemp,
      this.maxTemp,
      this.humidity,
      this.pressure,
      this.windSpeed,
      this.windDeg,
      this.clouds,
      this.description,
      );

  CurrentWeather.empty({
    city: "",
    temp: 0,
    minTemp: 0,
    maxTemp: 0,
    humidity: 0,
    pressure: 0,
    windSpeed: 0,
    windDeg: 0,
    clouds: 0,
    description: "",
  });

}