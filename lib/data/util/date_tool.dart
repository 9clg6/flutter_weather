import 'package:flutter_weather/domain/exception/week_day_exception.dart';
import 'package:flutter_weather/domain/exception/wrong_month_exception.dart';

String dateTimeToFrenchDate(DateTime date) {
  final weekDay = weekDayToWeekDayName(date.weekday);
  return "$weekDay ${date.day} ${monthNumberToMonthName(date.month)} ${date.year}";
}

String weekDayToWeekDayName(int weekDay) {
  return switch (weekDay) {
    1 => 'Lundi',
    2 => 'Mardi',
    3 => 'Mercredi',
    4 => 'Jeudi',
    5 => 'Vendredi',
    6 => 'Samedi',
    7 => 'Dimanche',
    _ => throw WeekDayException("Unknown weekday $weekDay"),
  };
}

String monthNumberToMonthName(int month) {
  return switch (month) {
    1 => 'Janvier',
    2 => 'Février',
    3 => 'Mars',
    4 => 'Avril',
    5 => 'Mai',
    6 => 'Juin',
    7 => 'Juillet',
    8 => 'Août',
    9 => 'Septembre',
    10 => 'Octobre',
    11 => 'Novembre',
    12 => 'Décembre',
    _ => throw WrongMonthException("Unknown month $month"),
  };
}
