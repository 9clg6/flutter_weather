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
  String? error;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Form(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Container(
              height: 50,
              width: 300,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black),
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
                      onChanged: (value) {
                        setState(() {
                          error = null;
                          if (value.isNotEmpty) {
                            _isArrowVisible = true;
                          } else {
                            _isArrowVisible = false;
                          }
                        });
                      },
                      decoration: InputDecoration(
                        icon: const Icon(Icons.search),
                        iconColor: Theme.of(context).colorScheme.primary,
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
                        Provider.of<ForecastViewModel>(
                          context,
                          listen: false,
                        ).fetchForecast(cityName: _cityTextController.text).onError((e, stackTrace) {
                          setState(() => error = (e as NoLocationFoundException).cause);
                        });
                      },
                    )
                ],
              ),
            ),
          ),
        ),
        if (error != null)
          Text(
            error!,
            style: TextStyle(color: Colors.red),
          )
      ],
    );
  }
}
