import 'package:flutter/cupertino.dart';
import 'package:flutter_weather/features/weather/data/datasources/weather_api_client.dart';
import 'package:flutter_weather/features/weather/domain/entities/weather.dart';
import 'package:flutter_weather/features/weather/domain/repositories/weather_repository.dart';

class WeatherRepositoryImpl implements WeatherRepository {
  final WeatherApiClient weatherApiClient;

  WeatherRepositoryImpl({@required this.weatherApiClient})
      : assert(weatherApiClient != null);

  @override
  Future<Weather> getWeather(String city) async {
    final int locationId = await weatherApiClient.getLocationId(city);
    return await weatherApiClient.fetchWeather(locationId);
  }
}
