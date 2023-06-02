import 'package:flutter/material.dart';
import 'package:flutter_weather/domain/usecase/get_current_location.dart';
import 'package:flutter_weather/domain/usecase/get_current_weather.dart';
import 'package:flutter_weather/presentation/view/home_page.dart';
import 'package:flutter_weather/presentation/view_model/weather_viewmodel.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: ChangeNotifierProvider(
        create: (context) => WeatherViewModel(
          GetCurrentWeather(),
          GetCurrentLocation(),
        ),
        child: const HomePage(),
      ),
    );
  }
}
