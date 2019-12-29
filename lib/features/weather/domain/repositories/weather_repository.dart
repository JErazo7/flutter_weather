import 'package:flutter_weather/features/weather/domain/entities/weather.dart';

abstract class WeatherRepository {
  Future<Weather> getWeather(String city);
}
