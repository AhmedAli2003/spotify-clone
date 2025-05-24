class DateHelper {
  const DateHelper._();

  /// Converts a token expiration string like '10d', '15m' to a future timestamp (in ms)
  static int getExpirationTimestamp(String expireIn) {
    final now = DateTime.now();

    final regex = RegExp(r'^(\d+)([smhd])$');
    final match = regex.firstMatch(expireIn.trim());

    if (match == null) {
      throw ArgumentError('Invalid expireIn format. Use formats like 10d, 15m, 3h, 30s.');
    }

    final int value = int.parse(match.group(1)!);
    final String unit = match.group(2)!;

    Duration duration;

    switch (unit) {
      case 's':
        duration = Duration(seconds: value);
        break;
      case 'm':
        duration = Duration(minutes: value);
        break;
      case 'h':
        duration = Duration(hours: value);
        break;
      case 'd':
        duration = Duration(days: value);
        break;
      default:
        throw ArgumentError('Unsupported time unit: $unit');
    }

    final expirationDate = now.add(duration);
    return expirationDate.millisecondsSinceEpoch;
  }
}
