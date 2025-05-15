import 'dart:async';
import 'package:flutter/foundation.dart';

class GoRouterRefreshRx<T> extends ChangeNotifier {
  late final StreamSubscription _sub;

  GoRouterRefreshRx(Stream<T> stream) {
    _sub = stream.listen((_) {
      notifyListeners();
    });
  }

  @override
  void dispose() {
    super.dispose();
    _sub.cancel();
  }
}
