import 'package:intl/intl.dart';

class BanglaDateTimeFormatter {

  static const List<String> _bnMonths = [
    "জানুয়ারি","ফেব্রুয়ারি","মার্চ","এপ্রিল","মে","জুন",
    "জুলাই","আগস্ট","সেপ্টেম্বর","অক্টোবর","নভেম্বর","ডিসেম্বর"
  ];

  static const List<String> _bnDigits = [
    "০","১","২","৩","৪","৫","৬","৭","৮","৯"
  ];

  static String toBanglaNumber(String input) {
    String result = input;
    for (int i = 0; i < 10; i++) {
      result = result.replaceAll(i.toString(), _bnDigits[i]);
    }
    return result;
  }

  static String formatDate(String date) {
    DateTime dt = DateTime.parse(date);
    String day = toBanglaNumber(dt.day.toString());
    String month = _bnMonths[dt.month - 1];
    String year = toBanglaNumber(dt.year.toString());

    return "$day $month $year";
  }

  static String formatTime(String time) {
    final parsed = DateFormat("HH:mm:ss").parse(time);
    String formatted = DateFormat("h:mm a").format(parsed);

    // formatted = formatted
    //     .replaceAll("AM", "সকাল")
    //     .replaceAll("PM", "বিকাল");

    return toBanglaNumber(formatted);
  }



  static String? formatBanglaDateTime(String? date) {
    if (date == null || date.isEmpty) return null;

    final parsedDate = DateTime.parse(date);

    final formattedDate =
    DateFormat('dd MMMM yyyy', 'bn').format(parsedDate);


    return '$formattedDate ';
  }






}