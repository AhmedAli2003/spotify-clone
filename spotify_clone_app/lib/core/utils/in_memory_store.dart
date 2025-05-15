import 'package:rxdart/rxdart.dart';

class InMemoryStore<T> {
  final BehaviorSubject<T> _subject;

  InMemoryStore(T initialValue) : _subject = BehaviorSubject.seeded(initialValue);

  /// Expose stream to listen to changes
  Stream<T> get stream => _subject.stream;

  /// Get current value
  T get value => _subject.value;

  /// Update value
  set value(T newValue) => _subject.add(newValue);

  /// Dispose the subject
  void dispose() {
    _subject.close();
  }
}
