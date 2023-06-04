import 'package:flutter_weather/data/util/date_tool.dart';
import 'package:flutter_weather/data/util/url_builder.dart';
import 'package:flutter_weather/domain/exception/url_params_exception.dart';
import 'package:flutter_weather/domain/exception/week_day_exception.dart';
import 'package:flutter_weather/domain/exception/wrong_month_exception.dart';
import 'package:test/test.dart';

main() {
  group('toolTest', () {
    test('paramBuilder', () {
      expect(() => buildUrlWithParams("http://google.com", {}),
          throwsA(isA<UrlParamsException>()));
      expect(() => buildUrlWithParams("http://google.com", null),
          throwsA(isA<UrlParamsException>()));

      String url = buildUrlWithParams(
        "http://google.com",
        {"test": "test"},
      );
      expect(url, "http://google.com?test=test");

      url = buildUrlWithParams(
        "http://google.com",
        {
          "test": "test",
          "test2": "test2",
        },
      );
      expect(url, "http://google.com?test=test&test2=test2");
    });

    test('dateTimeToFrenchDate', () {
      final date = DateTime(2023, 06, 03);
      final frenchDate = dateTimeToFrenchDate(date);
      expect(frenchDate, "Samedi 3 Juin 2023");
    });

    test('weekDayToWeekDayName', () {
      String weekDay = weekDayToWeekDayName(1);
      expect(weekDay, "Lundi");

      expect(() => weekDayToWeekDayName(9), throwsA(isA<WeekDayException>()));
    });

    test('monthNumberToMonthName', () {
      String month = monthNumberToMonthName(1);
      expect(month, "Janvier");

      expect(() => monthNumberToMonthName(15),
          throwsA(isA<WrongMonthException>()));
    });
  });
}
