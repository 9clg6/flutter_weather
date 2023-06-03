import 'package:flutter/material.dart';
import 'package:flutter_weather/presentation/view_model/forecast_viewmodel.dart';
import 'package:provider/provider.dart';

class OtherWeatherPage extends StatefulWidget {
  const OtherWeatherPage({Key? key}) : super(key: key);

  @override
  State<OtherWeatherPage> createState() => _OtherWeatherPageState();
}

class _OtherWeatherPageState extends State<OtherWeatherPage> {
  final _cityTextController = TextEditingController();
  final _dateController = TextEditingController();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<ForecastViewModel>(context, listen: false).fetchForecast(days: 5);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Form(
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black),
                  borderRadius: BorderRadius.circular(20),
                ),
                padding: const EdgeInsetsDirectional.symmetric(horizontal: 10, vertical: 5),
                child: FractionallySizedBox(
                  widthFactor: 0.7,
                  child: TextFormField(
                    controller: _cityTextController,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: "Quelle ville ?",
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black),
                  borderRadius: BorderRadius.circular(20),
                ),
                padding: const EdgeInsetsDirectional.symmetric(horizontal: 10, vertical: 5),
                child: FractionallySizedBox(
                  widthFactor: 0.7,
                  child: TextFormField(
                    controller: _dateController,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: "Quel jour ?",
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Consumer<ForecastViewModel>(
          builder: (_, forecast, __) {
            if (forecast.forecastList != null && forecast.forecastList!.isNotEmpty) {
              return Expanded(
                child: SizedBox(
                  width: 400,
                  child: ListView.builder(
                    itemCount: forecast.forecastList!.length,
                    itemBuilder: (context, dayIndex) {
                      final currentDay = forecast.forecastList!.elementAt(dayIndex);
                      return Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(currentDay.date),
                          SizedBox(
                            height: 60,
                            child: ListView.separated(
                              shrinkWrap: true, // This is needed to make ListView take minimum possible space
                              scrollDirection: Axis.horizontal,
                              itemCount: currentDay.hour.length,
                              itemBuilder: (context, hourIndex) {
                                final currentHour = currentDay.hour.elementAt(hourIndex);
                                return Container(
                                  width: 80,
                                  height: 200,
                                  decoration: BoxDecoration(
                                    color: Theme.of(context).colorScheme.secondary,
                                  ),
                                  child: Center(
                                    child: Text(currentHour.tempC.toString()),
                                  ),
                                );
                              },
                              separatorBuilder: (context, index) {
                                return const SizedBox(width: 15);
                              },
                            ),
                          )
                        ],
                      );
                    },
                  ),
                ),
              );
            } else {
              return Text("C vide");
            }
          },
        ),
      ],
    );
  }
}
