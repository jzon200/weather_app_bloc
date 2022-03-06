import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_repository/weather_repository.dart';

import '../../search/search.dart';
import '../../settings/settings.dart';
import '../../theme/theme.dart';
import '../weather.dart';

class WeatherPage extends StatelessWidget {
  const WeatherPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => WeatherCubit(context.read<WeatherRepository>()),
      child: const WeatherView(),
    );
  }
}

class WeatherView extends StatelessWidget {
  const WeatherView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Weather'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              Navigator.of(context).push(SettingsPage.route(
                context.read<WeatherCubit>(),
              ));
            },
          ),
        ],
      ),
      body: BlocConsumer<WeatherCubit, WeatherState>(
        listener: (context, state) {
          if (state.status.isSuccess) {
            context.read<ThemeCubit>().updateTheme(state.weather);
          }
        },
        builder: (context, state) {
          switch (state.status) {
            case WeatherStatus.initial:
              return const WeatherEmpty();
            case WeatherStatus.loading:
              return const WeatherLoading();
            case WeatherStatus.success:
              return WeatherPopulated(
                weather: state.weather,
                units: state.temperatureUnits,
                onRefresh: () {
                  return context.read<WeatherCubit>().refreshWeather();
                },
              );
            case WeatherStatus.failure:
            default:
              return const WeatherError();
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.search),
        onPressed: () async {
          final city = await Navigator.of(context).push(SearchPage.route());
          await context.read<WeatherCubit>().fetchWeather(city);
        },
      ),
    );
  }
}
