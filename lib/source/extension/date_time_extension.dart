//
//  date_time_extension.dart
//  Inspire
//
//  Created by Vivekanandh Rao on 29/12/2023.
//  Copyright © 2023 Allianz. All rights reserved.
//

import 'package:flutter/material.dart';
import 'package:flutter_ui_helper/flutter_ui_helper.dart';
import 'package:intl/intl.dart';

class DateTimeFormat {
  static const String dayInNumber = 'dd';
  static const String monthInNumber = 'MM';
  static const String monthPattern = 'MMM';
  static const String monthAndYear = 'MMM yyyy';
  static const String fullMonthAndYear = 'MMMM yyyy';
  static const String yearAndMonth = 'yyyy-MM';

  static const String time = 'HH:mm:ss';
  static const String dateWithTime = 'dd/MM/yyyy  H:mm';
  static const String dateWithHyphenAndTime = 'dd-MM-yyyy HH:mm:ss';
  static const String displayTime = 'h:mm a';

  static const String date = 'dd/MM/yyyy';
  static const String dateWithVeryShortYear = 'yy-MM-dd';
  static const String dateWithShortYear = 'yyy-MM-dd';
  static const String dateWithSpace = 'dd MM yyyy';
  static const String dateWithHyphen = 'dd-MM-yyyy';
  static const String dateWithShortMonthSymbols = 'dd/MMM/yyyy';
  static const String dateWithShortMonthSymbolsAndSpaceDivider = 'dd MMM yyyy';
  static const String dateWithFullMonthSymbols = 'dd MMMM yyyy';
  static const String dateWithFullMonthSymbolAndTime = 'dd MMMM yyyy, HH:mm:ss';

  static const String dateWitShortMonthAndTime = 'MMM dd, yyyy h:mm a';

  static const String dateWithWeek = 'EEEE, dd MMM yyyy';
  static const String dateWithWeekAndFullMonth = 'EEE, dd MMMM yyyy';
  static const String dateWithFullWeekAndFullMonth = 'EEEE, dd MMMM yyyy';

  static const String serverDateFormat = 'yyyy-MM-dd';
  static const String serverDateFormat2 = 'yyyy/MM/dd';
  static const String serverDateFormat3 = 'yy/MM/dd';
  static const String serverDateFormatWithTime = 'yyyy-MM-dd HH:mm:ss';
  static const String serverDateFormatWithTime2 = 'yyyy/MM/dd HH:mm';

  static const String dateForFilePath = '_dd-MM-yyyy_HH-mm-ss';
}

extension DateTimeExtension on DateTime {
  bool isGreater(DateTime date) => isAfter(date);

  bool isLess(DateTime date) => isBefore(date);

  bool isEqual(DateTime date) => isAtSameMomentAs(date);

  static DateTime? getDateFromString(String dateString, {required String format}) {
    try {
      return DateFormat(format).parse(dateString);
    } catch (e) {
      DebugPrint.error("Error parsing date: $e");
      return null;
    }
  }

  static TimeOfDay createTimeOfDayFromString(String timeString) {
    List<String> parts = timeString.split(':');
    int hours = int.tryParse(parts[0]) ?? 0;
    int minutes = int.tryParse(parts[1]) ?? 0;
    return TimeOfDay(hour: hours, minute: minutes);
  }

  DateTime localDate() {
    DateTime nowUTC = DateTime.now().toUtc();
    Duration timeZoneOffset = nowUTC.timeZoneOffset;
    DateTime localDateTime = nowUTC.add(timeZoneOffset);

    return localDateTime;
  }

  bool checkDayAndMonthAreSameWith(DateTime date) {
    return day == date.day && month == date.month;
  }

  bool checkDayMonthAndYearAreSameWith(DateTime date) {
    return day == date.day && month == date.month && year == date.year;
  }

  DateTime convertToCurrentYearDate() {
    return DateTime(DateTime.now().year, month, day);
  }

  DateTime getMonthStartDate() {
    return DateTime(year, month, 1);
  }

  DateTime getMonthEndDate() {
    final lastDay = DateTime(year, month + 1, 0).day;
    return DateTime(year, month, lastDay);
  }

  int getNumberOfWeeksPerMonth() {
    final endOfMonth = getMonthEndDate();
    return weekNumber(endOfMonth);
  }

  String convertToString(String formatType, [String? localeIdentifier]) {
    final formatter = DateFormat(formatType, localeIdentifier);
    return formatter.format(this);
  }

  DateTime getDateByAddingYears(int years) {
    return add(Duration(days: 365 * years));
  }

  DateTime getDateByAddingDays(int days) {
    return add(Duration(days: days));
  }

  String getYearInStringFormat() {
    return year.toString();
  }

  String getYearWithSuffix() {
    return year.toString().substring(2);
  }

  int getNearestAge() {
    final diff = DateTime.now().difference(this).inDays;
    return (diff / 365.25).round();
  }

  int getActualAge() {
    final diff = DateTime.now().difference(this).inDays;
    return (diff / 365.25).floor();
  }

  static int weekNumber(DateTime date) {
    final firstDayOfYear = DateTime(date.year, 1, 1);
    final days = date.difference(firstDayOfYear).inDays;
    return (days / 7).ceil();
  }
}
