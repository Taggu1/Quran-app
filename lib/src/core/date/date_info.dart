import 'package:shared_preferences/shared_preferences.dart';

import '../constants/keys.dart';
import '../utils/date_time_extentions.dart';

class DateInfo {
  final SharedPreferences sharedPreferences;

  DateInfo({
    required this.sharedPreferences,
  });

  bool isNewADay() {
    final currentDay = DateTime.now().toYearMonthDateString();
    final cashedDay = sharedPreferences.getString(currentDayKey);

    if (cashedDay == currentDay) {
      return false;
    } else {
      sharedPreferences.setString(currentDayKey, currentDay);
      return true;
    }
  }
}
