import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_weather/domain/usecase/get_current_location.dart';
import 'package:flutter_weather/domain/usecase/get_forecast_by_city_and_date.dart';
import 'package:flutter_weather/domain/usecase/get_forecast_by_location.dart';
import 'package:flutter_weather/presentation/routing/app_router.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  getIt.registerSingleton<GetCurrentLocation>(GetCurrentLocation());
  getIt.registerSingleton<GetForecastByLocation>(GetForecastByLocation());
  getIt.registerSingleton<GetForecastByCityAndDate>(GetForecastByCityAndDate());

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final _appRouter = AppRouter();

  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: _appRouter.config(),
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: FlexThemeData.light(
        scheme: FlexScheme.brandBlue,
        useMaterial3: true,
        textTheme: TextTheme(
          labelSmall: TextStyle(
            color: Theme.of(context).primaryColorDark,
          ),
        ),
      ).copyWith(
        navigationBarTheme: NavigationBarThemeData(
          labelTextStyle: MaterialStateProperty.all(
            const TextStyle(color: Colors.white),
          ),
        ),
      ),
      themeMode: ThemeMode.light,
    );
  }
}
