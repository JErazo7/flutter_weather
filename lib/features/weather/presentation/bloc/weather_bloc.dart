import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter_weather/features/weather/domain/entities/weather.dart';
import 'package:meta/meta.dart';

import 'package:flutter_weather/features/weather/domain/repositories/weather_repository.dart';
import './bloc.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final WeatherRepository weatherRepository;

  WeatherBloc({@required this.weatherRepository})
      : assert(weatherRepository != null);

  @override
  WeatherState get initialState => WeatherEmpty();

  @override
  Stream<WeatherState> mapEventToState(
    WeatherEvent event,
  ) async* {
    if (event is FetchWeather) {
      yield WeatherLoading();
      try {
        final Weather weather = await weatherRepository.getWeather(event.city);
        yield WeatherLoaded(weather: weather);
      } catch (error) {
        yield WeatherError(error.toString());
      }
    } else if (event is RefreshWeather) {
      try {
        final Weather weather = await weatherRepository.getWeather(event.city);
        yield WeatherLoaded(weather: weather);
      } catch (error) {
        yield WeatherError(error.toString());
      }
    }
  }
}
