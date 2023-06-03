import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_weather/data/util/date_tool.dart';
import 'package:flutter_weather/domain/entity/forecast.dart';
import 'package:flutter_weather/presentation/routing/app_router.gr.dart';

class ForecastList extends StatelessWidget {
  const ForecastList({
    super.key,
    required this.forecast,
  });

  final List<Forecast> forecast;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        final currentDay = forecast.elementAt(index);
        final parsedDate = DateTime.fromMillisecondsSinceEpoch(currentDay.dateEpoch * 1000);
        final frenchDate = dateTimeToFrenchDate(parsedDate);

        return InkWell(
          onTap: () {
            AutoRouter.of(context).push(
              ForecastDetailedDayRoute(
                forecast: currentDay,
                date: frenchDate,
              ),
            );
          },
          child: Container(
            height: 100,
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 25),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.tertiary,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      frenchDate,
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.background,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      "Température min: ${currentDay.day.minTempC} °C",
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.background,
                      ),
                    ),
                    Text(
                      "Température max: ${currentDay.day.maxTempC} °C",
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.background,
                      ),
                    ),
                  ],
                ),
                Image.network(currentDay.day.condition.icon.replaceFirst("//", "http://")),
              ],
            ),
          ),
        );
      },
      separatorBuilder: (context, index) => const SizedBox(height: 15),
      itemCount: forecast.length,
    );
  }
}
