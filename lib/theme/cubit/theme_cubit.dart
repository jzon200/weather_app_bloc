import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

import '../../weather/weather.dart';

class ThemeCubit extends HydratedCubit<Color> {
  static const defaultColor = Color(0xFF2196F3);
  ThemeCubit() : super(defaultColor);

  void updateTheme(Weather? weather) {
    if (weather != null) emit(weather.toColor);
  }

  @override
  Color fromJson(Map<String, dynamic> json) =>
      Color(int.parse(json['color'] as String));

  @override
  Map<String, dynamic> toJson(Color state) =>
      <String, String>{'color': '${state.value}'};
}

extension on Weather {
  Color get toColor {
    switch (condition) {
      case WeatherCondition.clear:
        return Colors.orangeAccent;
      case WeatherCondition.rainy:
        return Colors.indigoAccent;
      case WeatherCondition.cloudy:
        return Colors.blueGrey;
      case WeatherCondition.snowy:
        return Colors.lightBlueAccent;
      case WeatherCondition.unknown:
      default:
        return ThemeCubit.defaultColor;
    }
  }
}
