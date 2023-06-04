import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_weather/domain/entity/forecast.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

@RoutePage()
class ForecastDetailedDayPage extends StatelessWidget {
  final Forecast forecast;
  final String date;

  const ForecastDetailedDayPage({
    super.key,
    required this.forecast,
    required this.date,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          date,
          style: TextStyle(color: Theme.of(context).colorScheme.background),
        ),
        backgroundColor: Colors.transparent,
        shadowColor: null,
        leading: InkWell(
          onTap: AutoRouter.of(context).pop,
          child: Icon(
            Icons.close,
            color: Theme.of(context).colorScheme.background,
          ),
        ),
      ),
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: Scrollbar(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  _buildMinMaxRow(context),
                  const SizedBox(height: 25),
                  _buildSunRiseSunSet(context),
                  SizedBox(
                    width: 200,
                    child: Divider(
                      color: Theme.of(context).colorScheme.background,
                      height: 50,
                      thickness: 1,
                    ),
                  ),
                  _buildHours(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  ListView _buildHours() {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        final currentHour = forecast.hour.elementAt(index);
        final maxTemp = forecast.day.maxTempC;
        final hour =
            "${DateTime.fromMillisecondsSinceEpoch(currentHour.timeEpoch * 1000).hour}:00";

        return LinearPercentIndicator(
          lineHeight: 35,
          center: Text(
            "${currentHour.tempC.toStringAsFixed(0)} °C",
            style: TextStyle(
              color: Theme.of(context).colorScheme.primary,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          percent: currentHour.tempC / maxTemp,
          backgroundColor: Theme.of(context).colorScheme.background,
          progressColor: Theme.of(context).colorScheme.secondary,
          barRadius: const Radius.circular(20),
          animation: true,
          curve: Curves.bounceOut,
          animationDuration: 1500,
          leading: Text(
            hour,
            style: TextStyle(
              color: Theme.of(context).colorScheme.background,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        );
      },
      separatorBuilder: (context, index) => const SizedBox(height: 25),
      itemCount: forecast.hour.length,
    );
  }

  Column _buildSunRiseSunSet(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(
            vertical: 15,
            horizontal: 30,
          ),
          decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: Theme.of(context).colorScheme.background,
            ),
          ),
          child: Row(
            children: [
              Icon(
                Icons.sunny,
                color: Theme.of(context).colorScheme.background,
                size: 35,
              ),
              const SizedBox(width: 30),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Levé du soleil",
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.background,
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      forecast.astro.sunrise,
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.background,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 15),
        Container(
          padding: const EdgeInsets.symmetric(
            vertical: 15,
            horizontal: 30,
          ),
          decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: Theme.of(context).colorScheme.background,
            ),
          ),
          child: Row(
            children: [
              Icon(
                Icons.sunny_snowing,
                color: Theme.of(context).colorScheme.background,
                size: 35,
              ),
              const SizedBox(width: 30),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Couché du soleil",
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.background,
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      forecast.astro.sunset,
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.background,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildMinMaxRow(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 15,
        horizontal: 30,
      ),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.background,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Column(
            children: [
              Text(
                "Minimale: ",
                style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                  fontSize: 16,
                ),
              ),
              Text(
                "${forecast.day.minTempC} °C",
                style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 30,
            child: VerticalDivider(
              color: Theme.of(context).colorScheme.primary,
              thickness: 1,
            ),
          ),
          Column(
            children: [
              Text(
                "Maximale: ",
                style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                  fontSize: 16,
                ),
              ),
              Text(
                "${forecast.day.maxTempC} °C",
                style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
