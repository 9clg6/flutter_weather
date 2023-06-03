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
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Consumer<WeatherViewModel>(
            builder: (_, weatherViewModel, ___) {
              return Column(
                children: [
                  Text("${weatherViewModel.weather?.$2.name}"),
                  Text("Dernière mise à jour: ${weatherViewModel.weather!.$2.localtime}"),
                  Text('Temperature: ${weatherViewModel.weather?.$1.tempC} °C'),
                  Text('Température ressentie: ${weatherViewModel.weather?.$1.feelslikeC} °C'),
                  Text('Vitesse du vent: ${weatherViewModel.weather?.$1.windKph} kmh'),
                ],
              );
            },
          ),
        ],
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
