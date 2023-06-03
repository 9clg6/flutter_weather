import 'package:flutter/material.dart';
import 'package:flutter_weather/domain/exception/no_location_found_exception.dart';
import 'package:flutter_weather/presentation/view_model/forecast_viewmodel.dart';
import 'package:provider/provider.dart';

class OtherWeatherPage extends StatefulWidget {
  const OtherWeatherPage({Key? key}) : super(key: key);

  @override
  State<OtherWeatherPage> createState() => _OtherWeatherPageState();
}

class _OtherWeatherPageState extends State<OtherWeatherPage> {
  final _cityTextController = TextEditingController();
  bool _isArrowVisible = false;
  String? _error;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Align(
          alignment: Alignment.topCenter,
          child: Column(
            children: [
              Form(
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
                                ).fetchForecast(cityName: _cityTextController.text).onError((e, stackTrace) {
                                  setState(() => _error = (e as NoLocationFoundException).cause);
                                });
                              }
                            },
                          )
                      ],
                    ),
                  ),
                ),
              ),
              if (_error != null) Text(_error!, style: const TextStyle(color: Colors.red))
            ],
          ),
        ),
        _buildForecastByCity(context)
      ],
    );
  }

  Consumer<ForecastViewModel> _buildForecastByCity(BuildContext context) {
    return Consumer<ForecastViewModel>(
      builder: (_, viewModel, __) {
        if (viewModel.weatherData != null) {
          final current = viewModel.weatherData!.current;

          return Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "${viewModel.weatherData?.location.name}",
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                      ),
                    ),
                    Text(
                      "-",
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.secondary,
                        fontSize: 30,
                      ),
                    ),
                    Text(
                      "${viewModel.weatherData?.location.country}",
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.tertiary,
                        fontSize: 30,
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 5),
                Image.network(
                  current.condition.icon.replaceFirst("//", "http://"),
                  scale: 1 * 0.7,
                  errorBuilder: (context, error, stackTrace) {
                    return Icon(
                      Icons.error_outline,
                      color: Theme.of(context).colorScheme.secondary,
                    );
                  },
                ),
                Text(
                  current.condition.text,
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      current.tempC.toStringAsFixed(0),
                      style: TextStyle(
                        fontSize: 80,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Text(
                      "°C",
                      style: TextStyle(
                        fontSize: 50,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.tertiary,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Column(
                      children: [
                        SizedBox(
                          width: 120,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                "Vitesse du vent",
                                style: TextStyle(
                                  color: Theme.of(context).colorScheme.tertiary,
                                ),
                              ),
                              const SizedBox(height: 5),
                              Text(
                                "${current.windKph} km/h",
                                style: TextStyle(
                                  color: Theme.of(context).colorScheme.primary,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 25),
                        SizedBox(
                          width: 120,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                "Température ressentie",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Theme.of(context).colorScheme.tertiary,
                                ),
                              ),
                              const SizedBox(height: 5),
                              Text(
                                "${current.feelslikeC} °C",
                                style: TextStyle(
                                  color: Theme.of(context).colorScheme.primary,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(width: 35),
                    Column(
                      children: [
                        SizedBox(
                          width: 120,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                "Humidité",
                                style: TextStyle(
                                  color: Theme.of(context).colorScheme.tertiary,
                                ),
                              ),
                              const SizedBox(height: 5),
                              Text(
                                "${current.humidity} %",
                                style: TextStyle(
                                  color: Theme.of(context).colorScheme.primary,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 25),
                        SizedBox(
                          width: 120,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                "Pression",
                                style: TextStyle(
                                  color: Theme.of(context).colorScheme.tertiary,
                                ),
                              ),
                              const SizedBox(height: 5),
                              Text(
                                "${current.pressureMb.toStringAsFixed(0)} hPa",
                                style: TextStyle(
                                  color: Theme.of(context).colorScheme.primary,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                )
              ],
            ),
          );
        }
        return const Center(
          child: Text("Recherchez une ville dans la barre située ci-dessus."),
        );
      },
    );
  }
}
