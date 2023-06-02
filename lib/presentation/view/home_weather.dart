import 'package:flutter/material.dart';
import 'package:flutter_weather/presentation/view_model/weather_viewmodel.dart';
import 'package:provider/provider.dart';

class HomeWeather extends StatelessWidget {
  const HomeWeather({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Consumer<WeatherViewModel>(
          builder: (_, viewModel, __) {
            if (viewModel.weather != null) {
              return Text('Temperature: ${viewModel.weather?.tempC} °C');
            } else {
              viewModel.fetchWeatherWithLocation();
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
  }
}
