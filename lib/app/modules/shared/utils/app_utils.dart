class AppUtils {
  static String formatDate(String date) {
    try {
      if (date.contains('-')) {
        var dateTime = DateTime.parse(date);
        return "${dateTime.day}/${dateTime.month}/${dateTime.year}";
      }
      return date;
    } on Exception catch (_) {
      return "";
    }
  }
}
