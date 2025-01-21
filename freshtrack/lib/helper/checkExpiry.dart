import 'package:intl/intl.dart';

class CheckExpiry{

  //* check if product expiry date has crossed or not
  static bool checkExpiry(String Date){
    final dateFormat = DateFormat('MMMM dd, yyyy');

    final date = dateFormat.parse(Date);
    final currentDate = DateTime.now();

    return date.isBefore(currentDate);
  }
}