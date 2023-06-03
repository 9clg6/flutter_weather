import 'package:flutter/material.dart';
import 'package:flutter_weather/presentation/view_model/weather_viewmodel.dart';

class CurrentWeatherCard extends StatelessWidget {
  final WeatherViewModel weatherViewModel;

  const CurrentWeatherCard({
    super.key,
    required this.weatherViewModel,
  });

  @override
  Widget build(BuildContext context) {
    final lastUpdate = weatherViewModel.weather?.current?.lastUpdated;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15),
      child: Container(
        width: double.infinity,
        height: 150,
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 25),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.tertiary,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 1,
              spreadRadius: 2,
              offset: const Offset(-2, 2),
            )
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              flex: 2,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "${weatherViewModel.weather?.location.name} - ${weatherViewModel.weather?.location.country}",
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.background,
                          fontWeight: FontWeight.w500,
                          fontSize: 15,
                        ),
                      ),
                      Text(
                        'Ressenti: ${weatherViewModel.weather?.current?.feelslikeC} °C',
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.background,
                          fontWeight: FontWeight.w500,
                          fontSize: 15,
                        ),
                      ),
                      Text(
                        'Vent: ${weatherViewModel.weather?.current?.windKph} kmh',
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.background,
                          fontWeight: FontWeight.w500,
                          fontSize: 15,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "${weatherViewModel.weather?.current?.tempC.toStringAsFixed(0)}°C",
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.background,
                          fontWeight: FontWeight.w600,
                          fontSize: 45,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Text(
              "Dernière mise à jour: ${lastUpdate?.hour}:${lastUpdate?.minute}",
              style: TextStyle(color: Theme.of(context).colorScheme.background.withOpacity(0.7)),
            )
          ],
        ),
      ),
    );
  }
}
