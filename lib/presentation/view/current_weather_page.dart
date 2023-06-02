import 'package:flutter/material.dart';
import 'package:flutter_weather/presentation/view_model/weather_viewmodel.dart';
import 'package:provider/provider.dart';

class CurrentWeatherPage extends StatelessWidget {
  const CurrentWeatherPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Consumer<WeatherViewModel>(
          builder: (_, viewModel, __) {
            if (viewModel.weather != null) {
              return Column(
                children: [
                  Text('Temperature: ${viewModel.weather?.tempC} °C'),
                  Text('Température ressentie: ${viewModel.weather?.feelslikeC} °C'),
                  Text('Vitesse du vent: ${viewModel.weather?.windKph} kmh'),
                ],
              );
            } else {
              viewModel.fetchWeatherWithLocation();
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ],
    );
  }
}
