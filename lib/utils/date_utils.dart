import 'package:intl/intl.dart';

class AppDateUtils {
  static String daysBetween(String postedAt) {
    var from = DateTime.parse(postedAt);
    var to = DateTime.now();
    int seconds = to.difference(from).inSeconds;
    String date = DateFormat("dd/MM/yy").format(from);
    String time = DateFormat("HH:mm").format(from);
    String difference = (to.difference(from).inDays).toString();

    if (seconds >= 24 * 3600)  return '$difference days ago';
    int interval = (seconds / 3600).floor();
    if (interval >= 1)  return '$interval hours ago';
    interval = (seconds / 60).floor();
    if (interval >= 1) return '$interval minutes ago';

    return '${(seconds).floor()} seconds ago';
  }
}