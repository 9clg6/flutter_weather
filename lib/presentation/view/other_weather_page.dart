import 'package:flutter/material.dart';
import 'package:flutter_weather/domain/exception/no_location_found_exception.dart';
import 'package:flutter_weather/presentation/view_model/forecast_viewmodel.dart';
import 'package:flutter_weather/presentation/widget/detailed_forecast.dart';
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
    return Consumer<ForecastViewModel>(
      builder: (_, viewModel, __) {
        final current = viewModel.weatherData?.current;
        final forecast = viewModel.weatherData?.forecast;

        return Stack(
          children: [
            if (viewModel.weatherData != null) ...[
              DetailedForecast(
                location: viewModel.weatherData!.location,
                current: current!,
              ),
              _buildResetBtn(viewModel, context)
            ] else
              const Center(
                child: Text("Recherchez une ville dans la barre située ci-dessus."),
              ),
            Align(
              alignment: Alignment.topCenter,
              child: Column(
                children: [
                  _buildSearchBar(context),
                  if (_error != null) Text(_error!, style: const TextStyle(color: Colors.red))
                ],
              ),
            ),
          ],
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

  Align _buildResetBtn(ForecastViewModel viewModel, BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: InkWell(
          onTap: () {
            setState(() => viewModel.weatherData = null);
          },
          child: Container(
            width: 250,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.tertiary.withOpacity(0.5),
              borderRadius: BorderRadius.circular(20),
            ),
            padding: const EdgeInsetsDirectional.symmetric(horizontal: 10, vertical: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  Icons.delete_outline,
                  color: Theme.of(context).colorScheme.background,
                ),
                const SizedBox(width: 5),
                Text(
                  "Effacer la sélection",
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.background,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
