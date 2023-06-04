import 'dart:io';

import 'package:flutter_weather/data/data_sources/weather_remote_datasource_impl.dart';
import 'package:flutter_weather/domain/entity/weather_data.dart';
import 'package:http/http.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import 'repository_tests.mocks.dart';

@GenerateNiceMocks([MockSpec<Client>()])
main() {
  group("repositories_test", () {
    final mockClient = MockClient();

    test("weather_remote_data_source.getForecastByCityAndDate()", () async {
      final weatherRemoteDataSourceImpl = WeatherRemoteDataSourceImpl();
      const cityToTest = "Lyon";
      final dateToTest = DateTime.parse("2023-06-04");

      const url =
          "http://api.weatherapi.com/v1/forecast.json?key=56b193ed76a34495b62124011230206&alerts=no&aqi=no&q=Lyon&dt=2023/6/4&lang=fr";
      final response = File('test/repository/response/get_forecast_by_city_and_name_200.json').readAsStringSync();

      when(mockClient.get(Uri.parse(url), headers: anyNamed('headers'))).thenAnswer(
        (_) async => Response(response, 200),
      );

      final weatherData =
          await weatherRemoteDataSourceImpl.getForecastByCityAndDate(cityToTest, dateToTest, mockClient);

      expect(weatherData, isA<WeatherData>());
    });
  });
}
