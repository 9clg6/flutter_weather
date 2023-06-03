import 'package:flutter/material.dart';
import 'package:flutter_weather/data/util/date_tool.dart';
import 'package:flutter_weather/domain/exception/no_location_found_exception.dart';
import 'package:flutter_weather/presentation/view_model/forecast_viewmodel.dart';
import 'package:flutter_weather/presentation/widget/detailed_forecast.dart';
import 'package:provider/provider.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final _cityTextController = TextEditingController();
  bool _isArrowVisible = false;
  String? _error;
  final _formKey = GlobalKey<FormState>();

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
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _buildSearchBar(context),
                    if (_error != null) Text(_error!, style: const TextStyle(color: Colors.red))
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
                  ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      final currentDay = forecast.elementAt(index);
                      final parsedDate = DateTime.fromMillisecondsSinceEpoch(currentDay.dateEpoch * 1000);
                      final frenchDate = dateTimeToFrenchDate(parsedDate);

                      return Container(
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
                      );
                    },
                    separatorBuilder: (context, index) => const SizedBox(height: 15),
                    itemCount: forecast!.length,
                  ),
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

  Form _buildSearchBar(BuildContext context) {
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Container(
          height: 50,
          width: 300,
          decoration: BoxDecoration(
            border: Border.all(color: Theme.of(context).colorScheme.primary),
            borderRadius: BorderRadius.circular(20),
          ),
          padding: const EdgeInsetsDirectional.symmetric(horizontal: 10, vertical: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: 200,
                child: TextFormField(
                  controller: _cityTextController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Merci d'insérer le nom d'une ville";
                    }
                    return null;
                  },
                  onChanged: (value) {
                    setState(() {
                      _error = null;
                      if (value.isNotEmpty) {
                        _isArrowVisible = true;
                      } else {
                        _isArrowVisible = false;
                      }
                    });
                  },
                  decoration: InputDecoration(
                    icon: const Icon(Icons.search),
                    iconColor: Theme.of(context).colorScheme.tertiary,
                    border: InputBorder.none,
                    hintText: "Rechercher une ville",
                  ),
                ),
              ),
              if (_isArrowVisible)
                InkWell(
                  child: Icon(
                    Icons.arrow_forward,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  onTap: () {
                    if (_formKey.currentState != null && _formKey.currentState!.validate()) {
                      Provider.of<ForecastViewModel>(
                        context,
                        listen: false,
                      ).fetchForecast(cityName: _cityTextController.text, days: 7).onError((e, stackTrace) {
                        setState(() => _error = (e as NoLocationFoundException).cause);
                      });
                    }
                  },
                )
            ],
          ),
        ),
      ),
    );
  }
}
