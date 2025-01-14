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

  static formatTime(String time){
    String t1 = time.split(":")[0];
    if(int.parse(t1)>=12){
      return "${time} pm";
    }else{
      return "${time} am";
    }
  }
}

