import 'package:bloc_weather/weather/weather.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);

  static Route route(WeatherCubit weatherCubit) {
    return MaterialPageRoute(
      builder: (_) => BlocProvider.value(
        value: weatherCubit,
        child: const SettingsPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: ListView(children: [
        BlocBuilder<WeatherCubit, WeatherState>(
          builder: (context, state) {
            return ListTile(
              title: const Text('Temperature Units'),
              isThreeLine: true,
              subtitle: const Text(
                'Use metric measurements for temperature units.',
              ),
              trailing: Switch(
                value: state.temperatureUnits.isCelsius,
                onChanged: (_) => context.read<WeatherCubit>().toggleUnits(),
              ),
            );
          },
        ),
      ]),
    );
  }
}
