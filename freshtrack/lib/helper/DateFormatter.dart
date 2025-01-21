import 'package:intl/intl.dart';

class DateTimeFormatter {
  static String formatDate(String date) {
    DateTime parsedDate = DateTime.parse(date.split('-').reversed.join('-'));
    String formattedDate =
        "${_monthNames[parsedDate.month]} ${parsedDate.day}, ${parsedDate.year}";
    return formattedDate;
  }

  static const List<String> _monthNames = [
    "",
    "January",
    "February",
    "March",
    "April",
    "May",
    "June",
    "July",
    "August",
    "September",
    "October",
    "November",
    "December"
  ];

  static formatTime(String time) {
    String t1 = time.split(":")[0];
    if (int.parse(t1) >= 12) {
      return "${time} pm";
    } else {
      return "${time} am";
    }
  }

  static List<String> findExpiry(List<dynamic> dateList) {
    List<String> products = [];
    DateTime currentTime = DateTime.now();

    for (dynamic item in dateList) {
      final String dateString = item["e_date"];
      final DateTime dateInput = DateFormat('MMMM dd, yyyy').parse(dateString);
      Duration duration = dateInput.difference(currentTime);

      if (duration.inDays >= 0 && duration.inDays < 5) {
        products.add(item["p_name"]);
      }
      print("Products is ${products}");
    }
    return products;
  }
}
