// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i3;
import 'package:flutter/material.dart' as _i4;
import 'package:flutter_weather/domain/entity/forecast.dart' as _i5;
import 'package:flutter_weather/presentation/view/forecast_detailed_day_page.dart'
    as _i1;
import 'package:flutter_weather/presentation/view/home_page.dart' as _i2;

abstract class $AppRouter extends _i3.RootStackRouter {
  $AppRouter({super.navigatorKey});

  @override
  final Map<String, _i3.PageFactory> pagesMap = {
    ForecastDetailedDayRoute.name: (routeData) {
      final args = routeData.argsAs<ForecastDetailedDayRouteArgs>();
      return _i3.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i1.ForecastDetailedDayPage(
          key: args.key,
          forecast: args.forecast,
          date: args.date,
        ),
      );
    },
    HomeRoute.name: (routeData) {
      return _i3.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i3.WrappedRoute(child: const _i2.HomePage()),
      );
    },
  };
}

/// generated route for
/// [_i1.ForecastDetailedDayPage]
class ForecastDetailedDayRoute
    extends _i3.PageRouteInfo<ForecastDetailedDayRouteArgs> {
  ForecastDetailedDayRoute({
    _i4.Key? key,
    required _i5.Forecast forecast,
    required String date,
    List<_i3.PageRouteInfo>? children,
  }) : super(
          ForecastDetailedDayRoute.name,
          args: ForecastDetailedDayRouteArgs(
            key: key,
            forecast: forecast,
            date: date,
          ),
          initialChildren: children,
        );

  static const String name = 'ForecastDetailedDayRoute';

  static const _i3.PageInfo<ForecastDetailedDayRouteArgs> page =
      _i3.PageInfo<ForecastDetailedDayRouteArgs>(name);
}

class ForecastDetailedDayRouteArgs {
  const ForecastDetailedDayRouteArgs({
    this.key,
    required this.forecast,
    required this.date,
  });

  final _i4.Key? key;

  final _i5.Forecast forecast;

  final String date;

  @override
  String toString() {
    return 'ForecastDetailedDayRouteArgs{key: $key, forecast: $forecast, date: $date}';
  }
}

/// generated route for
/// [_i2.HomePage]
class HomeRoute extends _i3.PageRouteInfo<void> {
  const HomeRoute({List<_i3.PageRouteInfo>? children})
      : super(
          HomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'HomeRoute';

  static const _i3.PageInfo<void> page = _i3.PageInfo<void>(name);
}
