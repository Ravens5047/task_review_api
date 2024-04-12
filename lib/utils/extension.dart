import 'package:intl/intl.dart';

extension ExString on String? {
  String get toDateTime {
    try {
      return DateFormat('M/d/yyyy h:mm a', 'en_US')
          .format(DateTime.parse(this ?? '').toLocal());
    } on FormatException {
      return '--:--';
    }
  }
}
