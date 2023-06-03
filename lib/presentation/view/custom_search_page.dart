import 'package:flutter/material.dart';
import 'package:flutter_weather/domain/exception/no_location_found_exception.dart';
import 'package:flutter_weather/presentation/view_model/forecast_viewmodel.dart';
import 'package:flutter_weather/presentation/widget/detailed_forecast.dart';
import 'package:flutter_weather/presentation/widget/forecast_list.dart';
import 'package:flutter_weather/presentation/widget/search_bar.dart';
import 'package:provider/provider.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  String? _error;

  @override
  void dispose() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<ForecastViewModel>(context, listen: false).weatherData = null;
    });
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ForecastViewModel>(
      builder: (_, viewModel, __) {
        final current = viewModel.weatherData?.current;
        final forecast = viewModel.weatherData?.forecast;

        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  children: [
                    CustomSearchBar(
                      endingOnTap: (String cityName) async {
                        _error = null;

                        Provider.of<ForecastViewModel>(
                          context,
                          listen: false,
                        )
                          ..weatherData = null
                          ..fetchForecast(cityName: cityName, days: 7).onError((error, stackTrace) {
                            setState(() => _error = (error as NoLocationFoundException).cause);
                          });
                      },
                    ),
                    if (_error != null)
                      Text(
                        _error!,
                        style: const TextStyle(color: Colors.red),
                      )
                  ],
                ),
                const SizedBox(height: 50),
                if (viewModel.weatherData != null) ...[
                  DetailedForecast(
                    location: viewModel.weatherData!.location,
                    forecast: forecast,
                    current: current!,
                  ),
                  const SizedBox(height: 50),
                  ForecastList(forecast: forecast!),
                  const SizedBox(height: 50),
                ] else
                  const Center(
                    child: Text("Recherchez une ville dans la barre située ci-dessus."),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}
