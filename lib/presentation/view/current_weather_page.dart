import 'package:flutter/material.dart';
import 'package:flutter_weather/presentation/view_model/weather_viewmodel.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class CurrentWeatherPage extends StatefulWidget {
  const CurrentWeatherPage({Key? key}) : super(key: key);

  @override
  State<CurrentWeatherPage> createState() => _CurrentWeatherPageState();
}

class _CurrentWeatherPageState extends State<CurrentWeatherPage> {
  final _refreshController = RefreshController(initialRefresh: false);

  @override
  Widget build(BuildContext context) {
    return SmartRefresher(
      header: const ClassicHeader(
        completeText: "La météo a été mise à jour ! ☀️",
      ),
      onRefresh: () async {
        Provider.of<WeatherViewModel>(context, listen: false).fetchWeatherWithLocation().then((_) {
          _refreshController.refreshCompleted();
        });
      },
      controller: _refreshController,
      child: Consumer<WeatherViewModel>(
        builder: (_, weatherViewModel, ___) {
          if (weatherViewModel.weather != null) {
            return Stack(
              children: [
                Align(
                  alignment: Alignment.topRight,
                  child: Icon(
                    Icons.sunny,
                    color: Colors.orangeAccent.withOpacity(0.1),
                    size: 700,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      _buildCard(context, weatherViewModel),
                      _buildListViewHoursCondition(weatherViewModel),
                    ],
                  ),
                ),
              ],
            );
          }
          return Text("");
        },
      ),
    );
  }

  Widget _buildListViewHoursCondition(WeatherViewModel weatherViewModel) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: SizedBox(
        height: 100,
        child: ListView.separated(
          padding: const EdgeInsetsDirectional.symmetric(vertical: 5),
          itemCount: weatherViewModel.weather!.forecast.first.hour.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, hourIndex) {
            final currentHour = weatherViewModel.weather!.forecast.first.hour.elementAt(hourIndex);
            final time = DateTime.parse(currentHour.time);

            return Container(
              width: 65,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.secondary,
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
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "${time.hour}h",
                    style: TextStyle(color: Theme.of(context).colorScheme.background),
                  ),
                  Text(
                    "${currentHour.tempC.toStringAsFixed(0)}°C",
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.background,
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            );
          },
          separatorBuilder: (context, index) {
            return const SizedBox(width: 10);
          },
        ),
      ),
    );
  }

  Padding _buildCard(BuildContext context, WeatherViewModel weatherViewModel) {
    final lastUpdate = weatherViewModel.weather?.current.lastUpdated;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15),
      child: Container(
        width: double.infinity,
        height: 150,
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 25),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.secondary,
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
                        'Ressenti: ${weatherViewModel.weather?.current.feelslikeC} °C',
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.background,
                          fontWeight: FontWeight.w500,
                          fontSize: 15,
                        ),
                      ),
                      Text(
                        'Vent: ${weatherViewModel.weather?.current.windKph} kmh',
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
                        "${weatherViewModel.weather?.current.tempC.toStringAsFixed(0)}°C",
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

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<WeatherViewModel>(context, listen: false).fetchWeatherWithLocation();
    });
    super.initState();
  }
}
