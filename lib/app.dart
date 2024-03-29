import 'package:bloc_weather/weather/view/weather_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc_weather/theme/theme.dart';
import 'package:bloc_weather/weather/weather.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weather_repository/weather_repository.dart';

class WeatherApp extends StatelessWidget {
  final WeatherRepository _weatherRepository;

  const WeatherApp({Key? key, required WeatherRepository weatherRepository})
      : _weatherRepository = weatherRepository,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: _weatherRepository,
      child: BlocProvider(
        create: (_) => ThemeCubit(),
        child: const WeatherAppView(),
      ),
    );
  }
}

class WeatherAppView extends StatelessWidget {
  const WeatherAppView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return BlocBuilder<ThemeCubit, Color>(builder: (context, color) {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: color,
          textTheme: GoogleFonts.rajdhaniTextTheme(),
          appBarTheme: AppBarTheme(
            titleTextStyle: GoogleFonts.rajdhaniTextTheme(textTheme)
                .apply(bodyColor: Colors.white)
                .headline6,
          ),
        ),
        home: const WeatherPage(),
      );
    });
  }
}
