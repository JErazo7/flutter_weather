import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:bloc/bloc.dart';

import 'features/simple_bloc_delegate.dart';
import 'features/theme/presentation/bloc/bloc.dart';
import 'features/weather/data/datasources/weather_api_client.dart';
import 'features/weather/data/repositories/weather_repository_impl.dart';
import 'features/weather/domain/repositories/weather_repository.dart';
import 'features/weather/presentation/bloc/bloc.dart';
import 'features/weather/presentation/pages/weather.dart';

void main() {
  BlocSupervisor.delegate = SimpleBlocDelegate();
  final WeatherRepository weatherRepository = WeatherRepositoryImpl(
    weatherApiClient: WeatherApiClient(
      httpClient: http.Client(),
    ),
  );

  runApp(
    BlocProvider(
      create: (context) => ThemeBloc(),
      child: App(weatherRepository: weatherRepository),
    ),
  );
}

class App extends StatelessWidget {
  final WeatherRepository weatherRepository;

  App({Key key, @required this.weatherRepository})
      : assert(weatherRepository != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, themeState) {
        return MaterialApp(
          title: 'Flutter Weather',
          theme: themeState.theme,
          home: BlocProvider(
            create: (context) =>
                WeatherBloc(weatherRepository: weatherRepository),
            child: Weather(),
          ),
        );
      },
    );
  }
}
